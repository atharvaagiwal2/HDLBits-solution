module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    localparam A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [3:1] Y,y;
    
    always @(*)
        begin
            case(y)
                A:Y=w?B:A;
                B:Y=w?C:D;
                C:Y=w?E:D;
                D:Y=w?F:A;
                E:Y=w?E:D;
                F:Y=w?C:D;
                default:Y=3'bxxx;
            endcase
        end
    
    always @(posedge clk)
        begin
            if(reset)
                y<=A;
            else
                y<=Y;
        end
    
    assign z = (y==E)|(y==F);

endmodule
