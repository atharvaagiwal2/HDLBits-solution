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
    
    parameter LW=0, LF=1, LD = 2, RW=3, RF=4, RD = 5,over=6;
    reg [2:0] pstate, nstate;
    reg [6:0] count;

    always @(*) begin
        case(pstate)
            LW:nstate = ground?(dig?LD:(bump_left?RW:LW)):LF;
            LF:nstate = ground? ((count>19)?over:LW):LF;
            LD:nstate = ground? LD:LF;
            RW:nstate = ground?(dig?RD:(bump_right?LW:RW)):RF;
            RF:nstate = ground? ((count>19)?over:RW):RF;
            RD:nstate = ground? RD:RF;
            over:nstate = over;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)begin
            pstate <= LW;
            count <= 0;
        end
        else begin
            pstate <= nstate;
            if (pstate == LF | pstate == RF)
                count <= count + 1;
            else
                count <= 0;
          end
	end

    assign walk_left = (pstate == LW);
    assign walk_right = (pstate == RW);
    assign aaah = (pstate == RF)|(pstate == LF);
    assign digging = (pstate == RD)|(pstate == LD);
endmodule
