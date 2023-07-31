module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);

    reg [255:0] state;
    wire [287:0] toroid = {state[15:0], state, state[255:240]};
    int count;
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else 
            for (int i = 16; i < 272; i = i + 1) begin
                if (i == 16 || i == 32 || i == 48 || i == 64 || i == 80 || i == 96 || i == 112 || i == 128 || i == 144
                   || i == 160 || i == 176 || i == 192 || i == 208 || i == 224 || i == 240 || i == 256)
                    count = toroid[i + 1] + toroid[i + 15] + toroid[i + 16] + toroid[i + 17] + toroid[i + 31] + toroid[i - 1] + toroid[i - 15] + toroid[i - 16];
                else if (i == 31 || i == 47  || i == 63 || i == 79 || i == 95 || i == 111 || i == 127 || i == 143
                   || i == 159 || i == 175 || i == 191 || i == 207 || i == 223 || i == 239 || i == 255 || i == 271)
                    count = toroid[i - 1] + toroid[i - 15] + toroid[i - 16] + toroid[i - 17] + toroid[i - 31] + toroid[i + 1] + toroid[i + 15] + toroid[i + 16];
                else 
                    count = toroid[i + 1] + toroid[i + 15] + toroid[i + 16] + toroid[i + 17] + toroid[i - 1] + toroid[i - 15] + toroid[i - 16] + toroid[i - 17];

                if (count == 2)
                    q[i - 16] <= q[i - 16];
                else if (count == 3)
                    q[i - 16] <= 1'b1;
                else
                    q[i - 16] <= 1'b0;
            end
    end
    
    always @(negedge clk)
        state <= q;

endmodule
