// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define module
module ifid_module( clk, pc_in, instr_in, pc_out, instr_out );

input clk;
input [7:0] pc_in;
input [31:0] instr_in;

output reg [31:0] instr_out;
output reg [7:0] pc_out;


// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin
	instr_out = instr_in;
	pc_out = pc_in;
     
end

endmodule

