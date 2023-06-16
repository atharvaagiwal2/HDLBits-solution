module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter A = 0, B = 1, C = 2;
    reg [1:0] pstate, nstate;
    
    always @(*)
        begin
            case(pstate)
                A:if(x)begin
                    nstate = B;
                    z = 0;
                end
                else begin
                    nstate = A;
                	z = 0;
                end
                B:if(x)begin
                    nstate = B;
                    z = 0;
                end
                else begin
                    nstate = C;
                	z = 0;
                end
                C:if(x)begin
                    nstate = B;
                    z = 1;
                end
                else begin
                    nstate = A;
                	z = 0;
                end
            endcase
        end
    always @(posedge clk,negedge aresetn)
        begin
            if(!aresetn)
                pstate <= A;
            else
                pstate <= nstate;
        end

endmodule
