module top_module ( );
    reg clk;
    dut d1(clk);
    initial clk = 1'b0;
    always #5 clk = ~clk;
endmodule
