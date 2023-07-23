module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    localparam idle = 0, receive = 1, over = 2, hold = 3;
    reg [1:0] pstate,nstate;
    int count;
    
    always @(posedge clk)
        if(reset) begin
            pstate <= idle;
            count = 0;
        end
    	else begin
            pstate <= nstate;
            if(nstate == receive)
                count = count + 1;
            if (nstate == over || nstate == hold)
                count = 0;
        end
    
    always @(*)
        begin
            case(pstate)
                idle: nstate = in ? idle : receive;
                receive:nstate = (count==9 & in)? over:(count==9 & ~in)? hold : receive;
                over:nstate = in ? idle : receive;
                hold:nstate = in ? idle : hold;
            endcase
        end

    assign done = (pstate == over);
endmodule
