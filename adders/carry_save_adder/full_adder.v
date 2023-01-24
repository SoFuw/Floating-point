module full_adder(
    input in0,
    input in1,
    input carry_in,
    output sum,
    output carry_out
);

assign sum=in0 ^ in1 ^ carry_in;
assign carry_out=(in0&in1)|(in1&carry_in)|(in0|carry_in);



endmodule