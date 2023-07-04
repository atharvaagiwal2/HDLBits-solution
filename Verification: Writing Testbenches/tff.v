module top_module (); 
    reg clk,reset,t;       // toggle
    wire q;
    tff T1(clk,reset,t,q);
    initial clk = 0;
    always #5 clk = ~clk;
    initial 
        begin
            reset = 1;
            #7 reset=0; t = 1;
        end

endmodule
