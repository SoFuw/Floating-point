`timescale 1ns/10ps

module adder #(
    parameter BITS_LENGTH = 32
) (
    input [BITS_LENGTH-1:0] in0,
    input [BITS_LENGTH-1:0] in1,
    input op,
    output carry,
    output [BITS_LENGTH-1:0] out
);

reg [BITS_LENGTH :0 ] res;

always @(*) begin
    if(op)
        res = in0 + in1;
    else 
        res = in0 - in1;
end

assign out = res[BITS_LENGTH-1:0];
assign carry = res[BITS_LENGTH];
    
endmodule