`timescale 1ns/1ns
`include "f_divider_slow.v"

module f_divider_slow_tb;

localparam BIT_WIDTH=32;
reg clk,rstn;
reg [BIT_WIDTH-1:0] in0;
reg [BIT_WIDTH-1:0] in1;
wire [BIT_WIDTH-1:0] out;

reg [22:0]r_in0,r_in1;

integer i;
integer f;

f_divider_slow u_f_divider_slow(
    .clk(clk),
    .rstn(rstn),
    .in0(in0),
    .in1(in1),
    .out(out)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("f_divider_slow.vcd");
    $dumpvars(0);
end

initial begin
    f=$fopen("f_divider_slow_log.txt");
    $display("start time... [$0d]\n",$time);
    rstn = 0 ; clk = 0; in0=0; in1=0;
    $display("reset start...! [%0d]\n",$time);
    #100 rstn =0 ;
    #10 rstn =1;
    $display("reset end.. push random data...[$0d]\n",$time);

     for(i=0;i<128;i++)begin
        @(posedge clk);
        r_in0=$random;
        r_in1=$random;
        in0={1'b0,8'b01111111,r_in0};
        in1={1'b0,8'b00000001,r_in1};

        #50
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        $fwrite(f,"%b\n",out);
    end
    #100 $fwrite(f,"quit!");
    $finish;

end

endmodule