module Fadd(
    input a,b,cin,
    output cout,sum);
    assign cout = a&b | b&cin | cin&a;
    assign sum  = a^b^cin;
endmodule

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] cout;
    
    Fadd f0(x[0],y[0],1'b0,cout[0],sum[0]);
    
    genvar i;
    generate
        for(i=1;i<$bits(x);i++) begin: special_adder
            Fadd f1(x[i],y[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate
    
    assign sum[4] = cout[3];
    
    //Note: assign sum = x+y; is the shortest solution for the above problem

endmodule
