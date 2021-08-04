


	.syntax     unified
	.cpu        cortex-m4
	.text

	
	
	
// uint32_t *PixelAddress(int x, int y) ;

		.global     PixelAddress
        .thumb_func
        .align
PixelAddress:
		LDR R2, =240				//
		MLA R0, R1, R2, R0			//using x and y for position
		LSL R0, R0, 2				//Account for size
		ADD R0, R0, 0xD0000000		//add offset
		BX LR
		
		
		
		
		
		
// uint8_t *BitmapAddress(char ascii, uint8_t *fontTable, int charHeight, int charridth) ;
		.global     BitmapAddress
        .thumb_func
        .align
BitmapAddress:
		SUBS R0, R0, 32		// Moves offset from ascii to font table
		ADDS R3, R3, 7		
		ASR R3, R3, 3		// R3 holds bytes per row
		MUL R3, R3, R2		// R3 = Size_element <- bytes_per_row x heigth
		MLA R0, R3, R0, R1	// General formula -> (base + (size_of_elements * position))
		BX LR
		
	
		
		
		
// uint32_t GetBitmapRow(uint8_t *rowAdrs) ;
		.global     GetBitmapRow
        .thumb_func
        .align
GetBitmapRow:
		LDR R0, [R0]		//address to element
		REV R0, R0			//reverse order of bits
		BX LR
		

		
		.end
	