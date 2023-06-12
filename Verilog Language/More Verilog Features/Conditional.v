module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    
    always @(*)
        begin
    		    min = a;
            min = (b<min)? b : min;
            min = (c<min)? c : min;
            min= (d<min)? d : min;
        end
endmodule
