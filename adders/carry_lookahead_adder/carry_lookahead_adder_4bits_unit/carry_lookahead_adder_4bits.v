`include "one_bit_full_adder.v"
`include "carry_lookahead_adder_unit.v"
module carry_lookahead_adder_4bits(
    input[3:0] in0,
    input[3:0] in1,
    input carry_in,
    output carry_out,
    output[3:0] sum,
    output PG,
    output GG
);

wire [3:0] G;
wire [3:0] P;
wire [4:0] carry_lookahead;
assign carry_lookahead[0]=carry_in;
assign carry_out=carry_lookahead[4];
assign PG=P[0]&P[1]&P[2]&P[3];
assign GG=G[3]|(G[2]&P[3])|(G[1]&P[3]&P[2])|(G[0]&P[3]&P[2]&P[1]);


one_bit_full_adder u_one_bit_full_adder0(
    .in0(in0[0]),
    .in1(in1[0]),
    .carry_in(carry_lookahead[0]),
    .sum(sum[0]),
    .g(G[0]),
    .p(P[0])
);
one_bit_full_adder u_one_bit_full_adder1(
    .in0(in0[1]),
    .in1(in1[1]),
    .carry_in(carry_lookahead[1]),
    .sum(sum[1]),
    .g(G[1]),
    .p(P[1])
);
one_bit_full_adder u_one_bit_full_adder2(
    .in0(in0[2]),
    .in1(in1[2]),
    .carry_in(carry_lookahead[2]),
    .sum(sum[2]),
    .g(G[2]),
    .p(P[2])
);
one_bit_full_adder u_one_bit_full_adder3(
    .in0(in0[3]),
    .in1(in1[3]),
    .carry_in(carry_lookahead[3]),
    .sum(sum[3]),
    .g(G[3]),
    .p(P[3])
);
carry_lookahead_adder_unit u_carry_lookahead_adder_unit0(
    .G(G),
    .P(P),
    .carry_in(carry_in),
    .carry_lookahead(carry_lookahead)
);
endmodule