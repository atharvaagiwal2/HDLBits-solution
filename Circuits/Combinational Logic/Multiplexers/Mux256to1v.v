module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
	always @(*)
        begin
            out = in[ sel*4 +: 4];
            //out = in[sel*4+3 -: 4];
        end
endmodule