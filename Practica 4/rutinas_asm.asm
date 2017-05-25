	.global rgb2gray

	.equ COEF1, 3483
	.equ COEF2, 11718
	.equ COEF3, 1183

	.text
/*
rgb2gray:
  				  ldr r3, =COEF1 @cargas en r3 cada coeficiente
                  mul r0, r3, r0 @multiplicas ese valor por la componente r
                  ldr r3, =COEF2
                  mla r0, r3, r1, r0 @multiplica el valor por la componente b y sumas el anterior resultado
                  ldr r3, =COEF3
                  mla r0, r3, r2, r0  @multiplica el valor por la componente c y sumas el anterior resultado
                  mov r0, r0, lsr #14 @divide

                  mov pc, lr
*/
	.global RGB2GrayMatrix
//	.extern rgb2gray
		.equ i, -12
		.equ j, -16
		.equ orig, -20
		.equ dest, -24
		.equ N,128
		.equ M,128
B: .space N*M
.equ N, 128
.equ M, 128

RGB2GrayMatrix:
	push {r4-r7,fp,lr}
	ADD FP, SP, #20
	SUB SP, SP, #16

	STR R0, [FP, #-24]
	STR R1, [FP, #-28]
	MOV R3, #0
	STR R3, [FP, #-32]
	STR R3, [FP, #-36]

	MOV r4, r0 // Save array dir to R4
	MOV r5, r1 // Guardo el array dest en r5
	MOV R6, #0 // i = 0

	for1:
		CMP R6, #N //i<n
		BEQ fin_for1 //si es mayor salta
		MOV R7, #0 //j=0

	for2:
		CMP R7, #M  //j<m
		BEQ fin_for2

		LDRB r0, [r4] //primer parametro de entrada - rojo
		add r4,r4,#1  //sumamos una posición a la dir del array
		ldrb r1,[r4]  //segundo parametro de entrada - verde
		add r4,r4,#1  //sumamos una posición a la dir del array
		ldrb r2,[r4]  //tercer parametro de entrada - azul
		bl rgb2gray
		strb r0,[r5] //guardamos lo devuelto por la func en r5 - array dest
		add r4,r4,#1
		add r5,r5,#1

		ADD R7, R7, #1 //j++
		B for2

	fin_for2:
		ADD R6, R6, #1
		B for1

	fin_for1:
		ADD SP, SP, #16
		pop {r4-r7,fp,lr}
		mov pc, lr
FIN:
	b .
.end


