module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 0, B = 1;
    reg pstate, nstate;
    reg [1:0] count, clk_count;
    
    always @(*)
        begin
            case(pstate)
                A:nstate = s? B: A;
                B:nstate = B;
            endcase
        end
    
    always @(posedge clk)begin
        if(reset)begin
            pstate <= A;
            count = 0;
            clk_count = 0;
        end
    	else begin
            if(pstate == B)begin
                if(clk_count == 3)begin
                    clk_count = 0;
                    count = 0;
                end
                    if(w)
                        count = count+1;
                clk_count = clk_count + 1;
            end
			pstate <= nstate;
        end
    end
    
    assign z = (count==2)&(clk_count==3);

endmodule
