`timescale 1ns/1ns

//unsigned_multiplier
//round to down
//GRS를 이용해서 rount to nearest even
module mantissa_multiplier #(
    parameter integer BIT_WIDTH = 23
) (
    input [BIT_WIDTH-1:0] in0,
    input [BIT_WIDTH-1:0] in1,
    output reg [BIT_WIDTH-1:0] out,
    output reg carry
);

reg [(BIT_WIDTH + 1) * 2  : 0] res;
reg [bit_cnt_func(BIT_WIDTH+1)-1:0] i;
reg [1:0] flag_zero;
reg mantissa_last;
reg G,R,S;
localparam BOTH_ZERO=2'b11;
localparam EITHER_ZERO_LEFT=2'b10;
localparam EITHER_ZERO_RIGHT=2'b01;
localparam NITHER_ZERO=2'b00;
always@(*)begin
    flag_zero = (in0 == 0 && in1 == 0) ? BOTH_ZERO : (in0 == 0  ? EITHER_ZERO_LEFT : (in1 == 0 ? EITHER_ZERO_RIGHT : NITHER_ZERO));
    //to avoid latch
    res = {(BIT_WIDTH * 2 + 2){1'b0}};
    //set 1.xxxxxxx...
    res[BIT_WIDTH:0] = {1'b1,in1};

    for(i = BIT_WIDTH+1; i > 0; i = i - 1'b1)begin
        
        if(res[0]) res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] = res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] + {2'b01,in0};

        res = res >>1;
        carry = res[(BIT_WIDTH+1)*2-1];
    end
    
    if(carry)begin
        mantissa_last=res[BIT_WIDTH+1];
        G=res[BIT_WIDTH];
        R=res[BIT_WIDTH-1];
        S=|res[BIT_WIDTH-2:0];
       
    end else begin
        mantissa_last=res[BIT_WIDTH];
        G=res[BIT_WIDTH-1];
        R=res[BIT_WIDTH-2];
        S=|res[BIT_WIDTH-3:0];
    
    end 

    case ({G,R,S})
        3'b000:begin
            //round down(do nothing)
        end 
        3'b001:begin
            //round down(do nothing)
        end 
        3'b010:begin
            //round down(do nothing)
        end 
        3'b011:begin
            //round down(do nothing)
        end 
        3'b100:begin
            if(mantissa_last)begin
                res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] = res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] + 1'b1;
                //round up case
            end
            //round down(do nothing)
        end 
        3'b101:begin
            res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] = res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] + 1'b1;
            
        end 
        3'b110:begin
            res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] = res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] + 1'b1;
            
        end 
        3'b111:begin
            res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] = res[(BIT_WIDTH+1) * 2 -: (BIT_WIDTH + 2)] + 1'b1;
            
        end 
        default:begin
            //do noting 
        end
         
    endcase
    if(flag_zero==BOTH_ZERO) out = 0;
    else if(flag_zero==EITHER_ZERO_RIGHT) out= in0[BIT_WIDTH-1:0];
    else if(flag_zero==EITHER_ZERO_LEFT) out= in1[BIT_WIDTH-1:0]; 
    else if(carry) out = res[((BIT_WIDTH + 1) * 2 -2)  -: (BIT_WIDTH)];
    else out = res[((BIT_WIDTH + 1) * 2 -3)  -: (BIT_WIDTH)];
//BIT_WIDTH * 2 + 1 -: (BIT_WIDTH+1) 여기부터 시작하면 carry시에 값을 날려버리는 현상이 존재한다
//당연한건데 이딴걸 못보고 븅순..
// 어차피 캐리 밀어버려서 BIT_WIDTH*2 + 2 해도 ㄱㅊ
    
end


//verilog에서 이게 한계다 변수 추가를 하는건 불가능함 ㅋㅋ
function integer bit_cnt_func;
    input integer bitwith;
    for(bit_cnt_func = 0;bitwith>0;bitwith= bitwith/2) bit_cnt_func=bit_cnt_func+1;
    //3비트의 signicant 를 받았다면 1번 더 해야하니까 한번 더 더해줌 ㅋ
endfunction
endmodule

