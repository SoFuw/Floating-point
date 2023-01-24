module moduleName #(
    parameter BIT_WIDTH=32
) (
    input [BIT_WIDTH-1:0] in0,
    input [BIT_WIDTH-1:0] in1,
    input [BIT_WIDTH-1:0] in2,
    output [BIT_WIDTH-1:0] out,
    
);

wire ps[BIT_WIDTH:0];
wire sc[BIT_WIDTH-1:0];

genvar i
generate
    for(i=0;i<BIT_WIDTH;i=i+1)begin
        ps[i]=in0[i]^in1[i]^in2[i];
        sc[i]=(in0[i]&in1[i])|(in1[i]&in2[i])|(in2[i]&in0[i]);
    end
    ps[BIT_WIDTH] = 1'b0;
    sc=sc << 1;
endgenerate


endmodule