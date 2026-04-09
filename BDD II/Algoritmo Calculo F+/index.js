const parseFDs = (text) => {
	return text
		.trim()
		.split("\n")
		.filter((line) => line.trim() !== "")
		.map((line) => {
			const [lhsStr, rhsStr] = line.split("->");
			return {
				lhs: lhsStr
					.split(",")
					.map((s) => s.trim())
					.filter(Boolean),
				rhs: rhsStr
					.split(",")
					.map((s) => s.trim())
					.filter(Boolean),
			};
		});
};

const parseAttrs = (text) =>
	text
		.split(",")
		.map((s) => s.trim())
		.filter(Boolean);

const formatFDs = (fds) =>
	fds.map((fd) => `{${fd.lhs.join(", ")}} → {${fd.rhs.join(", ")}}`).join("\n");

const haveSameElements = (arr1, arr2) => {
	if (arr1.length !== arr2.length) return false;
	return (
		arr1.every((e) => arr2.includes(e)) && arr2.every((e) => arr1.includes(e))
	);
};

const calculateClosure = (attributes, setOfFDs) => {
	let closure = [...attributes];
	let change;
	do {
		change = false;
		let closureBefore = [...closure];
		for (let i = 0; i < setOfFDs.length; i++) {
			let dep = setOfFDs[i];
			if (dep.lhs.every((attr) => closure.includes(attr))) {
				if (!closure.includes(dep.rhs[0])) {
					closure.push(...dep.rhs);
				}
			}
			change = haveSameElements(closureBefore, closure) ? false : true;
		}
	} while (change);
	return closure;
};

const splitRHS = (setOfFDs) => {
	let result = [];
	for (let fd of setOfFDs) {
		if (fd.rhs.length === 1) {
			result.push(fd);
		} else {
			for (let attr of fd.rhs) {
				result.push({ lhs: [...fd.lhs], rhs: [attr] });
			}
		}
	}
	return result;
};

const removeExtraneousAttributes = (setOfFDs) => {
	let result = [...setOfFDs];
	for (let i = 0; i < setOfFDs.length; i++) {
		let originalDep = result.find(
			(dep) =>
				haveSameElements(dep.lhs, setOfFDs[i].lhs) &&
				haveSameElements(dep.rhs, setOfFDs[i].rhs),
		);
		for (let j = 0; j < setOfFDs[i].lhs.length; j++) {
			let withoutAttr = setOfFDs[i].lhs.filter((_, idx) => idx !== j);
			let newClosure = calculateClosure(withoutAttr, setOfFDs);
			if (setOfFDs[i].rhs.every((attr) => newClosure.includes(attr))) {
				result = result.filter(
					(dep) =>
						!haveSameElements(originalDep.rhs, dep.rhs) ||
						!haveSameElements(originalDep.lhs, dep.lhs),
				);
				let newDep = { lhs: [...withoutAttr], rhs: [...setOfFDs[i].rhs] };
				if (
					!result.find(
						(dep) =>
							haveSameElements(newDep.lhs, dep.lhs) &&
							haveSameElements(newDep.rhs, dep.rhs),
					)
				)
					result.push(newDep);
			}
		}
	}
	return result;
};

const noRedundantDependencies = (setOfFDs) => {
	let result = [...setOfFDs];
	for (let i = 0; i < setOfFDs.length; i++) {
		let current = result.find(
			(dep) =>
				haveSameElements(dep.lhs, setOfFDs[i].lhs) &&
				haveSameElements(dep.rhs, setOfFDs[i].rhs),
		);
		if (!current) continue;
		let withoutCurrent = result.filter(
			(dep) =>
				!haveSameElements(dep.lhs, current.lhs) ||
				!haveSameElements(dep.rhs, current.rhs),
		);
		let newClosure = calculateClosure(current.lhs, withoutCurrent);
		if (newClosure.includes(current.rhs[0])) {
			result = withoutCurrent;
		}
	}
	return result;
};

const minimalCover = (setOfFDs) => {
	let fds = splitRHS(setOfFDs);
	fds = removeExtraneousAttributes(fds);
	fds = noRedundantDependencies(fds);
	return fds;
};

const getSubsets = (arr) => {
	if (arr.length === 0) return [[]];
	let first = arr[0];
	let rest = arr.slice(1);
	let without = getSubsets(rest);
	let with_ = without.map((s) => [first, ...s]);
	return [...without, ...with_];
};

const getCandidateKeys = (schema, setOfFDs) => {
	let base = [],
		possibleAdditions = [];
	for (let attr of schema) {
		let inLHS = setOfFDs.some((fd) => fd.lhs.includes(attr));
		let inRHS = setOfFDs.some((fd) => fd.rhs.includes(attr));
		if (inLHS && !inRHS) base.push(attr);
		else if (inLHS && inRHS) possibleAdditions.push(attr);
	}

	if (haveSameElements(calculateClosure(base, setOfFDs), schema)) return [base];

	let subsets = getSubsets(possibleAdditions).filter((s) => s.length !== 0);
	let candidateKeys = [];

	for (let subset of subsets) {
		let combo = [...base, ...subset];
		let closure = calculateClosure(combo, setOfFDs);
		if (haveSameElements(closure, schema)) {
			let isMinimal = !candidateKeys.some((ck) =>
				ck.every((attr) => combo.includes(attr)),
			);
			if (isMinimal) candidateKeys.push(combo);
		}
	}
	return candidateKeys;
};

const getFDs = () => {
	try {
		return parseFDs(document.getElementById("fds-input").value);
	} catch (e) {
		return null;
	}
};

const runClosure = () => {
	const fds = getFDs();
	const attrs = parseAttrs(document.getElementById("closure-attrs").value);
	if (!fds || attrs.length === 0) {
		document.getElementById("closure-result").textContent =
			"Please enter FDs and attributes.";
		return;
	}
	const split = splitRHS(fds);
	const closure = calculateClosure(attrs, split);
	document.getElementById("closure-result").textContent =
		`{${attrs.join(", ")}}⁺ = {${closure.join(", ")}}`;
};

const runMinimalCover = () => {
	const fds = getFDs();
	if (!fds) {
		document.getElementById("minimal-result").textContent = "Please enter FDs.";
		return;
	}
	const result = minimalCover(fds);
	document.getElementById("minimal-result").textContent = formatFDs(result);
};

const runCandidateKeys = () => {
	const fds = getFDs();
	const schema = parseAttrs(document.getElementById("schema-input").value);
	if (!fds || schema.length === 0) {
		document.getElementById("keys-result").textContent =
			"Please enter FDs and schema.";
		return;
	}
	const split = splitRHS(fds);
	const keys = getCandidateKeys(schema, split);
	if (keys.length === 0) {
		document.getElementById("keys-result").textContent =
			"No candidate keys found.";
	} else {
		document.getElementById("keys-result").textContent = keys
			.map((k) => `{${k.join(", ")}}`)
			.join("\n");
	}
};
