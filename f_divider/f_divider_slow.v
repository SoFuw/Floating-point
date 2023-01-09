`timescale 1ns/1ns
`include "mantissa_divider.v"
module f_divider_slow(
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out
);
//in0/in1 
reg [31:0] res;
wire carry;
wire [FRACTION_BIT_WIDTH-1:0]out_fraction;
localparam FLOAT_32_BIAS = 8'h7f; //127 
localparam FRACTION_BIT_WIDTH = 23;

mantissa_divider#(
    .BIT_WIDTH(FRACTION_BIT_WIDTH)
) u_mantisaa_divider_0 (
    .in0(in0),
    .in1(in1),
    .out(out_fraction),
    .carry_down(carry)
);

always@(posedge clk or negedge rstn)begin
    if(!rstn) begin
        out <={32{1'b0}};
    end
    else begin
        out <= res;
    end
end 

always@(*)begin
    //cal sign bit
    res[31]=in0[31]^in1[31];

    //cal bias
    if(in0[30:23]<in1[30:23])begin
        res[30:23]=in1[30:23]-in0[30:23]+FLOAT_32_BIAS;
    end else begin
        res[30:23]=in0[30:23]-in1[30:23]+FLOAT_32_BIAS;
    end
    if(carry) res[30:23]=res[30:23]-1'b1;
    res[0+:FRACTION_BIT_WIDTH]=out_fraction;

end

endmodule