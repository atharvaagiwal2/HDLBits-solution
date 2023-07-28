module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg [9:0] count_1000;
    reg [3:0] pstate,nstate;
    localparam START=0, S1=1, S2=2, S3=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, OVER=9;
    
    always @(*)
        begin
            case(pstate)
                START:nstate = data?S1:START;
                S1:nstate=data?S2:START;
                S2:nstate=data?S2:S3;
                S3:nstate=data?B0:START;
                B0:nstate=B1;
                B1:nstate=B2;
                B2:nstate=B3;
                B3:nstate=COUNT;
                COUNT:nstate=(count==0 & count_1000==999)? OVER : COUNT;
                OVER:nstate=ack? START : OVER;
            endcase
        end
    
    always @(posedge clk)
        begin
            case(pstate)
                B0:count[3]<=data;
                B1:count[2]<=data;
                B2:count[1]<=data;
                B3:count[0]<=data;
                COUNT:begin
                    if(count>=0) begin
                        if(count_1000<999)
                            count_1000<=count_1000 + 1;
                    	else
                            begin
                                count<=count - 1;
                                count_1000<=0;
                            end
                    end
                end
               default:count_1000<=0;
            endcase
        end
    
    always @(posedge clk)
        begin
            if(reset)
                pstate <= START;
            else
                pstate <= nstate;
        end
    
    assign counting = (pstate==COUNT);
    assign done = (pstate==OVER);
endmodule
