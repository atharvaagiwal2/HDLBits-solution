module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
	
    wire [3:0] w1,w2;
    assign w1 = {p1a, p1b, p1c, p1d};
    assign w2 = {p2a, p2b, p2c, p2d};
    assign p1y = ~(&w1);
    assign p2y = ~(&w2);

endmodule
