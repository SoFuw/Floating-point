`include "../carry_lookahead_adder_16bits_unit/carry_lookahead_adder_16bits.v"
module carry_lookahead_adder_64bits (
    input [63:0] in0,
    input [63:0] in1,
    input carry_in,
    output [63:0] sum,
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
carry_lookahead_adder_16bits u_carry_lookahead_adder_16bits0(
    .in0(in0[15:0]),
    .in1(in1[15:0]),
    .carry_in(carry_lookahead[0]),
    .sum(sum[15:0]),
    .PG(P[0]),
    .GG(G[0])
);

carry_lookahead_adder_16bits u_carry_lookahead_adder_16bits1(
    .in0(in0[31:16]),
    .in1(in1[31:16]),
    .carry_in(carry_lookahead[1]),
    .sum(sum[31:16]),
    .PG(P[1]),
    .GG(G[1])
);

carry_lookahead_adder_16bits u_carry_lookahead_adder_16bits2(
    .in0(in0[47:32]),
    .in1(in1[47:32]),
    .carry_in(carry_lookahead[2]),
    .sum(sum[47:32]),
    .PG(P[2]),
    .GG(G[2])
);

carry_lookahead_adder_16bits u_carry_lookahead_adder_16bits3(
    .in0(in0[63:48]),
    .in1(in1[63:48]),
    .carry_in(carry_lookahead[3]),
    .sum(sum[63:48]),
    .PG(P[3]),
    .GG(G[3])
);
endmodule