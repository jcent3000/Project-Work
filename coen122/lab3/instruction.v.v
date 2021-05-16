// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define module
module instruction_module( clk, addrI, instruction );

input clk;
input [7:0] addrI;

output reg [31:0] instruction;

// Initialize the structure with hardcoded elements
reg [31:0] dataInstructions [255:0];
integer g;
initial
begin
    for (g=0; g<10; g = g+1) begin
	   dataInstructions[g] = g[31:0];
	end
end

// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin
	instruction = dataInstructions [addrI];
     
end

endmodule

