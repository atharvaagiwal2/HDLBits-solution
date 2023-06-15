module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [2:0] pstate, nstate;
    parameter [2:0]  A =  3'd0, //below s1
    				 B0 = 3'd1, //between s1 and s2, high to low
    				 B1 = 3'd2, //between s1 and s2, low to high
    				 C0 = 3'd3, //between s2 and s3, high to low
    				 C1 = 3'd4, //between s2 and s3, low to high
    				 D =  3'd5; //above s3
    
    always @(*)
        begin
            case(pstate)
                A :  nstate = s[1] ? B1 : A;
                B0 : nstate = s[2] ? C1 : s[1] ? B0 : A;
                B1 : nstate = s[2] ? C1 : s[1] ? B1 : A;
                C0 : nstate = s[3] ? D  : s[2] ? C0 : B0;
                C1 : nstate = s[3] ? D  : s[2] ? C1 : B0;
                D  : nstate = s[3] ? D  : C0;
                default nstate = 3'bxxx; // unused state don't care
            endcase
        end
    
    always @(posedge clk)
        begin
            if(reset)
                pstate <= A;
            else
                pstate <= nstate;         
        end
    
     always @(*)
        begin
            case(pstate)
                A :  {fr3,fr2,fr1,dfr} = 4'b1111;
                B0 : {fr3,fr2,fr1,dfr} = 4'b0111;
                B1 : {fr3,fr2,fr1,dfr} = 4'b0110;
                C0 : {fr3,fr2,fr1,dfr} = 4'b0011;
                C1 : {fr3,fr2,fr1,dfr} = 4'b0010;
                D  : {fr3,fr2,fr1,dfr} = 4'b0000;
                default {fr3,fr2,fr1,dfr} = 4'bxxxx; // unused state don't care
            endcase
        end
    

endmodule
