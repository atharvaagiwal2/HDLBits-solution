module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    always @(posedge clk)
        Q <= (r_in&L)|(q_in&~L);
endmodule
