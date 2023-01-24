module carry_lookahead_adder_4bits_unit(
    input[3:0] in0,
    input[3:0] in1,
    input carry_in,
    output[3:0] sum,
    output PG,
    output GG
);

wire [3:0]C;
wire [3:0]P;
wire [3:0]G;

assign C[0]=carry_in;
assign G=in0&in1;
assign P=in0^in1;
assign sum=P^C;

genvar i;


generate 
    for(i=1;i<=3;i=i+1)begin : gen_lookahead
        assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
endgenerate

assign PG=P[0]&P[1]&P[2]&P[3];
assign GG=G[3]|(G[2]&P[3])|(G[1]&P[3]&P[2])|(G[0]&P[3]&P[2]&P[1]);
endmodule