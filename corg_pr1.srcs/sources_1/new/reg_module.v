module reg_module(
    input [7:0] I,
    input Clock,
    input [1:0] FunSel,
    input [3:0] RegSel,
    input [1:0] OutASel,
    input [1:0] OutBSel,
    output reg [7:0] OutA,
    output reg [7:0] OutB
    );
    
    wire [7:0] Reg1;
    wire [7:0] Reg2;
    wire [7:0] Reg3;
    wire [7:0] Reg4;
    
    reg_8bit reg1(.E(!RegSel[3]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(Reg1));
    reg_8bit reg2(.E(!RegSel[2]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(Reg2));
    reg_8bit reg3(.E(!RegSel[1]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(Reg3));
    reg_8bit reg4(.E(!RegSel[0]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(Reg4));
    
    always @(*)
        begin
            case(OutASel)
            2'b00: OutA <= Reg1;
            2'b01: OutA <= Reg2;
            2'b10: OutA <= Reg3;
            2'b11: OutA <= Reg4;
            endcase
            
            case(OutBSel)
            2'b00: OutB <= Reg1;
            2'b01: OutB <= Reg2;
            2'b10: OutB <= Reg3;
            2'b11: OutB <= Reg4;
            endcase
       end
 endmodule