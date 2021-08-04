
	.syntax     unified
	.cpu        cortex-m4
	.text

	
	
	
// uint32_t MyProduct(uint32_t a, uint32_t b);
		.global     MyProduct
        .thumb_func
        .align
MyProduct:
		PUSH {LR}
		CMP R0,0
		BEQ L2				// Base Case
		SUBS R0,R0,1
		BL MyProduct
		
		ADDS R0,R0,R1
L2:		POP {PC}

		
		
		
		
		
// uint32_t MyFibonacci(uint32_t n);
		.global     MyFibonacci
        .thumb_func
        .align
MyFibonacci:
		CMP R0,1
		BLS L1					// Base case
		
		PUSH {R4, R5, LR}
		MOV R4,R0				// Preserve our fibonacci number in R4
		SUB R0,R0,1
		BL MyFibonacci			// First call
		
		
		MOV R1,R4
		MOV R4,R0
		SUB R0,R1,2
		BL MyFibonacci			// Second call
		
		ADDS R0,R0,R4
L1:		POP {R4, R5, PC}
		
	
		
		
		
// uint32_t MyAckermann(uint32_t m, uint32_t n);
		.global     MyAckermann
        .thumb_func
        .align
MyAckermann:
		CMP R0,0
		ITT EQ
		ADDEQ R0,R1,1
		BXEQ LR				// Handles (m == 0) condition
		
		
		CMP R1,0
		ITTT EQ
		LDREQ R1,=1
		SUBEQ R0,R0,R1
		BEQ MyAckermann		// Handles (n == 0) condition
		
		PUSH {R0,LR}		// Going to link -> preserve link/m
		SUB R1,R1,1
		BL MyAckermann
		MOV R1,R0
		POP {R0,LR}
		SUB R0,R0,1
		B MyAckermann
		
	.end
	