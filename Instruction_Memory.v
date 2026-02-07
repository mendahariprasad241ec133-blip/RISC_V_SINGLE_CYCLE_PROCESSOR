module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0];
  
assign RD = (rst) ? 32'b0 : mem[A >> 2];


  // initial begin
  //   $readmemh("memfile.hex",mem);
  // end


  initial begin
    mem[0] = 32'h00300093; // ADDI x1, x0, 3
    mem[1] = 32'h00500113; // ADDI x2, x0, 5
    mem[2] = 32'h00700193; // ADDI x3, x0, 7
    mem[3] = 32'h002081B3; // ADD x4, x1, x2
    mem[4] = 32'h403182B3; // SUB x5, x2, x3
    mem[5] = 32'h0031A333; // AND x6, x1, x3
    mem[6] = 32'h005242B3; // OR x7, x4, x5
    // mem[7] = 32'h0062C433; // XOR x8, x5, x6
end

endmodule