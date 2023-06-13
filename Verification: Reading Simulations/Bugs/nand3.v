module top_module (input a, input b, input c, output out);//
    wire w1;
    andgate inst1 ( w1, b, c, 1'b1, 1'b1, a );
	assign out = ~w1;
endmodule
