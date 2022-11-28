`timescale 1ns/1ps

module test;
reg in1,in2,clk;
wire in0 = in2;

assign #10 in0 =  in2;

always #10 clk = ~clk ;
// always @(posedge clk) begin
//     in0 <= @(posedge in1) in2;
// end


initial begin
    $dumpfile("test.vcd");
    $dumpvars(1);
end

initial begin
    #10
    in1=0; in2=0;
    @(posedge clk);
    in2=1;
    @(posedge clk);
    in1=1;

    #10
    $finish;

end
    
endmodule