module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [3:0] pstate,nstate;
    localparam S = 0, S1 = 1, S11 = 2, S110 = 3, B0 = 4, B1 = 5, B2 = 6, B3 = 7, Count = 8, Wait = 9;
	
    always @(posedge clk)
        begin
            if(reset)
                pstate<=S;
            else
                pstate<=nstate;
        end
    
    always @(*)
        begin
            case(pstate)
                S: nstate = data?S1:S;
                S1: nstate = data?S11:S;
                S11: nstate = data?S11:S110;
                S110: nstate = data?B0:S;
                B0: nstate = B1;
                B1: nstate = B2;
                B2: nstate = B3;
                B3: nstate = Count;
                Count: nstate = done_counting?Wait:Count;
                Wait: nstate = ack?S:Wait;
            endcase
        end
    
    assign shift_ena = (pstate == B0|pstate == B1|pstate == B2|pstate == B3);
	assign counting = (pstate==Count);
    assign done = (pstate==Wait);
endmodule
