module mux_dff (
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
    always @(posedge clk)
        Q <= L?r_in:q_in;
endmodule

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	
    mux_dff m1(KEY[0],KEY[1],LEDR[2],SW[0],LEDR[0]);
    mux_dff m2(KEY[0],KEY[1],LEDR[0],SW[1],LEDR[1]);
    mux_dff m3(KEY[0],KEY[1],LEDR[1]^LEDR[2],SW[2],LEDR[2]);
    
endmodule
