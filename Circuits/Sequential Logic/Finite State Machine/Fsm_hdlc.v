module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    localparam NONE=0,ONE=1,TWO=2,THREE=3,FOUR=4,FIVE=5,SIX=6,ERROR=7,DISCARD=8,FLAG=9;
    reg [3:0] pstate , nstate;
    
    always @(posedge clk)
        begin
            if(reset)
               pstate <= NONE;
            else
               pstate <= nstate;
        end
    
    always @(*)
        begin
            case(pstate)
                NONE: nstate = in?ONE:NONE;
                ONE: nstate = in?TWO:NONE;
                TWO: nstate = in?THREE:NONE;
                THREE: nstate = in?FOUR:NONE;
                FOUR: nstate = in?FIVE:NONE;
                FIVE: nstate = in?SIX:DISCARD;
                SIX: nstate = in?ERROR:FLAG;
                ERROR: nstate = in?ERROR:NONE;
                DISCARD: nstate = in?ONE:NONE;
                FLAG: nstate = in?ONE:NONE;
            endcase
        end
	assign disc = pstate==DISCARD;
  assign err = pstate==ERROR;
	assign flag = pstate==FLAG;

endmodule
