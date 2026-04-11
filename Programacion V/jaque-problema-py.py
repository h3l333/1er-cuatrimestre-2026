tablero = [
    [" ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", "A", " "],
    [" ", " ", " ", " ", " ", " "],
    [" ", "R", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " "],   
]

def encontrarRey(tablero):
    for i, fila in enumerate(tablero):
        for j, celda in enumerate(fila): # enumerate() da un par de valores: pos. y contenido
            if celda == "R":
                return [i, j]
    return None

def encontrarAlfil(tablero):
    for i, fila in enumerate(tablero):
        for j, celda in enumerate(fila):
            if celda == "A":
                return [i, j]
    return None

def estaEnJaque(tablero):
    posRey = encontrarRey(tablero)
    posAlfil = encontrarAlfil(tablero)

    discrepanciaIs = abs(posRey[0] - posAlfil[0])
    discrepanciaJs = abs(posRey[1] - posAlfil[1])

    return discrepanciaIs == discrepanciaJs

print(estaEnJaque(tablero))