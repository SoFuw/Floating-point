`timescale 1ns/1ns

//unsigned_multiplier
//round to down
module mantissa_multiplier #(
    parameter integer BIT_WIDTH = 23
) (
    input [BIT_WIDTH-1:0] in0,
    input [BIT_WIDTH-1:0] in1,
    output [BIT_WIDTH-1:0] out
);

reg [(BIT_WIDTH+1) * 2 : 0] res;
reg [bit_cnt_func(BIT_WIDTH+1)-1:0] i;
reg flag_zero;

always@(*)begin
    flag_zero = (in0 == 0 || in1 == 0) ? 1 : 0;
    //to avoid latch
    res = {(BIT_WIDTH * 2 + 2){1'b0}};
    //set 1.xxxxxxx...
    res[BIT_WIDTH:0] = {1'b1,in1};

    for(i = BIT_WIDTH+1; i > 0; i = i - 1'b1)begin
        if(flag_zero) #5 res = 0;
        else if(res[0]) #5 res[BIT_WIDTH * 2 + 1 -: (BIT_WIDTH+1)] = res[BIT_WIDTH * 2 + 1 -: (BIT_WIDTH+1)] + {1'b1,in0};

        #5 res = res >>1;
    end

end

//don't need 1 of 1.xxxx 
assign out = res[BIT_WIDTH * 2 -: (BIT_WIDTH+1)];
    

//verilog에서 이게 한계다 변수 추가를 하는건 불가능함 ㅋㅋ
function integer bit_cnt_func;
    input integer bitwith;
    for(bit_cnt_func = 0;bitwith>0;bitwith= bitwith/2) bit_cnt_func=bit_cnt_func+1;
    //3비트의 signicant 를 받았다면 1번 더 해야하니까 한번 더 더해줌 ㅋ
endfunction
endmodule

