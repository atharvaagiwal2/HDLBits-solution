module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    always @(*)
        begin
            next_state[0] = (~in)&(state[0]|state[1]|state[2]|state[3]|state[4]|state[8]|state[9]|state[7]);
            next_state[1] = in&(state[0]|state[8]|state[9]);
            next_state[6:2] = {5{in}}&(state[5:1]);
            next_state[7] = in&(state[6]|state[7]);
            next_state[8] =~in&state[5];
            next_state[9] =~in&state[6];
        end
    
    assign out1 = state[8]|state[9];
    assign out2 = state[7]|state[9];

endmodule
