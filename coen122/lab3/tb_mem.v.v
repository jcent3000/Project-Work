`timescale 1ns / 1ps
// Jackson Centeno
// coen122L - Lab2 ALU
// 4/16/2020

 // define testbench module
module tb_mem();
    
// regs can store data
reg clk, wrt, wrtd, read;
reg [31:0] address, Din, DataIn;
reg [5:0] Rd, Rs, Rt;
reg [7:0] addrI;

// can't store data, connects modules
wire [31:0] RsOut, RtOut, instruction, DataOut;


initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

instruction_module test1( clk, addrI, instruction );
dataMemory_module test2( clk, read, wrtd, address, Din, DataOut );
register_module test3( clk, wrt, Rd, Rs, Rt, DataIn, RsOut, RtOut );

integer i;

// 'initial' means just to do it once (unlike 'always')
initial
begin

	// Testing Instructions module
	for(i=0; i<10; i=i+1) begin
	   addrI = i;
	   #10;
	end
	
	#10;
	// Testing register module
	wrt = 1'b1;
	for (i=0; i<10; i=i+1) begin
		Rd = i[5:0];
		DataIn = i[31:0];
		#10;
	end
	wrt = 1'b0;

	for (i=0; i<10; i=i+1) begin
		Rs = i;
		Rt = i;
		#10;
	end

	//Testing dataMemory module
	
	// First write to data
	wrtd = 1'b1;
	for (i=0; i<10; i=i+1) begin
		Din = i[31:0];
		address  = i[31:0];
		#10;
	end
	wrtd = 1'b0;
	
	// Secondly, output dataMemory
	read = 1'b1;
    for (i=0; i<10; i=i+1) begin
		address = i[31:0];
		#10;
	end
	read = 1'b0;
	$finish;
end
endmodule