// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define module
module exwb_module( clk, wrtAddr_in, rsrt_in, dataMem_in, signExtend_in, wrtAddr_out, rsrt_out, dataMem_out, signExtend_out);

input clk;
input [5:0] wrtAddr_in;
input [31:0] rsrt_in, dataMem_in, signExtend_in;

output reg [5:0] wrtAddr_out;
output reg [31:0] rsrt_out, dataMem_out, signExtend_out;


// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin
	wrtAddr_in = wrtAddr_out;
	rsrt_in = rsrt_out;
 	dataMem_in = dataMem_out;
	signExtend_in =  signExtend_out;
     
end

endmodule

