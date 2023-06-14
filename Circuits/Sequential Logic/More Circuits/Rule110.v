module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    always @(posedge clk)
        begin
            if(load)
                q<=data;
            else
               	begin
                    for(int i=1;i<511;i++)
                        q[i]<= q[i+1]?q[i]^q[i-1]:q[i]|q[i-1];
                    q[511]<=q[510]|q[511];
                end
        end
endmodule
