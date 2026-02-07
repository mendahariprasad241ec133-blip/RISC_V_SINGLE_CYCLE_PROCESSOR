`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl,Zero,Pc_Src);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,Pc_Src;
    output [1:0]ImmSrc;
    input Zero;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

    Main_Decoder Main_Decoder(
                .Opcode(Op),
                .Reg_Write(RegWrite),
                .Imm_Src(ImmSrc),
                .Mem_Write(MemWrite),
                .Result_Src(ResultSrc),
                .Branch(Branch),
                .Alu_Src(ALUSrc),
                .Alu_Op(ALUOp),
                .Zero(Zero),
                .Pc_Src(Pc_Src)
    );
    ALU_Decoder ALU_Decoder(
                            .Alu_Op(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .Opcode(Op),
                            .ALU_CNTL(ALUControl)
    );


endmodule