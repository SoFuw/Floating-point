`timescale 1ns/10ps
module f_comparator (
    input [31:0] in0,
    input [31:0] in1,
    output res
);

wire [30:0] abs_in0, abs_in1;

assign abs_in0 = in0[30:0];
assign abs_in1 = in1[30:0];
assign res = abs_in0 > abs_in1; 

endmodule