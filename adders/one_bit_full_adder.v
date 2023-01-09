module one_bit_full_adder(
    input in0,
    input in1,
    input carry,
    output sum,
    output g,
    output p
);

assign sum=in0 ^ in1 ^ carry;
assign p=in0 ^ in1;
assign g=in0 & in1;


endmodule