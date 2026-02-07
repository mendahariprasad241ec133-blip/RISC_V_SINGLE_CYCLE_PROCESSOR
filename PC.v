module PC(PC , PC_NEXT ,rst ,  clk);

input [31:0] PC_NEXT;
input clk ,rst;

output reg [31:0] PC;

always@(posedge clk) begin
if(rst == 1'b1)   
    PC <= 32'd0;
else PC <= PC_NEXT;
end




endmodule