module carry_lookahead_adder_unit (
    input[3:0] G,
    input[3:0] P,
    input carry_in,
    output[4:0] carry_lookahead
);
assign carry_lookahead[0]=carry_in;
genvar i;
generate
    for(i=1;i<=4;i=i+1)begin : gen_lookahead
        assign carry_lookahead[i]=G[i-1]+P[i-1]&carry_lookahead[i-1];
    end
endgenerate






endmodule