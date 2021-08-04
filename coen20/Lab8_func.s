	.syntax     unified
	.cpu        cortex-m4
	.text
	
zeroF:	.float 0.0
one:	.float 1.0

// float HWFlPtPoly(float x, float a[], int32_t n) ;
		.global     HWFlPtPoly
        .thumb_func
        .align
HWFlPtPoly:			// use hardware floating-point instructions	
	VMOV S1,1.0
	VLDR S2,zeroF
	
L1:	CBZ R1,Lend
	VLDMIA R0!,{S3}
	VMUL.F32 S4,S3,S1
	VADD.F32 S2,S2,S4
	VMUL.F32 S1,S1,S0
	SUB R1,R1,1
	B L1
	
Lend:
	VMOV S0,S2
	BX LR

	
// float32 SWFlPtPoly(float32 x, float32 a[], int32_t n) ;
		.global     SWFlPtPoly
        .thumb_func
        .align
SWFlPtPoly:			// Use f.p. emulation software
	PUSH {R4,R5,R6,R7,R8,LR}
	MOV R4,R0
	MOV R5,R1
	MOV R6,R2
	LDR R7,one
	LDR R8,zeroF
	
L2:	CBZ R6,end2

	LDMIA R5!,{R1}
	MOV R0,R7
	BL MulFloats
	
	MOV R1,R8
	BL AddFloats
	MOV R8,R0
	
	
	MOV R0,R4
	MOV R1,R7
	BL MulFloats
	MOV R7,R0
	
	SUB R6,R6,1
	B L2
	
end2:
	MOV R0,R8
	POP {R4,R5,R6,R7,R8,LR}
	BX LR


// Q16 Q16FxdPoly(Q16 x, Q16 a[], int32_t n) ;
		.global     Q16FxdPoly
        .thumb_func
        .align
Q16FxdPoly:			//Use Q16.16 fixed-point reals
	PUSH {R4-R7}
	MOV R7,R0
	LDR R3,=0
	LDR R4,=1
	LSL R4,R4,16
	
L3:	CBZ R2,end3
	LDMIA R1!,{R5}
	SMULL R6,R5,R4,R5
	
	LSR R6,R6,16
	ORR R6,R6,R5,LSL 16
	ADD R3,R3,R6
	
	SMULL R4,R7,R4,R0
	LSR R4,R4,16
	ORR R4,R4,R7,LSL 16
	
	SUB R2,R2,1
	B L3
	
end3:
	MOV R0,R3
	POP {R4-R7}
	BX LR

.end