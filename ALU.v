module ALU(A,B,ALU_CNTL,Overflow,Zero,Negative,Carry,RESULT);

input [31:0] A,B;
input [2:0] ALU_CNTL;

output Negative,Zero,Carry,Overflow;
output [31:0] RESULT;

wire[31:0] a_or_b;
wire[31:0] a_and_b;

assign a_or_b = A|B;
assign a_and_b = A&B;

wire[31:0] not_b;

wire[31:0] mux_1;

wire[31:0] sum;
wire Cout;

assign not_b = -B;

wire [31:0] mux_2;

wire [31:0] sign_ext;

assign mux_1 = (ALU_CNTL[0] == 0) ? B :not_b;

assign {cout,sum} = A+mux_1+ALU_CNTL[0];

assign sign_ext = {31'b0, sum[31]};


assign mux_2 = (ALU_CNTL == 3'b000) ? sum :
               (ALU_CNTL == 3'b001) ? sum :
               (ALU_CNTL == 3'b010) ? a_and_b:
               (ALU_CNTL == 3'b011) ? a_or_b :
               (ALU_CNTL == 3'b100) ? sign_ext :32'b0;
            
assign RESULT = mux_2;

assign Zero = &(~RESULT);
assign Negative = RESULT[31];
assign Carry = Cout & ALU_CNTL[1];
assign Overflow = (A[31] ^ B[31] ^ ALU_CNTL[0]) & ~(ALU_CNTL[1]) & (A[31] ^ RESULT[31]); 

endmodule