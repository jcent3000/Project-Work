`timescale 1ns / 1ps

// define and_gate variables
module mux_gate(d0, d1, d2, d3, select, out);

// define d1, d2 as inputs
input [1:0]select, d0, d1, d2, d3;

// define out to be a reg meaning a value can be assigned to it
output reg out;

// the 'always@' means that every time an input changes, run this body of code again
// (so our and gate reruns whenever we change the inputs!)
always@(d0, d1, d2, d3, select)
begin
    if( select == 2'b00 )
    begin
      out = d0;
    end
    
    if( select == 2'b01 )
    begin
      out = d1;
    end

    if( select == 2'b10 )
    begin
      out = d2;
    end

    if( select == 2'b11 )
    begin
      out = d3;
    end
end

endmodule

