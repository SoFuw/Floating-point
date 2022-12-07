`timescale 1ns/1ns
`include "mantissa_multiplier.v"

module f_multiplier (
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out
);

reg [31:0] res;
wire [22:0] fraction;
wire flag_carry;
localparam FLOAT_32_BIAS = 8'h7f; //127 
localparam FRACTION_BIT_WIDTH=23;
mantissa_multiplier#(
    .BIT_WIDTH(23)
) u_mantissa_multiplier(
    .in0(in0[FRACTION_BIT_WIDTH-1:0]),
    .in1(in1[FRACTION_BIT_WIDTH-1:0]),
    .out(fraction),
    .carry(flag_carry)
);

always @(posedge clk or negedge rstn)begin
    if(!rstn) begin
        out <= {32{1'b0}};
    end else begin
        //1 cycle delay..
        out <= res;
    end

end

always @(*) begin
    res={32{1'b0}};
    res[31]= in0[31] ^ in1[31]; //assign sign shit~
    res[30:23] = (in0[30:23]-FLOAT_32_BIAS) + (in1[30:23]-FLOAT_32_BIAS) + FLOAT_32_BIAS; //overflow때문에 미리 이렇게 처리 해야 한다능 ㅎ 
    
    if(flag_carry==1'b1) 
        res[30:23]=res[30:23]+{{7{1'b0}},flag_carry};
    
    res[22:0]=fraction;
end


//func은 조합회로 모델링에 사용이 가능하다.. 라능거.

endmodule

