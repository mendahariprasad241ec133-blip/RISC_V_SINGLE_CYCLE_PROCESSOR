module Register(A1,A2,A3,WE,WD,RD1,RD2,rst,clk);

input [4:0] A1,A2,A3;
input [31:0] WD;
input WE , clk ,rst;

output [31:0] RD1,RD2;

reg [31:0] Register [32:0];
 
always@(posedge clk) begin

if(WE) Register[A3] <= WD;

end



assign RD1 = (~rst) ? Register[A1] : 32'b00000000; 

assign RD2 = (~rst) ? Register[A2] : 32'b00000000; 

initial begin
        Register[0] = 32'h00000005;
        // Register[1] = 32'h00000005;
        // Register[2] = 32'h00000004;
        
    end
    

endmodule