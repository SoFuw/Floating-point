`timescale 1ns/1ns
`include "ripple_carry_adder.v"

module ripple_carry_adder_tb;

localparam BIT_WIDTH = 32;
reg [BIT_WIDTH-1:0]in0;
reg [BIT_WIDTH-1:0]in1;
reg carry_in;
reg [BIT_WIDTH:0]test_result;
wire[BIT_WIDTH-1:0]sum;
wire carry_out;

ripple_carry_adder #(
    .BIT_WIDTH(BIT_WIDTH)
) u_ripple_carry_adder(
    .in0(in0),
    .in1(in1),
    .carry_in(carry_in),
    .out(sum),
    .carry_out(carry_out)
);


initial begin
    $dumpfile("ripple_carry_adder_tb.vcd");
    $dumpvars(0);
end

integer i,j,k;
initial begin
    in0=32'h0000; in1=32'h0000; carry_in=1'b0; k=0;
    #100
    $display("start time: %t",$time);

    for(i=0;i<=32'h00000000;i=i+1)begin
        in0=i;
        for(j=0;j<=32'h0000ffff;j=j+1)begin
            #10;
            in1=j;
            test_result=i+j;
            #10;
            if(test_result!={carry_out,sum}) begin
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