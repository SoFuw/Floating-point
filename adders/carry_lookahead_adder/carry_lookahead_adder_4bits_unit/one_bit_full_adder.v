module one_bit_full_adder(
    input in0,
    input in1,
    input carry_in,
    output sum,
    output g,
    output p
);

assign sum=in0 ^ in1 ^ carry_in;
assign p=in0 ^ in1;
assign g=in0 & in1;


endmodule