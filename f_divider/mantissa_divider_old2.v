module mantissa_divider #(
    parameter BIT_WIDTH=23
) (
    input [31:0] in0,
    input [31:0] in1,
    output [BIT_WIDTH-1:0] out,
    output carry_down
);
//don't know in0_M>in1_M??
integer  i;
reg [2*BIT_WIDTH+1:0] A_Q;
reg [BIT_WIDTH+1:0] M;
reg [BIT_WIDTH+1:0] M_two_complement;
integer shitf_cnt;
wire [31:0] iter_max;
assign iter_max = BIT_WIDTH+1;
assign out=A_Q[0 +: BIT_WIDTH];
reg carry_down;
always @(*) begin
    //initial 
    carry_down=0;
    shitf_cnt=0;
    A_Q=0;
    A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]={2'b01,{in0[BIT_WIDTH-1:0]}};
    M={2'b01,{in1[BIT_WIDTH-1:0]}};
    //2의 보수화
    M_two_complement= ~M + {{(BIT_WIDTH+1){1'b0}},1'b1};
    
    i=0;
    while (i<iter_max) begin
    
         if(A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]>M) begin
            //#10;
            A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]+M_two_complement;
            A_Q[0]=1'b1;
            A_Q=A_Q<<1;
            i=i+1;
        end else begin
            //#10;
            A_Q=A_Q<<1;
            i=i+1;
        end
    end

    //last
    if(A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]>M) begin
           // #10;
            A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]+M_two_complement;
            A_Q[0]=1'b1;
    end

    // for(i=0; i<iter_max; i=i+1)begin
    //     #10;
    //     shitf_cnt=shitf_cnt+1;
    //     if(A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]>M) begin
    //         A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]+M_two_complement;
    //         A_Q[0]=1'b1;
    //     end else begin
    //         A_Q[0]=1'b0;
    //     end
    //     #10;
    //     A_Q=A_Q<<1;
    //     // A_Q=A_Q<<1;

    //     // A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]+M_two_complement;
    //     // case (A_Q[2*BIT_WIDTH+1])
    //     //     1'b0:begin
    //     //         //q[LSB] = 1
    //     //         A_Q[0]=1'b1;
    //     //     end
    //     //     1'b1: begin
    //     //         //restore
    //     //         A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+1]+M;
    //     //         A_Q[0]=1'b0;
    //     //     end 
    //     // endcase
     
    // end
    // //shift 없는 연산 한번더
    // if(A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]>M) begin
    //     A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]=A_Q[2*BIT_WIDTH+1 -:BIT_WIDTH+2]+M_two_complement;
    //     A_Q[0]=1'b1;
    // end else begin
    //     A_Q[0]=1'b0;
    // end
    carry_down=~A_Q[BIT_WIDTH+1];
    if(carry_down)begin
       A_Q=A_Q>>1; 
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