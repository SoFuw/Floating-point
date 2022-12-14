`timescale 1ns/10ps
`include "../f_comparator.v"
module f_adder (
    input clk,
    input rstn,
    input [31:0] in0,
    input [31:0] in1,
    input op,
    output reg [31:0] out

);

wire in0_bt_in1;
reg [31:0] bigger;
reg [31:0] smaller;
reg check_sign;
reg [7:0] exp;
reg [31:0] result;
//미리 부호를 처리하는게 좋을거 같다는 생긱이 들지 않뉘? ㅋ..
/// 보수 만드는걸 해야긋네

f_comparator u_f_comparator(
    .in0(in0),
    .in1(in1),
    .res(in0_bt_in1)
);

always@(posedge clk, negedge rstn)begin
    if(!rstn) begin
        bigger <= {32{1'b0}};
        smaller <= {32{1'b0}};
        exp <= {8{1'b0}};
        result <= {32{1'b0}};
        check_sign <= 1'b0;
    end else begin
        //1 cycle delay...
        out <= result;
    end
end

always@(*)begin
    //check sign..
    if(!op) 
        check_sign = in1[31];
    else 
        check_sign = ~in1[31];

    //set bigger..
    bigger = (in0_bt_in1 == 1) ? in0 : {check_sign,in1[30:0]};
    smaller = (in0_bt_in1 == 0) ? in0 : {check_sign,in1[30:0]};

    //cal exp 
    exp = bigger[30:23] - smaller[30:23];

    //shift 
    smaller[22:0] = smaller[22:0] >> exp;

    //cal
    result[23:0] = (bigger[31] ^ smaller[31]) ? bigger[22:0] - smaller[22:0]: bigger[22:0] + smaller[22:0];

    //exp with carry 
    if(result[23])
        result[30:23] = bigger[30:23] + {{7{1'b0}},1'b1};
    else 
        result[30:23] = bigger[30:23];

    // assign sign

    result[31] = bigger[31];
end
    
endmodule


    // //cal  
    // case ({bigger[31],smaller[31]})
    //     2'b00: result[23:0] = bigger[22:0] + smaller[22:0];
    //     2'b01: result[23:0] = bigger[22:0] - smaller[22:0];
    //     //this case.. ...!? same bacause sign bit.
    //     2'b10: result[23:0] = bigger[22:0] - smaller[22:0];
    //     2'b11: result[23:0] = bigger[22:0] + smaller[22:0];
    // endcase