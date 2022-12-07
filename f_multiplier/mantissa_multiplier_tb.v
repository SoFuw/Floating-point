`timescale 1ns/1ns
`include "mantissa_multiplier.v"
module mantissa_multiplier_tb;
localparam integer BIT_WIDTH = 8;

reg [BIT_WIDTH-1:0] in0;
reg [BIT_WIDTH-1:0] in1;
wire [BIT_WIDTH-1:0] out;
wire carry;

mantissa_multiplier#(
    .BIT_WIDTH(BIT_WIDTH)
) u_mantisaa_multiplier(
    .in0(in0),
    .in1(in1),
    .out(out),
    .carry(carry)
);

integer f;

initial begin
    $dumpfile("matissa_multiplier.vcd");
    $dumpvars(0);
end

integer i,j;
initial begin
    f=$fopen("mantissa_multiplier_log.txt");
    in0 = 0; in1 = 0; 
    $display("we will check all");
    for(i=0;i<={BIT_WIDTH{1'b1}};i=i+1)begin
        for(j=0;j<={BIT_WIDTH{1'b1}};j=j+1) begin
            #100 in0=i; in1=j;
            #100 $fwrite(f,"%b\n",in0);
            $fwrite(f,"%b\n",in1);
            $fwrite(f,"%b\n",carry);
            $fwrite(f,"%b\n",out);
            
        end
    end      
    $display("done!!");
    $fclose(f);
    #100 $finish;
end
endmodule