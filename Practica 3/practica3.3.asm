/**
 * Copyright (c) 2017 Alvaro de la Vega Olmedilla - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Álvaro de la Vega Olmedilla <alvdelav@ucm.es>, 2017
 *
 * PRACTICA 3.2
 * r4 -> A
 * r5 -> B
 * r6 -> A[]
 * r7 -> B[]
 * r8 -> j
 */

.global start
.equ N, 8
.data
A: .word 1, 2, 3, 4, 5, 7, 25, 75

.text
start:
    // buscar(A, N, 4) En este caso debería devolver 3
    ldr r4, =A
    mov r0, r4
    mov r1, #N
    mov r2, #4
    bl buscar

    // buscar(A, N, 8) En este caso debería devolver -1
    ldr r4, =A
    mov r0, r4
    mov r1, #N
    mov r2, #8
    bl buscar

/**
 * int buscar(int A[], int longA, int num)

 r4 = i
 r5 = j
 r6 = k
 r7 = res
 r8 = CONST -1
 */
buscar:
    push {r4-r10, fp}
    add fp, sp, #8

    mov r4, #0 // i = 0
    mov r5, r1 // j = longA
    sub r5, r5, #1 // j = longA - 1

    mov r6, #0 // init k
    mov r7, #1 // init res | Primero se pone a +1 para más adelante cambiarle el signo

    sub r7, r6, r7 // Se aprovecha que k = 0 para usarlo de comodín para inicializar res = -1
    mov r8, r7 // Se usa r7 como comodin para poder usar -1 para la comparación del while

while:
    // (i <= j) && (ret == -1)
    cmp r4, r5
    bhi end_while // i > j
    cmp r7, r8
    bne end_while // res != -1 | return ret

    add r6, r4, r5 // (i + j)
    lsr r6, r6, #1 // (i + j) / 2

    ldr r9, [r0, r6, lsl#2] // A[k] | ldr registro_para_guardar, [registro_array, registro_indice, lsl#2]

    cmp r2, r9
    bne while_else_1 // r2 != r9
    
    mov r7, r6 // res = k

    b while

while_else_1:
    cmp r2, r9
    bge while_else_2 // r2 >= r9

    add r4, r6, #1 // i = k + 1

    b while

while_else_2:
    cmp r2, r9
    ble while // r2 <= r9

    sub r5, r6, #1 // j = k - 1

    b while

end_while:
    mov r0, r7 // Se devuelve res (r7) por r0
    pop {r4-r10, fp}
    mov pc, lr
