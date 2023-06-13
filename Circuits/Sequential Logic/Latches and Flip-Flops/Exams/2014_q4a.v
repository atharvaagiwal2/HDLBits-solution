module top_module (
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
