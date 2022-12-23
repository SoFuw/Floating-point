
`timescale 1ns/1ns
`include "mantissa_divider.v"
module mantissa_divider_tb;
    localparam  MY_BIT_WIDTH = 5;
    reg [31:0] in0,in1;
    wire [MY_BIT_WIDTH-1:0] out;
    
    
mantissa_divider #(
    .BIT_WIDTH(MY_BIT_WIDTH)
) u_mantisaa_divider(
    .in0(in0),
    .in1(in1),
    .out(out)
);

initial begin
    $dumpfile("mantisaa_divider.vcd");
    $dumpvars(0);
end

initial begin
    in0=5'b01100; in1=5'b00100;
    #1000 $finish;
end

endmodule