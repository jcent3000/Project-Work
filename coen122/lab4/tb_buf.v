`timescale 1ns / 1ps
// Jackson Centeno
// coen122L - Lab2 ALU
// 4/16/2020

 // define testbench module
module tb_mem();
    
// regs can store data
reg clk;
reg [31:0] instr_in, rsrt_in, dataMem_in, signExtend_in, rs_in, rt_in, signExtend_in;
reg [5:0] wrtAddr_in;
reg [3:0] ALUOP_in;
reg [7:0] pc_in;

// can't store data, connects modules
wire [31:0] instr_out, rsrt_out, dataMem_out, signExtend_out, rs_out, rt_out, signExtend_out;
wire [5:0] wrtAddr_out, rd_in;
wire [3:0] ALUOP_out;
wire [7:0] pc_out;



initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

ifid_module( clk, pc_in, instr_in, pc_out, instr_out );
idex_module( clk, rd_in, rs_in, rt_in, signExtend_in, rd_out, rs_out, rt_out, signExtend_out );
exwb_module( clk, wrtAddr_in, rsrt_in, dataMem_in, signExtend_in, wrtAddr_out, rsrt_out, dataMem_out, signExtend_out);


// 'initial' means just to do it once (unlike 'always')
initial
begin
	instr_in = 32'b1;
	rsrt_in = 32'b1;
	dataMem_in = 32'b1;
	signExtend_in = 32'b1;
	rs_in = 32'b1;
	rt_in = 32'b1;
	signExtend_in = 32'b1;


	wrtAddr_in = 6'b1;
	ALUOP_in = 4'b1;
	pc_in = 8'b1;
	
	$finish;
end
endmodule