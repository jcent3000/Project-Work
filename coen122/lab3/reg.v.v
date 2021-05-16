// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define and_gate variables
module register_module( clk, wrt, Rd, Rs, Rt, DataIn, RsOut, RtOut );

input clk, wrt;
input [5:0] Rd, Rs, Rt;
input [31:0] DataIn;

// define out to be a reg meaning a value can be assigned to it
output reg [31:0] RsOut, RtOut;

reg [31:0] regFile [63:0];

// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin

	if (wrt)
	begin
		regFile[Rd] = DataIn;
	end

	RsOut = regFile[Rs];
	RtOut = regFile[Rt];

end

endmodule

