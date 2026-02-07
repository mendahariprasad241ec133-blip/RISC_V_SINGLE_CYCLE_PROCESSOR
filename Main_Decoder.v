module Main_Decoder(Opcode,Reg_Write,Imm_Src,Zero,Alu_Src,Mem_Write,Result_Src,Branch,Alu_Op,Pc_Src);
    input [6:0] Opcode;
    input Zero;
    output reg [1:0] Imm_Src, Alu_Op;
    output reg Result_Src, Mem_Write, Alu_Src, Reg_Write,Branch;
    output wire Pc_Src;

assign Pc_Src = 0 /*Zero & Branch */;

always @(*) begin
    case (Opcode)
        // Load
        7'b0000011: begin
            Reg_Write = 1;
            Imm_Src = 2'b01;
            Alu_Src = 1;
            Mem_Write = 0;
            Result_Src = 1;
            Branch = 0;
            Alu_Op = 2'b00;
        end
        
        //Immediate
        7'b0010011: begin 
            Reg_Write = 1;
            Imm_Src = 2'b00;
            Alu_Src = 1;
            Mem_Write = 0;
            Result_Src = 0;
            Branch = 0;
            Alu_Op = 2'b00;
       end

        // Store
        7'b0100011: begin
            Reg_Write = 0;
            Imm_Src = 2'b01;
            Alu_Src = 1;
            Mem_Write = 1;
            Result_Src = 0;
            Branch = 0;
            Alu_Op = 2'b00;
        end
        // R-type

        7'b0110011: begin
            Reg_Write = 1;
            Imm_Src = 2'b00;
            Alu_Src = 0;
            Mem_Write = 0;
            Result_Src = 0;
            Branch = 0;
            Alu_Op = 2'b10;
        end
        
        // Branch
        7'b1100011: begin
            Reg_Write = 0;
            Imm_Src = 2'b10;
            Alu_Src = 0;
            Mem_Write = 0;
            Result_Src = 0;
            Branch = 1;
            Alu_Op = 2'b01;
        end
        // Default
        default: begin
            Reg_Write = 0;
            Imm_Src = 2'b00;
            Alu_Src = 0;
            Mem_Write = 0;
            Result_Src = 0;
            Branch = 0;
            Alu_Op = 2'b00;
        end
    endcase
end

endmodule