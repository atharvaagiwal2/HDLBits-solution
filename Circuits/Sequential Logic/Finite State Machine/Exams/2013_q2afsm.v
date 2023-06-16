module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 3'b000, B=3'b001, C = 3'b010, D = 3'b100;
    reg [3:1] Y,y;
    always @(*)
        begin
            case(y)
                A:Y=r[1]?B:r[2]?C:r[3]?D:A;
                B:Y=r[1]?B:A;
                C:Y=r[2]?C:A;
                D:Y=r[3]?D:A;
            endcase
        end
    
    always @(posedge clk)begin
        if(!resetn)
            y<=A;
        else
            y<=Y;          
	end
            
    assign g = {y==D,y==C,y==B};

endmodule
