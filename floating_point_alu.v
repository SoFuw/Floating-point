`timescale 1ns/1ps

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
reg [1:0] opOut;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        out <= {32{1'b0}};
        opOut <= {2{1'b0}};
    end
    
end
endmodule