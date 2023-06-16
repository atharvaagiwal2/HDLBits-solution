module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg [2:0] Y;
    
    always @(*)
        begin
            case(y)
                0:Y=x?1:0;
                1:Y=x?4:1;
                2:Y=x?1:2;
                3:Y=x?2:1;
                4:Y=x?4:3;
                default: Y = 3'bxxx;
            endcase
        end
    

    
    assign z = (y==3|y==4);
    assign Y0 = Y[0];
    
endmodule
