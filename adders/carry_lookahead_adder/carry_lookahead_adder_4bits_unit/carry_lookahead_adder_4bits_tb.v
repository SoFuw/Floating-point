`timescale 1ns/1ns
`include "carry_lookahead_adder_4bits.v"

module carry_lookahead_adder_4bits_tb;

reg [3:0]in0;
reg [3:0]in1;
reg carry_in;
reg [4:0]test_result;
wire carry_out;
wire[3:0] sum;
wire GG;
wire PG;

carry_lookahead_adder_4bits u_carry_lookahead_adder_4bits0(
    .in0(in0),
    .in1(in1),
    .carry_in(carry_in),
    .carry_out(carry_out),
    .sum(sum),
    .PG(PG),
    .GG(GG)
);
initial begin
    $dumpfile("carry_lookahead_adder_4bits_tb.vcd");
    $dumpvars(0);
end

integer i,j;
initial begin
    in0=4'b0000; in1=4'b0000; carry_in=1'b0;
    #100
    for(i=0;i<=4'b1111;i=i+1'b1)begin
        in0=i;
        for(j=0;j<=4'b1111;j=j+1'b1)begin
            #10;

            in1=j;
            test_result=i+j;
            #10;
            if(test_result[4:0]=={carry_out,sum}) $display("correct!");

        end
    end
end

endmodule