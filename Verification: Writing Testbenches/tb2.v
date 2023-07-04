module top_module();
    
    reg clk,in;
    reg [2:0] s;
    wire out;
    
    q7 uut(clk,in,s,out);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial
        begin
            in = 0; s = 2;
            #10 s = 6;
            #10 s = 2; in = 1;
            #10 s = 7; in = 0;
            #10 s = 0; in = 1;
            #30 in = 0;
        end

endmodule
