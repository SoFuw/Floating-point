`include "full_adder.v"
module ripple_carry_adder #(
    parameter BIT_WIDTH=32
) (
    input [BIT_WIDTH-1:0] in0,
    input [BIT_WIDTH-1:0] in1,
    input carry_in,
    output [BIT_WIDTH-1:0] out,
    output carry_out
);

wire carry[BIT_WIDTH:0];
assign carry[0]=carry_in;
genvar i;
generate
    for(i=0;i<BIT_WIDTH;i=i+1) begin
        full_adder u_full_adder(
            .in0(in0[i]),
            .in1(in1[i]),
            .carry_in(carry[i]),
            .sum(out[i]),
            .carry_out(carry[i+1])
        );
    end
endgenerate

endmodule