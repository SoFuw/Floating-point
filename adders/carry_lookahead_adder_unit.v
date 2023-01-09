module carry_lookahead_adder_unit (
    input[3:0] G,
    input[3:0] P,
    input carry_in,
    output[3:0] carry_outs
);
wire carry_outs_first;
assign carry_outs_first=carry_in;
assign carry_outs[0]=G[0]|(P[0]&carry_outs_first);
assign carry_outs[1]=G[1]|(P[1]&carry_outs[0]);
assign carry_outs[2]=G[2]|(P[2]&carry_outs[1]);
assign carry_outs[3]=G[3]|(P[3]&carry_outs[2]);






endmodule