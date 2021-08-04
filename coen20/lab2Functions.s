	.syntax     unified
	.cpu        cortex-m4
	.text


// uint32_t  Ten32(void) ;

        .global     Ten32
        .thumb_func
        .align

Ten32: 	LDR	R0,=10			# value 10 in 32 bits
        BX          LR		


		
// uint64_t  Ten64(void) ;

        .global     Ten64
        .thumb_func
        .align
		
Ten64:	LDR R0,=10
		LDR R1,=0			#Extend 10 into 64 bits (unisigned)
		BX LR
		

		
// uint32_t  Incr(uint32_t n) ;

        .global     Incr
        .thumb_func
        .align

Incr:	ADD	R0,R0,1
		BX LR
		

		
// uint32_t  Nested1(void) ;

        .global     Nested1
        .thumb_func
        .align
Nested1:	
	PUSH {LR}		#preserve
	BL rand
	ADD R0,R0,1
	POP {PC}
	


	
// uint32_t  Nested2(void) ;

        .global     Nested2
        .thumb_func
        .align
		
Nested2:
	PUSH {R4,LR}	
	BL rand
	MOV R0,R4		#preserve 1st rand's return
	BL rand
	ADD R0,R0,R4	#combine rand's
	POP {R4,LR}
	BX LR
	
	
// uint32_t  PrintTwo(char *format, uint32_t n) ;

        .global     PrintTwo
        .thumb_func
        .align
PrintTwo:
	PUSH {R4,R5,LR}
	MOV	R4,R0
	MOV R5,R1
	BL	printf
	
	MOV R0,R4
	ADD R1,R5,1
	
	POP {R4,R5,LR}		#Restore preserved variables
	B	printf			#last function call, thus, use Unconditional Branch

	.end