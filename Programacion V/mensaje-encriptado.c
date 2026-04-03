#include <stdio.h>
#include <string.h>
#include <ctype.h>

void palabra_reversa(char *palabra)
{
    int largo = strlen(palabra);
    int i;
    for(i = 0; i<largo/2; i++)
    {
        char temp = palabra[i];
        palabra[i] = palabra[largo - 1 - i];
        palabra[largo - 1 - i] = temp;
    }
}

void mensaje_reversa(char *mensaje)
{
    int largo = strlen(mensaje);
    char aux[largo + 1]; // strlen no tiene en cuenta al terminador "null"
    int i = 0, j = 0;

    while (i < largo)
    {
        if(mensaje[i] == ' ') // Ignorar espacios y copiarlos
        {
            aux[j++] = ' '; // 1ero escribe a aux[0] y luego incrementa
            i++;
            continue;
        }

        int inicio = i; // Marco inicio de la palabra
        while(i < largo && mensaje[i] != ' ') // Mientras el largo sea menor al del mensaje y no haya un espacio
            i++;
        int fin = i; // Marco el fin de la palabra. Se queda uno mas adelante del que en realidad es el utlimo caracter

        int fin_letras = fin;
        while(fin_letras > inicio && ispunct((unsigned char)mensaje[fin_letras - 1]))
        // Por lo mencionado en el previo comentario agrego - 1 a "fin_letras"
            fin_letras--;

        // Copio la palabra a un buffer y la escribo en reversa
        int palabra_len = fin_letras - inicio;
        char palabra[palabra_len + 1];
        strncpy(palabra, mensaje + inicio, palabra_len);
        palabra[palabra_len] = '\0';
        palabra_reversa(palabra);

        // Meto la palabra en reversa a aux
        strncpy(aux + j, palabra, palabra_len);
        j += palabra_len;

        // Meto la puntuacion tal cual en aux

        strncpy(aux + j, mensaje + fin_letras, fin - fin_letras);
        j += fin - fin_letras;
    }

    aux[j] = '\0';
    strcpy(mensaje, aux);
}

int main()
{
    char mensaje[] = "i ma detpyrcne.";
    printf("Mensaje original: %s\n", mensaje);

    mensaje_reversa(mensaje);

    printf("Mensaje desencriptado: %s\n", mensaje);

    return 0;
}
