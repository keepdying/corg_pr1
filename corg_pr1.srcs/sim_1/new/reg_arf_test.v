`timescale 1ns / 1ps

module reg_arf_test();
    reg Clock;
    reg [7:0] I;
    reg [1:0] FunSel;
    reg [2:0] RegSel;
    reg [1:0] OutCSel;
    reg [1:0] OutDSel;
    wire [7:0] OutC;
    wire [7:0] OutD;
    
    arf_module uut(Clock, I, FunSel, RegSel, OutCSel, OutDSel, OutC, OutD);
    
    initial begin
        Clock=0; I=8'd1; FunSel=2'b10; RegSel=4'b1011; OutCSel=2'b00; OutDSel=2'b01; #250;
        I=8'd17; FunSel=2'b10; RegSel=4'b1101; OutCSel=2'b00; OutDSel=2'b10; #250;
        I=8'd191; FunSel=2'b10; RegSel=4'b1111; OutCSel=2'b10; OutDSel=2'b11; #250;
        I=8'd191; FunSel=2'b01; RegSel=4'b1011; OutCSel=2'b11; OutDSel=2'b00; #250;
        I=8'd191; FunSel=2'b00; RegSel=4'b1101; OutCSel=2'b01; OutDSel=2'b10; #250;
        I=8'd191; FunSel=2'b11; RegSel=4'b0000; OutCSel=2'b01; OutDSel=2'b10; #250;
        I=8'd191; FunSel=2'b00; RegSel=4'b1111; OutCSel=2'b10; OutDSel=2'b11; #250;
    end
    always begin
        Clock <= ~Clock; #125;
        Clock <= ~Clock; #125;
    end
endmodule
