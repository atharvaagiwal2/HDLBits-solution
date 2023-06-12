module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3:0]w;
    
    bcd_fadd f1(a[3:0],b[3:0],cin,w[0],sum[3:0]);
    
    genvar i;
    
    generate
        for(i=4;i<16;i=i+4) begin: bcdadder
           bcd_fadd f2(a[i +: 4],b[i +: 4], w[i/4-1],w[i/4],sum[i +: 4]);
        end
    endgenerate
    assign cout = w[3];
endmodule
