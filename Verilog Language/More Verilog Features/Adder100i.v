module Fadd( 
    input a, b, cin,
    output cout, sum );
	assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (cin&(a|b));
endmodule



module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
            Fadd F0 (a[0],b[0],cin,cout[0],sum[0]); 
            generate
                genvar i;
                for(i=1;i<100;i++) begin: My_adder
                	Fadd F1(a[i],b[i],cout[i-1],cout[i],sum[i]);
                end
            endgenerate

endmodule
