module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] w2,w3;
    wire w1,w4;
    add16 inst1( a[15:0], b[15:0], 1'b0 , sum[15:0], w1 );
    add16 inst2( a[31:16], b[31:16], 1'b0 , w2, w4 );
    add16 inst3( a[31:16], b[31:16], 1'b1 , w3, w4 );
    
    assign sum[31:16] = (w1==1'b0)? w2 : w3; 
    
endmodule
