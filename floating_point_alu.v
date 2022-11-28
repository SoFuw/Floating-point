`timescale 1ns/1ps
`include "./f_adder/f_adder.v"
//with binary32

module f32_alu(
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    input [1:0] opcode,
    output [31:0] out,
    output [1:0] opOut 
);
    
reg [31:0] out;
wire [31:0] adder_out;
reg [1:0] opOut;
// op 00 add 01 sub 10 multi 11 divide
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        out <= {32{1'b0}};
        opOut <= {2{1'b0}};
    end
    
end


f_adder u_f_adder(
    .clk(clk),
    .rstn(rstn),
    .in0(in0),
    .in1(in1),
    .op(opcode[0]),
    .out(adder_out)
);

endmodule