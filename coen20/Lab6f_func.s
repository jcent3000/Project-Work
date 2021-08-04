
	.syntax     unified
	.cpu        cortex-m4
	.text

	
	
	
// void DecodeMessage(void *msg, char array[]) ;
		.global     DecodeMessage
        .thumb_func
        .align
DecodeMessage:
	PUSH {R4,R5,R6,R7,LR}
	MOV R4,R0				// R4 <- *msg
	MOV R5,R1				// R5 <- array
	
	LDR R6,=0				// R6 = bitnum
	B Start
Start:	
	LDR R7,=0				// R7 = k
	B L1
L1:
	MOV R0,R4
	MOV R1,R6
	BL GetBit
	ADD R6,R6,1
		
	ADD R7,R0,R7,LSL 1		// k <- 2k + bit (r0)
	ADD R7,R7,1				// k += 1
	
	LDRB R0,[R5,R7]			// R1 = array[k]
	CMP R0,0
	BEQ L1
	CMP R0,'$'
	BEQ Finish
	
	BL putchar
	B Start					// Character not found, send back to top
	
Finish:
	POP {R4-R7,PC}
		
		
		
		
// int GetBit(void *msg, uint32_t bitnum) ;
		.global     GetBit
        .thumb_func
        .align
GetBit:

.if 1
	LSR R2,R1,3
	LDRB R0,[R0,R2]		//R0 <- corresponding byte (contains desired bit)
	
	AND R1,R1,0x7		//R1 <- which bit in byte we want
	LSR R0,R0,R1		//Shift s.t starting bit is desired bit
	AND R0,0x1			//Clear everything else
	BX LR
.else
	SUB R0,R0,0x20000000
	LSLS.N R0,R0,5				// R1 <- holds region offset


	ADD R0,R0,R1,LSL 2			// add bitnumber
	ADD R0,R0,0x22000000
	LDR R0,[R0]
	BX LR
.endif

	