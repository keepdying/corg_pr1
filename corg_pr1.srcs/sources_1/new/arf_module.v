module arf_module(I, Clock, OutCSel, OutDSel, FunSel, RegSel, OutC, OutD);
    input Clock;
    input [7:0] I;
    input [1:0] FunSel;
    input [2:0] RegSel;
    input [1:0] OutCSel;
    input [1:0] OutDSel;
    wire [7:0] PC;
    wire [7:0] AR;
    wire [7:0] SP;
    output reg [7:0] OutC;
    output reg [7:0] OutD;
    
    reg_8bit pc(.E(!RegSel[2]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(PC));
    reg_8bit ar(.E(!RegSel[1]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(AR));
    reg_8bit sp(.E(!RegSel[0]) , .Clock(Clock), .FunSel(FunSel), .I(I), .Q(SP));
    
    always @(*)
        begin
            case(OutCSel)
            2'b00: OutC <= PC;
            2'b01: OutC <= PC;
            2'b10: OutC <= AR;
            2'b11: OutC <= SP;
            endcase
            
            case(OutDSel)
            2'b00: OutD <= PC;
            2'b01: OutD <= PC;
            2'b10: OutD <= AR;
            2'b11: OutD <= SP;
            endcase
       end
 endmodule