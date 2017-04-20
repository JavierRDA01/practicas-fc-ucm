/**
 * Copyright (c) 2017 Alvaro de la Vega Olmedilla - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Álvaro de la Vega Olmedilla <alvdelav@ucm.es>, 2017
 *
 * PRACTICA 3.1
 * r4 -> A
 * r5 -> B
 * r6 -> A[]
 * r7 -> B[]
 * r8 -> j
 */

.global start
.equ N, 8
.data
A: .word 7, 3, 25, 4, 75, 2, 1, 1
.bss
B: .space N * 4

.text
start:
    mov fp, #0
    ldr r4, =A 
    ldr r5, =B
    mov r8, #0 // j = 0

for:
    cmp r8, #N
    bge for_end // if mayor e igual
    mov r0, r4 // r4 -> A primer parámetro de entrada
    mov r1, #N // N es el segundo parámetro de entrada
    bl max

    // Devuelve el return por r0 -> ind

    ldr r6, [r4, r0, lsl#2] // Carga A[ind]
    mov r7, r6 // B[j]
    str r7, [r5, r8, lsl#2] // Guarda B[j]
    mov r6, #0 // A[ind] = 0
    str r6, [r4, r0, lsl#2] // Guarda A[ind]
    add r8, r8, #1 // j++

    b for

for_end:
end: B .

max:
    push {r4-r5, fp}
    add fp, sp, #8

    mov r2, #0 // max = 0
    mov r3, #0 // ind = 0
    mov r5, #0 // i = 0

for2:
    cmp r5, r1
    bge for2_end
    ldr r4, [r0, r5, lsl#2] // Carga A[i]

if:
    cmp r4, r2
    ble if_end
    mov r2, r4 // max = A[i]
    mov r3, r5 // ind = i

if_end:
    add r5, r5, #1 // i++
    b for2

for2_end:
    mov r0, r3 // return ind por r0
    pop {r4-r5, fp}
    mov pc, lr
    .end
