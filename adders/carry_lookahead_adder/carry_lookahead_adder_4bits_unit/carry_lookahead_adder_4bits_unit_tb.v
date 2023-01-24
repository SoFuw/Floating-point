`timescale 1ns/1ns
`include "carry_lookahead_adder_4bits_unit.v"

module carry_lookahead_adder_4bits_unit_tb;

reg [3:0]in0;
reg [3:0]in1;
reg carry_in;
reg [3:0]test_result;
wire[3:0] sum;
wire GG;
wire PG;

carry_lookahead_adder_4bits_unit carry_lookahead_adder_4bits_unit0(
    .in0(in0),
    .in1(in1),
    .carry_in(carry_in),
    .sum(sum),
    .PG(PG),
    .GG(GG)
);
initial begin
    $dumpfile("carry_lookahead_adder_4bits_unit_tb.vcd");
    $dumpvars(0);
end

integer i,j,k;
initial begin
    k=0;
    in0=4'b0000; in1=4'b0000; carry_in=1'b0;
    #100
    for(i=0;i<=4'b1111;i=i+1'b1)begin
        in0=i;
        for(j=0;j<=4'b1111;j=j+1'b1)begin
            #10;

            in1=j;
            test_result=i+j;
            #10;
            if(test_result!=sum) begin
                k=1;
                $display("wrong case - test:%b sum:%b",test_result,sum);
                $display("in0 :%b in1 : %b",in0,in1);
                $display("---------------");
            end
        end
    end
    if(k==0) $display("all cases correct!");
end

endmodule