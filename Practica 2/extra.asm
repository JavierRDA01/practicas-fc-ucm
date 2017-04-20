/**
 * Copyright (c) 2017 Alvaro de la Vega Olmedilla - All Rights Reserved
 * Unauthorized copying of this file, via any medium is STRictly prohibited
 * Proprietary and confidential
 * Written by Álvaro de la Vega Olmedilla <alvdelav@ucm.es>, 2017
 *
 *  PRACTICA 02 B MODIFICACIÓN
 */

.EQU N, 8 // conts N = 8
.EQU Q, 20 // conts Q = 20 tope
.global start
.data
A:		.word 1,100,120,115,15,7,12,3 // A[] = [1,100,120,115,15,7,12,3]

.bss
B:		.space N*4 // Reserva espacio para N * 4 bits | Es el array ya ordenado
max:	.space 4   // Reserva espacio para el máximo
ind:	.space 4   // Reserva espacio para el índice

.text
start:
MOV R0, #0 // j
MOV R1, #0 // i
LDR R2, =A
LDR R3, =B
LDR R4, =max
LDR R5, =ind
LDR R10, [R5]

for_j:
    CMP R0, #N
    BGE end
    MOV R7, #300
    STR R7, [R4]
for_i:
    CMP R1, #N
    BGE continue_for_i
    LDR R6, [R2, R1, LSL#2]
    CMP R6, R7
    BGE end_if
    CMP R6, #Q
    BGT end_if
    #AND R8, R6, #0x1
    #CMP R8, #0
    #BEQ end_if
    MOV R7, R6
    MOV R10, R1
    STR R7, [R4]
    STR R10, [R5]

end_if:
    ADD R1, R1, #1
    B for_i

continue_for_i:
    STR R7, [R3, R0, LSL#2]
    MOV R1, #300
    STR R1, [R2, R10, LSL#2]
    MOV R1, #0
    ADD R0, R0, #1
    B for_j

end:
	B .
	.end
