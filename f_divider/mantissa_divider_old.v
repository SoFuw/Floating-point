module mantissa_divider #(
    parameter BIT_WIDTH=23;
) (
    input [31:0] in0,
    input [31:0] in1,
    output [BIT_WIDTH-1:0] out_quotient
    output [BIT_WIDTH-1:0] out_remainder
    output 
);
//don't know in0_M>in1_M??
integer  i;
reg [2*BIT_WIDTH+1:0] A_Q;
reg [BIT_WIDTH+1:0] M;
reg [BIT_WIDTH+1:0] M_two_complement

assign [calIterBIt(BIT_WIDTH)-1:0] iter_max = BIT_WIDTH;
assign out_quotient=
always @(*) begin
    //initial 
    A_Q={{(BIT_WIDTH+1){1'b0}},1'b1,in0[BIT_WIDTH-1:0]};
    M={2'b01,in1[BIT_WIDTH-1:0]}
    //2의 보수화
    M_two_complement=~M + {(BIT_WIDTH+1){1'b0},1'b1};
    
    for(i=0; i<iter_max; i=i+1)begin
        A_Q=A_Q<<1;
        A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]+M_two_complement;
        case (A_Q[2'BIT_WIDTH+1])
            1'b0:begin
                //q[LSB]=1
                A_Q[0]=1'b1;
            end
            1'b1: begin
                //restore
                A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]+M;
                A_Q[0]=1'b0;
            end 
        endcase
    end
end
//can't take     

function calIterBIt;
input bit_width;
integer i;
begin
    calIterBIt=0;
    for(i=bit_width;i>0;i++) begin
        i=i>>1;
        calIterBIt=calIterBIt+1;
    end
end
endfunction
endmodule