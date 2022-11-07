module f_comparator (
    input [31:0] in0,
    input [31:0] in1,
    output res
);


wire [7:0] e_in0, e_in1;
wire [22:0] s_in0, s_in1;
reg e_res,s_res;

//exponent
assign e_in0 = in0[30:23];
assign e_in1 = in1[30:23];
//significant
assign s_in0 = in0[22:0];
assign s_in1 = in1[22:0];

//cal if in0>in1...
always @(*) begin
    e_res = 0;
    s_res = 0;
    if(e_in0 > e_in1)
        e_res = 1'b1;
    if(s_in0 > s_in1)
        s_res = 1'b1;
end
assign res = e_res | s_res;

endmodule