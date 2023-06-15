module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next;

    always @(*) begin // This is a combinational always block
        // State transition logic
        case(state)
            A: next = in? A : B;
            B: next = in? B : A;
        endcase
        
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset)
            state <= B;
        else 
            state <= next;
    end

    // Output logic
    assign out = (state == B);

endmodule
