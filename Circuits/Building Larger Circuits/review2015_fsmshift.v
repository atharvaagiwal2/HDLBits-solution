module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2:0] count;
    
    always @(posedge clk)
        begin
            if(reset)
                count = 4;
            else if(count)
                count = count-1;     
        end
    
    assign shift_ena = (count!=0);

endmodule
