// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define module
module idex_module( clk, rd_in, rs_in, rt_in, signExtend_in, rd_out, rs_out, rt_out, signExtend_out );

input clk;
input [5:0] rd_in;
input [31:0] rs_in, rt_in, signExtend_in;
input [3:0] ALUOP_in;

output reg [5:0] rd_out;
output reg [31:0] rs_out, rt_out, signExtend_out;
output reg [3:0] ALUOP_out;


// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin
	rd_out = rd_in;
	rs_out = rs_in;
	rt_out = rt_in;
	signExtend_out = signExtend_in;
	ALUOP_out = ALUOP_in;
     
end

endmodule

