// Jackson Centeno
// coen122L - Lab2 ALU
// 4/16/2020

`timescale 1ns / 1ps

// define and_gate variables
module alu_module( A, B, op, out, N_flag, Z_flag );

input [31:0] A;
input [31:0] B;
input [3:0] op;

// define out to be a reg meaning a value can be assigned to it
output reg [31:0] out;
output reg N_flag;
output reg Z_flag;

// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(A, B, op)
begin

    // use "op" to select operation, which result is stored in "out"
    case( op )
	// adding
	2'b0000: out = A + B;

	// increment
    4'b0001: out = A + 32'b1;

	// negate
	4'b0010: out = ~A + 32'b1;

	//subtract
	4'b0011: out = A + ~B + 32'b1;

	// pass A
	4'b0100: out = A;

    endcase
    
    
    
    // set zero flag
    Z_flag = 1'b0;
    if ( out == 0)
    begin
        Z_flag = 1'b1;
    end
    
    // set negative flag
    N_flag = 1'b0;
    if ( (out >> 31) == 32'b1)
    begin
        N_flag = 1'b1;
    end
     
end

endmodule

