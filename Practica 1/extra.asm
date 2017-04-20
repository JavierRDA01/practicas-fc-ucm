/**
 * R1 D
 * R2 d
 * R3 c
 * R4 r
 * R5 inv
 * R6 auxiliar = 0
 */

.global start

.data
D: .word -4
d: .word 3

.bss
c: .space 4
r: .space 4

.text
start:
	LDR R1, =D
	LDR R1, [R1]
	LDR R2, =d
	LDR R2, [R2]
	LDR R3, =c
	LDR R3, [R3]
    LDR R4, =r
	LDR R4, [R4]

    MOV R5, #0
    MOV R6, #0 // R6 es una variable auxiliar para poder poner el -d

    CMP R1, R6
    BGE after_if_1
    MOV R5, #1
    SUB R2, R6, R2

    after_if_1:
        MOV R4, R1
        MOV R3, #0

    if_2:
        CMP R1, R6
        BGE else_if_2

    else_if_2:

    while_1:
        CMP R4, R2
        BLE if_2
        SUB R4, R4, R2
        ADD R3, R3, #1
        B if_3

    while_2:
        CMP R4, #0
        BLE end_while_2
        ADD R4, R4, R2
        ADD R3, R3, #1

    end_while_2:
        SUB R2, R6, R2

    if_3:
        CMP R5, #1
        BNE END
        SUB R3, R6, R3
        SUB R2, R6, R2

    B END

END: B .

     .end
