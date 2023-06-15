module top_module(
    input clk,
    input in,
    input reset,
    output out); //
    reg [2:0] pstate,nstate;
    parameter A = 0, B = 1, C = 2, D = 3;
    // State transition logic
    always @(*)
        begin
            case(pstate)
                A:nstate=in?B:A;
                B:nstate=in?B:C;
                C:nstate=in?D:A;
                D:nstate=in?B:C;
            endcase
        end
    // State flip-flops with synchronous reset
    always @(posedge clk)
        begin
            if(reset)
                pstate<=A;
            else
                pstate<=nstate;
        end
    // Output logic
    assign out = (pstate == D);
endmodule
