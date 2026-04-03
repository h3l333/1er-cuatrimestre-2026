// A canonical or minimal cover in DBMS is the simplest set of functional dependencies equivalent to
// a given set.
// It is found by splitting right-hand sides, removing redundant functional dependencies
// and eliminating extraneous left-hand attributes.
//
// - Examples of redundant dependencies: In {A -> B, B -> C, A -> C} 'A -> C' is redundant.
// - It is determined if a left-hand attribute is extraneous by checking the
// attributes that each individual attribute on the LHS determines.

// A set of FDs is defined as an array of objects that encompass the attributes
// LHS and RHS. Each attribute holds the value of an array of chars representing attributes.
const setOfFDs = [
	{ lhs: ["A", "C"], rhs: ["D"] },
	{ lhs: ["A"], rhs: ["D"] },
	{ lhs: ["B"], rhs: ["H"] },
	{ lhs: ["B", "D"], rhs: ["C", "F"] },
];

const haveSameElements = (arr1, arr2) => {
	// Receives and compares two arrays
	let match = true;
	for (
		let i = 0;
		i < arr2.length;
		i++ // Iterate through arr2's elements
	) // Does arr1 include all the elements in arr2?
	{
		match = match && arr1.includes(arr2[i]);
	}

	for (let j = 0; j < arr1.length; j++) {
		match = match && arr2.includes(arr1[j]);
	}
	return match;
};

let arr1 = [1, 2, 3];
let arr2 = [3, 1, 4, 2];

console.log(haveSameElements(arr1, arr2));

console.log();
/*
const calculateClosure = (attributes, setOfFDs) => {
	// Receives an array of chars representing a set of attributes and an array of
	// objects representing a set of FDs
	let closure = [...attributes]; // Example: AB -> A, AB -> B
	for(let i = 0; i < setOfFDs.length; i++) // Traverse each FD within the set
	{
		let currentDependency = setOfFDs[i];
		if(haveSameElements(currentDependency[i].lhs, attributes)) // Check that the lhs of a dependency matches the passed attributes 
	}
};

const removeExtraneousAttributes = (setOfFDs) => {
	let dependenciesNoExtraneous = setOfFDs;
	
	return dependenciesNoExtraneous;
};
*/
