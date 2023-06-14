module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [2:0]q;
    always @(posedge clk)
      
            begin
                 q[0]<=(resetn)?in:1'b0;
                 q[1]<=(resetn)?q[0]:1'b0;
                 q[2]<=(resetn)?q[1]:1'b0;
                 out<=(resetn)?q[2]:1'b0;
            end


endmodule
