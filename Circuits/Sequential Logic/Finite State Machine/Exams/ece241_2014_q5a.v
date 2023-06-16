module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    parameter A = 0, B = 1,C = 2,D=3;
    reg [1:0] pstate, nstate;
    
    always @(*)
        begin
            case(pstate)
                A:nstate = x?B:A;
                B:nstate = x?D:C;
                C:nstate = x?D:C;
                D:nstate = x?D:C;
            endcase
        end
    always @(posedge clk,posedge areset)
        begin
            if(areset)
                pstate<= A;
            else
                pstate <= nstate;
        end
    assign z = (pstate==B)||(pstate==C);

endmodule
