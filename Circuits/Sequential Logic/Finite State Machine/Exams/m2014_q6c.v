module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    parameter A= 1,B= 2,C= 3,D= 4,E= 5,F= 6;
    
    assign Y2=~w&y[A];
    assign Y4=w&(y[B]|y[C]|y[E]|y[F]);
    

endmodule
