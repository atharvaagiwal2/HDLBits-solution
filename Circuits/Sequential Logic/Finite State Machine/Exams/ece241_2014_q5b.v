module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 0, B = 1;
    reg pstate, nstate;
    always @(*)
 		begin
            case(pstate)
                A: if(x)
                    begin
                        nstate = B;
                        z = 1;
                    end
                else
                    begin
                        nstate = A;
                        z = 0;
                    end
                B:if(x)
                    begin
                        nstate = B;
                        z = 0;
                    end
                else
                    begin
                        nstate = B;
                        z = 1;
                    end
            endcase
        end
    
    always @(posedge clk,posedge areset)
        begin
        if(areset)
            pstate<=A;
    else
        pstate<=nstate;
        end

endmodule
