`timescale 1ns/1ns
`include "f_multiplier.v"
module f_multiplier_tb;

localparam BIT_WIDTH=32;
reg clk,rstn;
reg [BIT_WIDTH-1:0] in0,in1;
wire [BIT_WIDTH-1:0] out;

f_multiplier u_f_multiplier(
    .clk(clk),
    .rstn(rstn),
    .in0(in0),
    .in1(in1),
    .out(out)
);

always #5 clk = ~clk;
integer i;
integer f;
initial begin
    $dumpfile("f_multiplier.vcd");
    $dumpvars(0);
end

initial begin
    f = $fopen("f_multiplier_log.txt");
    $display("init val... [%0d]\n",$time);
    rstn = 0;
    clk = 0;
    in0 = 0;
    in1 = 0;
    $display("reset...![%0d]\n",$time);
    #100
        rstn = 0;
    #10
        rstn = 1;
    #10
    $display("push random data..[%0d]\n",$time);
    for(i=0;i<1024;i++)begin
        @(posedge clk);
        in0=$random;
        in1=$random;
        #50
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        $fwrite(f,"%b\n",out);
    end
    #100 $fwrite(f,"quit!");
    $finish;

    
end


    
endmodule