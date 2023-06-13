module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk)
        begin
            if(reset)
                q<='0;
            else
                if(slowena)
                    q<=(q==9)? '0: q+1;
        end

endmodule
