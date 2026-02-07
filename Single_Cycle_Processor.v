`include "Instruction_Memory.v"
`include "PC.v"
`include "Register.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit.v"
`include "Data_Memory.v"
`include "Pc_Incr.v"
`include "Mux.v"

module Single_Cycle_processor(clk,rst);

input clk,rst;
wire [31:0] PC_Top,RD_Instruct,PC_Next_Target, RD1_Top ,RD2_Top,PC_Sel_Top, Imm_Ext_Top , Result_ALU_Top,PC_Add4_Top,Mux_1_Out , Read_Data_Top , Read_Reg_Top ;
wire [2:0] ALUControl_Top;
wire Reg_Write_Top,Zero,Pc_Src_Top, Mem_Write_Top,ALU_Src_Top,Result_Sel_Top,Branch;
wire [1:0] Imm_Src_Top;


    PC PC_1(
    .PC_NEXT(PC_Sel_Top),
    .rst(rst),
    .clk(clk),
    .PC(PC_Top)
);


  Instruction_Memory IM(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(RD_Instruct)
    );

    Register R1(
        .A1(RD_Instruct[19:15]),
        .A2(RD_Instruct[24:20]),
        .A3(RD_Instruct[11:7]),
        .WE(Reg_Write_Top),
        .WD(Read_Reg_Top),
        .RD1(RD1_Top),
        .RD2(RD2_Top),
        .rst(rst),
        .clk(clk)
    );

Sign_Extend Ext(
    .In(RD_Instruct),
    .Imm_Ext(Imm_Ext_Top),          
    .ImmSrc(Imm_Src_Top[0])
);

ALU A(
    .A(RD1_Top),
    .B(Mux_1_Out),
    .ALU_CNTL(ALUControl_Top),
    .Overflow(),
    .Zero(Zero),
    .Negative(),
    .Carry(),
    .RESULT(Result_ALU_Top)
);

Control_Unit_Top C(
    .Op(RD_Instruct[6:0]),
    .RegWrite(Reg_Write_Top),
    .ImmSrc(Imm_Src_Top),
    .ALUSrc(ALU_Src_Top),
    .MemWrite(Mem_Write_Top),                            
    .ResultSrc(Result_Sel_Top),
    .Branch(Branch),
    .funct3(RD_Instruct[14:12]),
    .funct7(RD_Instruct[31:25]),
    .ALUControl(ALUControl_Top),
    .Pc_Src(Pc_Src_Top),
    .Zero(Zero)
);

Data_Memory Data(
    .clk(clk),
    .WD(RD2_Top),
    .A(Result_ALU_Top),
    .WE(Mem_Write_Top),
    .RD(Read_Data_Top)
);


Pc_Incr INC(
    .a(PC_Top),
    .b(32'd4),
    .c(PC_Add4_Top)
);

Mux Mux_1( 
    .A(RD2_Top),
    .B(Imm_Ext_Top), 
    .Sel(ALU_Src_Top),
    .out(Mux_1_Out)
    );

Pc_Incr Target_Pc(
    .a(PC_Top),
    .b(Imm_Ext_Top),
    .c(PC_Next_Target)
    );

Mux Mux_2( 
    .A(PC_Add4_Top),
    .B(PC_Next_Target), 
    .Sel(Pc_Src_Top),
    .out(PC_Sel_Top)
    );

    Mux Mux_3( 
    .A(Result_ALU_Top),
    .B(Read_Data_Top), 
    .Sel(Result_Sel_Top),
    .out(Read_Reg_Top)
    );


endmodule