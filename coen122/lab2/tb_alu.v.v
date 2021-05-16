`timescale 1ns / 1ps
// Jackson Centeno
// coen122L - Lab2 ALU
// 4/16/2020

 // define testbench module
module tb_alu();
    
// regs can store data
reg [31:0] A,  B;
reg [3:0] op; 

// can't store data, connects modules
wire [31:0] out;
wire N_flag, Z_flag; 

// and_gate object
alu_gate test(A, B, op, out, N_flag, Z_flag);

integer i;


// 'initial' means just to do it once (unlike 'always')
initial
begin

    // random initial values to test ALU
    A = -60;
    B = -6;
    
    for (i=0; i<4; i = i+1)
    begin
    
        // random operations to mix up testing variables
        A = A + 20;
        B = B*-2;
    
        // adding
        op = 4'b0000; 
        
        #50; // wait 50 nanoseconds to see the change!
        
        // increment 
        op = 4'b0001;
        
        #50;
        
        // negate
        op = 4'b0010;
        
        #50;
    
        // subtract
        op = 4'b0011;
        
        #50;
    
        // pass A
        op =  4'b0100;
    
        #50;

    end
    $finish;
end
endmodule