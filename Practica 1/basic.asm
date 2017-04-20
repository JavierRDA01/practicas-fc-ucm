.global start

.data

A: .word 0x18
B: .word 0x04
C: .word 0x00

.bss
res: .space 4

.text
start:
	LDR R1, =A
	LDR R1, [R1]
	LDR R2, =B
	LDR R2, [R2]
	LDR R3, =C
	LDR R3, [R3]

/*
	MOV R1, #18
	MOV R2, #4
	MOV R3, #0
*/
	while: CMP R1, R2
		   BLT end_w
		   SUB R1, R1, R2
		   ADD R3, R3, #1
		   B while
    end_w:
    	LDR R4, =res
	    STR R3, [R4]
    	B END

END: B .
     .end
