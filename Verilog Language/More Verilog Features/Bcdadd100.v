module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0] w;
    
    bcd_fadd B0(
        a[3:0],
        b[3:0],
    	  cin,
        w[0],
        sum[3:0]);
    
    genvar i;
    generate
        for(i=4;i<400;i=i+4) begin: My_adder
                bcd_fadd B0(
                    a[i+3:i],
                    b[i+3:i],
                    w[i/4-1],
                    w[i/4],
                    sum[i+3:i]);
        end
    endgenerate
    
    assign cout = w[99];

endmodule
