`timescale  1ns/1ns
`include "unsigned_multiplier.v"
module unsigned_multiplier_tb;

localparam BIT_WIDTH = 4;
reg [BIT_WIDTH-1:0] in0;
reg [BIT_WIDTH-1:0] in1;
wire [BIT_WIDTH-1:0] out;

unsigned_multiplier#(
    .BIT_WIDTH(BIT_WIDTH)
) u_unsigned_multiplier(
    .in0(in0),
    .in1(in1),
    .out(out)
);

integer j;
integer i;


initial begin
    $dumpfile("un.vcd");
    $dumpvars(0);
end


initial begin
    in0 = 0; in1 = 0;
    $display("start!");
    for(i = 0; i <= 4'b1111 ; i= i+1)begin
        for(j=0;j<=4'b1111; j= j+1)begin
            #10 in0 = i; in1 = j;
        end
    end
    $display("done!");
    #10 $finish

end
endmodule