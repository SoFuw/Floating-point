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

reg [BIT_WIDTH+1:0] A;
reg [BIT_WIDTH+1:0] Q;
reg [BIT_WIDTH+1:0] M;
reg [BIT_WIDTH+1:0] M_two_complement;
integer shitf_cnt;
wire [31:0] iter_max;
assign iter_max = BIT_WIDTH+1;
assign out=Q[BIT_WIDTH:1];
reg carry_down;
always @(*) begin
    //initial 
    carry_down=0;
    shitf_cnt=0;
    A=0;
    Q=0;
    A={2'b01,{in0[BIT_WIDTH-1:0]}};
    M={2'b01,{in1[BIT_WIDTH-1:0]}};
    //2의 보수화
    M_two_complement= ~M + {{(BIT_WIDTH+1){1'b0}},1'b1};
    i=0;
    while (i<iter_max) begin
    
         if(A>M) begin
            //#10;
            A=A+M_two_complement;
            Q[0]=1'b1;
            A=A<<1;
            Q=Q<<1;
            i=i+1;
        end else begin
            //#10;
            A=A<<1;
            Q=Q<<1;
            i=i+1;
        end
    end

    //last
    if(A>M) begin
           // #10;
            A=A+M_two_complement;
            Q[0]=1'b1;
    end

    carry_down=~Q[BIT_WIDTH+1];
    if(carry_down)begin
       Q=Q<<1; 
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