module decade_counter(
    input clk,reset,en,
    output [3:0]q);
    always @(posedge clk)
        begin
            if(reset|en&q==9) 
                q<=0;
            else
                q<=en?(q+1):q; 
        end
endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    reg [3:0] q1,q2,q3,q4;
  
    decade_counter d1(clk,reset,1'b1,q1);
    decade_counter d2(clk,reset,ena[1],q2);
    decade_counter d3(clk,reset,ena[2],q3);
    decade_counter d4(clk,reset,ena[3],q4);
    
    assign q = {q4,q3,q2,q1};
    assign ena = {(q3==4'd9)&(q2==4'd9)&(q1==4'd9),(q2==4'd9)&(q1==4'd9),(q1==4'd9)};
    
endmodule
