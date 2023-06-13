module top_module (
    input clk,
    input d,
    output q
);
    reg [1:0]w;
    always @(posedge clk)
        begin
            w[1]<=d;
        end
    always @(negedge clk)
        begin
            w[0]<=d;
        end
    assign q = (clk)?w[1]:w[0];
endmodule
