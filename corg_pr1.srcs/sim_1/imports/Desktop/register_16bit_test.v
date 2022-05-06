`timescale 1ns / 1ps


module register_16bit_test();
    reg [15:0] I;
    reg Clock;
    reg E;
    reg [1:0] FunSel;
    wire [15:0] Q;
    
    reg_16bit uut(I, Clock, E, FunSel, Q);
    
    initial begin
        Clock=0; I=16'h17; E=0; FunSel=2'b10; #166.66;
        I=16'h17; E=1; FunSel=2'b10; #166.66;
        I=16'h17; E=1; FunSel=2'b01; #166.66;
        I=16'h17; E=1; FunSel=2'b00; #166.66;
        I=16'h17; E=1; FunSel=2'b00; #166.66;
        I=16'h17; E=1; FunSel=2'b11; #166.66;
    end
    
    always begin
        Clock <= ~Clock; #83.33;
        Clock <= ~Clock; #83.33;
    end
endmodule
