module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter A = 0, B = 1, C = 2, D = 3, E = 4;
    reg [2:0] pstate, nstate;
    
    always @(*)
        begin
            case(pstate)
                A:nstate = data?B:A;
                B:nstate = data?C:A;
                C:nstate = data?C:D;
                D:nstate = data?E:A;
                E:nstate = E;
                default: nstate = 3'bxxx;
            endcase
        end
    
    always @(posedge clk)
        begin
            if(reset)
                pstate <= A;
            else 
                pstate <= nstate;
        end
    
    assign start_shifting = (pstate==E);

endmodule
