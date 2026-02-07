module Data_Memory(clk,WD,A,WE,RD);

input [31:0]A,WD;
input clk,WE;

output [31:0] RD;

reg [31:0] Data_Mem [1023:0];

assign RD = (WD != 1'b0) ? Data_Mem[A] : 32'b00000000;

initial begin

Data_Mem[6] = 32'hDEADBEEF;


end

always@(posedge clk) begin

if(WE) 
    Data_Mem[A] <= WD;

end

endmodule