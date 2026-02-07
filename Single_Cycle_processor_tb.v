module Single_Cycle_processor_tb();

reg clk,rst;

Single_Cycle_processor uut(.clk(clk) , .rst(rst));

    initial clk = 0;
    always #5 clk = ~clk;
initial begin
rst = 1'b1;
#10 
rst = 1'b0;

#100 $finish;
end

initial begin
    $dumpfile("Single_Cycle_processor_tb.vcd");
    $dumpvars(0, Single_Cycle_processor_tb);

    // Or explicitly dump the internal signals
    // $dumpvars(0,uut.Data_Memory);
    // $dumpvars(0, uut.mem);
end

endmodule