module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] pstate, nstate;
    reg [23:0] data;
    // State transition logic (combinational)
    always @(*)
        begin
            case(pstate)
                A:nstate=in[3]?B:A;
                B:nstate = C;
                C:nstate = D;
                D:nstate = in[3]?B:A;
            endcase
        end
    // State flip-flops (sequential)
    always @(posedge clk)
        begin
            if(reset)
                pstate<=A;
            else
                pstate<=nstate;
        end
// New: Datapath to store incoming bytes.
    always @(posedge clk)
        begin
            if(reset)
                data <= '0;
            else
                data <= {data[15:8],data[7:0],in};
        end
    
// Output logic
    assign done = (pstate == D);
    assign out_bytes = done? data : 24'hxxxxxx;

endmodule
