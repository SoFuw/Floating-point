`timescale 1ns/10ps
`include "f_adder.v"
module f_adder_tb;
    reg clk,rstn;
    reg [31:0] in0, in1;
    reg op;
    wire [31:0] out;

//call dut
f_adder u_f_adder(
    .clk(clk),
    .rstn(rstn),
    .in0(in0),
    .in1(in1),
    .op(op),
    .out(out)
);

//clk gen
always #5 clk = ~clk;

integer i;
integer f;
initial begin
    $dumpfile("f_adder.vcd");
    $dumpvars(0);
end

initial begin
    f = $fopen("f_adder_log.txt");
    $display("init val... [%0d]\n",$time);
    rstn = 0;
    clk = 0;
    op = 0;
    in0 = 0;
    in1 = 0;
    $display("reset...![%0d]\n",$time);
    #100
        rstn = 0;
    #10
        rstn = 1;
    #10
    $display("push random data..[%0d]\n",$time);
    //do.. add..
    for(i=0;i<32;i++)begin
        @(posedge clk);
        in0=$random;
        in1=$random;
        op=0;
        $fwrite(f,"%d\n",op);
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        #1
        $fwrite(f,"%b\n",out);
    end    
    
    //do.. sub..
    for(i=0;i<32;i++) begin
        @(posedge clk);
        in0=$random;
        in1=$random;
        op=1;
        $fwrite(f,"%d\n",op);
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        #1
        $fwrite(f,"%b\n",out);
    end
    @(posedge clk);
        in0=0;
        in1=0;
        op=1;
        $fwrite(f,"%d\n",op);
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        #1
        $fwrite(f,"%b\n",out);
    $display("done!\n");
    #10 $finish;
end

endmodule