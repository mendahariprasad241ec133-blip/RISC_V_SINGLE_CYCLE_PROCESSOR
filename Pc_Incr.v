module Pc_Incr(a,b,c);
 
input [31:0] a,b;
output wire [31:0] c;

 assign c = a+b; 
 
endmodule