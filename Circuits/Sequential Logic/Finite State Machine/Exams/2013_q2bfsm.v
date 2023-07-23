module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    reg [3:0] pstate, nstate;
    localparam A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6, H = 7, NONE = 8;
    always @(posedge clk)
        begin
            if(~resetn)
                pstate <= NONE;
            else
                pstate <= nstate;
        end
	
    always @(*)
        begin
            case(pstate)
                NONE:nstate = A;
                A:nstate = B;
                B:nstate = x?C:B; 
                C:nstate = x?C:D;
                D:nstate = x?E:B;
                E:nstate = y?H:F;
                F:nstate = y?H:G; 
                G:nstate = G; 
                H:nstate = H; 
            endcase
        end
    
    assign f = (pstate==A);
    always @(*) begin
        if(pstate == E ||pstate == F ||pstate ==  H)
            g = 1;
        if(pstate == G)
            g = 0;
        if(pstate == NONE)
               g = 0;
        end
    
endmodule
