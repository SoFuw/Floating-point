`include "../carry_lookahead_adder_4bits_unit/carry_lookahead_adder_4bits_unit.v"
module carry_lookahead_adder_16bits (
    input [15:0] in0,
    input [15:0] in1,
    input carry_in,
    output [15:0] sum,
    output PG,
    output GG

);

wire [3:0] P;
wire [3:0] G;
wire [3:0] carry_lookahead;

assign PG=P[0]&P[1]&P[2]&P[3];
assign GG=G[3]|(G[2]&P[3])|(G[1]&P[3]&P[2])|(G[0]&P[3]&P[2]&P[1]);

assign carry_lookahead[0]=carry_in;
genvar i;
generate
    for(i=1;i<=3;i=i+1)begin
        assign carry_lookahead[i]=G[i-1]|(P[i-1]&carry_lookahead[i-1]);
    end
endgenerate

//make four
carry_lookahead_adder_4bits_unit carry_lookahead_adder_4bits_unit0(
    .in0(in0[3:0]),
    .in1(in1[3:0]),
    .carry_in(carry_lookahead[0]),
    .sum(sum[3:0]),
    .PG(P[0]),
    .GG(G[0])
);

carry_lookahead_adder_4bits_unit carry_lookahead_adder_4bits_unit1(
    .in0(in0[7:4]),
    .in1(in1[7:4]),
    .carry_in(carry_lookahead[1]),
    .sum(sum[7:4]),
    .PG(P[1]),
    .GG(G[1])
);

carry_lookahead_adder_4bits_unit carry_lookahead_adder_4bits_unit2(
    .in0(in0[11:8]),
    .in1(in1[11:8]),
    .carry_in(carry_lookahead[2]),
    .sum(sum[11:8]),
    .PG(P[2]),
    .GG(G[2])
);

carry_lookahead_adder_4bits_unit carry_lookahead_adder_4bits_unit3(
    .in0(in0[15:12]),
    .in1(in1[15:12]),
    .carry_in(carry_lookahead[3]),
    .sum(sum[15:12]),
    .PG(P[3]),
    .GG(G[3])
);
endmodule