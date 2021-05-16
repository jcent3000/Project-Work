// Jackson Centeno
// coen122L - Lab3
// 4/23/2020

`timescale 1ns / 1ps

// define module
module dataMemory_module( clk, read, wrtd, address, Din, DataOut );

input clk, wrtd, read;
input [31:0] Din, address;

// define out to be a reg meaning a value can be assigned to it
output reg [31:0] DataOut;

reg [31:0] dataMem [65535:0];

// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(posedge clk)
begin
    // How to write into module
	if (wrtd)
	begin
		dataMem[address[15:0]] = Din;
	end
    // How to read from module
	if (read)
	begin
		DataOut = dataMem[address[15:0]];
	end
     
end

endmodule

