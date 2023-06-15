module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LW=0, LF=1, RW=2, RF=3;
    reg [1:0] pstate, nstate;

    always @(*) begin
        case(pstate)
            LW:nstate = ground?(bump_left?RW:LW):LF;
            LF:nstate = ground?LW:LF;
            RW:nstate = ground?(bump_right?LW:RW):RF;
            RF:nstate = ground?RW:RF;
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

endmodule
