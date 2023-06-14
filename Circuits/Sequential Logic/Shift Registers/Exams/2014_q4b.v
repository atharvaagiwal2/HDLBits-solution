module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk)
        begin
            casez({E,L})
                2'bz1:Q<=R;
                2'b10:Q<=w;
            endcase
        end

endmodule


module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

MUXDFF D1(KEY[0],KEY[3],SW[3],KEY[1],KEY[2],LEDR[3]);
MUXDFF D2(KEY[0],LEDR[3],SW[2],KEY[1],KEY[2],LEDR[2]);
MUXDFF D3(KEY[0],LEDR[2],SW[1],KEY[1],KEY[2],LEDR[1]);
MUXDFF D4(KEY[0],LEDR[1],SW[0],KEY[1],KEY[2],LEDR[0]);

endmodule
