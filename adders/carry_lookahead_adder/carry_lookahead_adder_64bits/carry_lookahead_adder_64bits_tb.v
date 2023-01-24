`timescale 1ns/1ns
`include "carry_lookahead_adder_64bits.v"

module carry_lookahead_adder_64bits_tb;

reg [63:0]in0;
reg [63:0]in1;
reg carry_in;
reg [63:0]test_result;
wire[63:0] sum;
wire GG;
wire PG;

carry_lookahead_adder_64bits u_carry_lookahead_adder_64bits0(
    .in0(in0),
    .in1(in1),
    .carry_in(carry_in),
    .sum(sum),
    .PG(PG),
    .GG(GG)
);
initial begin
    $dumpfile("carry_lookahead_adder_64bits_tb.vcd");
    $dumpvars(0);
end

integer i,j,k;
initial begin
    in0=64'h00000000; in1=64'h00000000; carry_in=1'b0; k=0;
    #100
    $display("start time: %t",$time);

    for(i=0;i<=64'h000000000000000f;i=i+1)begin
        in0=i;
        for(j=0;j<=64'h000000000000000f;j=j+1)begin
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
    if(k==0) $display("all correct!!");
    $display("end time: %t",$time);
end

endmodule