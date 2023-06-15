module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LT=0, RT=1;
    reg pstate, nstate;

    always @(*) begin
        // State transition logic
        case(pstate)
            RT:nstate=bump_right?LT:RT;
            LT:nstate=bump_left?RT:LT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)
            pstate <= LT;
        else
            pstate <= nstate;   
        // State flip-flops with asynchronous reset
    end

    // Output logic
    assign walk_left = (pstate == LT);
    assign walk_right = (pstate == RT);

endmodule
