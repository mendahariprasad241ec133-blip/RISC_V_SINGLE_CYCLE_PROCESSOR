module ALU_Decoder(Alu_Op , funct3 , Opcode , funct7 , ALU_CNTL);

input [1:0] Alu_Op;
input [2:0] funct3;

input [6:0] Opcode ,funct7;

output reg [2:0] ALU_CNTL;

always@(*) begin

case (Alu_Op)

2'b00:  ALU_CNTL = 3'b000; //ADD

2'b01:  ALU_CNTL = 3'b001; //SUB

2'b10: begin
    case(funct3)

3'b000 :begin
     if (Opcode[5] & funct7[5])
    ALU_CNTL = 3'b001; // SUB
else
    ALU_CNTL = 3'b000; // ADD
end

3'b010: ALU_CNTL = 3'b101; // SET LESS THAN

3'b110: ALU_CNTL = 3'b011; //OR 

3'b111: ALU_CNTL = 3'b010; //AND

default:ALU_CNTL = 3'bxxx;


    endcase
end

endcase
end

endmodule