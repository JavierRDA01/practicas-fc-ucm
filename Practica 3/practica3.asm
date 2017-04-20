/**
 * Copyright (c) 2017 Alvaro de la Vega Olmedilla - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Álvaro de la Vega Olmedilla <alvdelav@ucm.es>, 2017
 *
 *  PRACTICA 3
 */

 .extern _stack
    .global start
    .equ N, 4
    .data
A:  .word 7,3,25,4
    .bss
B: .space N*4
    
    .text
start:
    ldr sp, =_stack
    mov fp, #0
    ldr r0, =A
    ldr r1, =B
    mov r2, #N
    bl Recorre
    b.
Recorre:
    push {r4-r8,fp,lr}
    add fp, sp, #24 @ 24=4*7-4
    mov r4, r0 @ R4 ,A
    mov r5, r1 @R 5, B
    sub r6, r2, #1 @ R6, M-1
    mov r7, #0 @ R7, j

for:
    cmp r7, r6
    bge Ret1
    ldr r0, [r4, r7, lsl #2]
    add r8, r7, #1
    ldr r1, [r4, r8, lsl #2]
    bl Mayor
    str r0, [r5, r7, lsl #2]
    add r7, r7, #1
    b for

Ret1:
    pop {r4-r8,fp,lr}
    mov pc, lr

Mayor:
    push {fp}
    mov fp, sp @ SP - 0
    cmp r0, r1
    bgt Ret2
    mov r0, r1
Ret2:
    pop {fp}
    mov pc, lr
    .end

