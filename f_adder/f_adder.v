`timescale 1ns/10ps
`include "../f_comparator.v"
module f_adder (
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    input op,
    output reg [31:0] out

);

wire in0_bt_in1;
reg [31:0] bigger;
reg [31:0] smaller;
reg [23:0] test;
reg [7:0] exp;
reg [31:0] result;

f_comparator u_f_comparator(
    .in0(in0),
    .in1(in1),
    .res(in0_bt_in1)
);

always@(posedge clk, negedge rstn)begin
    if(!rstn) begin
        bigger = {32{1'b0}};
        smaller = {32{1'b0}};
        exp = {8{1'b0}};
        result = {32{1'b0}};
    end else begin
        //1 cycle delay...
        out <= result;
    end
end

always@(*)begin
    //set bigger..
    bigger = (in0_bt_in1 == 1) ? in0 : in1;
    smaller = (in0_bt_in1 == 0) ? in0 : in1;
    //cal exp 
    exp = bigger[30:23] - smaller[30:23];
    //shift 
    smaller[22:0] = smaller[22:0] >> exp;
    // //cal  
    smaller[23:0] = (op == 0) ? (bigger[22:0] + smaller[22:0]) : (bigger[22:0] - smaller[22:0]);
    //carry 
    test = smaller[23:0];
    if(smaller[23]==1'b1)
        bigger[30:23] = bigger[30:23] + {{7{1'b0}},1'b1};
    //we use bigger sign 
    bigger[22:0] = smaller[22:0];
    //save result 
    result = bigger;
end
    
endmodule