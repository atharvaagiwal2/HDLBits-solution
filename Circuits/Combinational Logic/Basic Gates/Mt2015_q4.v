module ckt_A (input x, input y, output z);
    assign z = (x^y)&x;
endmodule

module ckt_B ( input x, input y, output z );
	assign z = x ~^ y;
endmodule

module top_module (input x, input y, output z);
    wire w1,w2,w3,w4,w5,w6;
    
    ckt_A A1(x,y,w1);
    ckt_B B1(x,y,w2);
    ckt_A A2(x,y,w3);
    ckt_B B2(x,y,w4);
    
    assign w5 = w1|w2;
    assign w6 = w3&w4;
    
    assign z = w5^w6;

endmodule
