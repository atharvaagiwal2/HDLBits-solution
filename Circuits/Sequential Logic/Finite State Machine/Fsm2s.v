module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            A:next_state=j?B:A;
            B:next_state=k?A:B;
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if(reset)
            state<=A;
        else
            state<=next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
