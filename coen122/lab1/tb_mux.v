`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 02:22:41 PM
// Design Name: 
// Module Name: tb_and
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

 // define testbench module
module tb_mux();
    
// regs can store data
reg [1:0]select, d0, d1, d2, d3; 

// can't store data, connects modules
wire out; 

// and_gate object
mux_gate test(d0, d1, d2, d3, select, out);

// 'initial' means just to do it once (unlike 'always')
initial
begin

    d0 = 0;
    d1 = 1;
    d2 = 0;
    d3 = 1;



    // Out should be 0
    select = 2'b00; 
    
    #50; // wait 50 nanoseconds to see the change!
    
    // Out should be 1 
    select = 2'b01;
    
    #50;
    
    // Out should be 0
    select = 2'b10;
    
    #50;

    // Out should be 1
    select = 2'b11;
    
    #50;

    $finish;
end
endmodule