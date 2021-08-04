


	.syntax     unified
	.cpu        cortex-m4
	.text

	
	
	
// void UseLDRB(void *dst, void *src);
		.global     UseLDRB
        .thumb_func
        .align
UseLDRB:
		.rept	512			#512 bytes with 1 byte per cycle makes 512 loops
		LDRB R2,[R1],1
		STRB R2,[R0],1 
		.endr
		BX LR
		
		
		
		
		
		
// void UseLDRH(void *dst, void *src);
		.global     UseLDRH
        .thumb_func
        .align
UseLDRH:
		.rept 256
		LDRH R2,[R1],2
		STRH R2,[R0],2
		.endr
		BX LR
		
	
		
		
		
// void UseLDR(void *dst, void *src);
		.global     UseLDR
        .thumb_func
        .align
UseLDR:
		.rept 128
		LDR R2,[R1],4
		STR R2,[R0],4
		.endr
		BX LR
		
		
		
		
		
// void UseLDRD(void *dst, void *src);
		.global     UseLDRD
        .thumb_func
        .align
UseLDRD:
		.rept 64
		LDRD R2,R3,[R1],8
		STRD R2,R3,[R0],8
		.endr
		BX LR
		
		
		
		
// void UseLDMIA(void *dst, void *src);
		.global     UseLDMIA
        .thumb_func
        .align
UseLDMIA:
		PUSH {R4-R11}
		.rept 16
		LDMIA R1!, {R4-R11}
		STMIA R0!, {R4-R11}
		.endr
		POP {R4-R11}
		BX LR
		
		

		
		.end
	