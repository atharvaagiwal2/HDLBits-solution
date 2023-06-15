module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LW=0, LF=1, LD = 2, RW=3, RF=4, RD = 5;
    reg [2:0] pstate, nstate;

    always @(*) begin
        case(pstate)
            LW:nstate = ground?(dig?LD:(bump_left?RW:LW)):LF;
            LF:nstate = ground? LW:LF;
            LD:nstate = ground? LD:LF;
            RW:nstate = ground?(dig?RD:(bump_right?LW:RW)):RF;
            RF:nstate = ground? RW:RF;
            RD:nstate = ground? RD:RF;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            pstate <= LW;
        else
            pstate <= nstate;   
    end


    assign walk_left = (pstate == LW);
    assign walk_right = (pstate == RW);
    assign aaah = (pstate == RF)|(pstate == LF);
    assign digging = (pstate == RD)|(pstate == LD);
endmodule
