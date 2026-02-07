module Mux( A , B , Sel , out);

input [31:0] A ,B;
input Sel;
output wire [31:0] out;

assign out = Sel ? B : A;

endmodule