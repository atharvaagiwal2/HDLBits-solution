module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	

    localparam idle = 0, receive = 1, over = 2, hold = 3, check = 4;
    reg [2:0] pstate,nstate;
    reg odd;
    int count;
    
    parity P1(
        .clk(clk),
        .reset(pstate!=receive),
        .in(in),
        .odd(odd));
    
    always @(posedge clk)
        if(reset) begin
            pstate <= idle;
            count = 0;
        end
    	else begin
            pstate <= nstate;
            if(nstate == receive) begin
                if(count > 0)
                    out_byte[count-1]=in;
                count = count + 1;
            end
            if (nstate == over || nstate == hold)
                count = 0;
        end
    
    always @(*)
        begin
            case(pstate)
                idle: nstate = in ? idle : receive;
                receive:nstate = (count==9 & (in==~odd))? check:(count==9 & ~(in==~odd))? hold : receive;
                check: nstate = in ? over : hold;
                over:nstate = in ? idle : receive;
                hold:nstate = in ? idle : hold;
            endcase
        end
	

    
    assign done = (pstate == over);
endmodule
