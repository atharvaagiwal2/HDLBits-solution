module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] next;
    localparam SNT = 0, WNT = 1, WT = 2, ST = 3;
    
    always @(posedge clk, posedge areset)
        begin
            if(areset)
                state <= WNT;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                SNT:next=train_valid?(train_taken?WNT:SNT):SNT;
                WNT:next=train_valid?(train_taken?WT:SNT):WNT;
                WT:next=train_valid?(train_taken?ST:WNT):WT;
                ST:next=train_valid?(train_taken?ST:WT):ST;
            endcase
        end
endmodule
