module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
); wire [7:0] w1,w2,w3;
    my_dff8 instance1 (clk,d,w1 );
    my_dff8 instance2 (clk,w1,w2 );
    my_dff8 instance3 (clk,w2,w3 );
    
    always@(*) begin
        if (sel[1] == 1'b0)
            begin
                if (sel[0] == 1'b0)
                    begin
                        q = d;
                    end
                else
                    begin
                        q = w1;
                    end
            end
        else
            begin
                if (sel[0] == 1'b0)
                    begin
                        q = w2;
                    end
                else
                    begin
                        q = w3;
                    end
            end
    end

endmodule
