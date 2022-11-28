`timescale 1ns/10ps

//unsigned_multiplier
//round to down
module mantissa_multiplier #(
    parameter integer BIT_WIDTH = 23
) (
    input [BIT_WIDTH-1:0] in0,
    input [BIT_WIDTH-1:0] in1,
    output [BIT_WIDTH-1:0] out
);

//전체적으로 비트 수정 필요.. 이거 계싼실수함 ㅋ
reg [(BIT_WIDTH * 2 + 2) : 0] res;
reg [bit_cnt_func(BIT_WIDTH)-1:0] i;

always@(*)begin

    //to avoid latch
    res = {(BIT_WIDTH * 2 + 2){1'b0}};
    //set 1.xxxxxxx...
    res[BIT_WIDTH:0] = {1'b1,in1};

    for(i = BIT_WIDTH; i > 0; i = i - 1'b1)begin
        if(res[0]) res[BIT_WIDTH * 2 + 1 -: (BIT_WIDTH+1)] = res[BIT_WIDTH * 2 + 1 -: (BIT_WIDTH+1)] + {1'b1,in0};
        res = res >>1;
    end

end

//don't need 1 of 1.xxxx 
assign out = res[BIT_WIDTH * 2 -: (BIT_WIDTH+1)];
    

//verilog에서 이게 한계다 변수 추가를 하는건 불가능함 ㅋㅋ
function integer bit_cnt_func;
    input integer bitwith;
    for(bit_cnt_func = 0;bitwith>0;bitwith= bitwith/2) bit_cnt_func=bit_cnt_func+1;
endfunction
endmodule