`timescale 1ns/10ps

module f_multiplier (
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out
);

reg [31:0] res;

localparam FLOAT_32_BIAS = 8'h7f; //127 

always @(posedge clk or negedge rstn)begin
    if(!rstn) begin
        res <= {32{1'b0}};
        out <= {32{1'b0}};
    end else begin
        //1 cycle delay..
        out <= result;
    end

end

always @(*) begin
    res[31]= in0[31] ^ in1[31]; //assign sign shit~
    res[30:23] = (in0[30:23]-FLOAT_32_BIAS) + (in1[30:23]-FLOAT_32_BIAS) + FLOAT_32_BIAS; //overflow때문에 미리 이렇게 처리 해야 한다능 ㅎ 
    
end

//func은 조합회로 모델링에 사용이 가능하다.. 라능거.

function mantissa_multiply
input 

endfunction


endmodule

