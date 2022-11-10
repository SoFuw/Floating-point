`timescale 1ns/10ps
`include "./f_comparator.v"
module f_comparator_tb;

reg [31:0] in0;
reg [31:0] in1;

wire res;
integer f,cnt;

f_comparator u_f_comparator(
    .in0(in0),
    .in1(in1),
    .res(res)
);

initial begin
    $dumpfile("f_comparator.vcd");
    $dumpvars(1);
end

initial begin
    f = $fopen("f_comparator_log.txt","w");
    for(cnt = 0; cnt < 4096; cnt = cnt+ 1)
    begin
        in0 <= $random;
        in1 <= $random;
        $fwrite(f,"%d\n",cnt);
        $fwrite(f,"%b\n",in0);
        $fwrite(f,"%b\n",in1);
        $fwrite(f,"%b\n",res);
        #10;
    end
    $fclose(f);
    $finish;
end

endmodule