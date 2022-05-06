`timescale 1ns / 1ps


module reg_ir_test();
    reg [7:0] I;
    reg Clock;
    reg Enable;
    reg [1:0] FunSel;
    reg lh;
    wire [15:0] IRout;
    
    reg_ir uut(I, Clock, Enable, FunSel, lh, IRout);
    
    initial begin
       Clock=0; I=8'h1; Enable=0; FunSel=2'b10; lh=0; #142.85;
       I=8'h1; Enable=1; FunSel=2'b10; lh=0; #142.85;
       I=8'h7; Enable=1; FunSel=2'b10; lh=1; #142.85;
       I=8'h7; Enable=1; FunSel=2'b01; lh=0; #142.85;
       I=8'h7; Enable=1; FunSel=2'b01; lh=1; #142.85;
       I=8'h7; Enable=1; FunSel=2'b00; lh=0; #142.85;
       I=8'h7; Enable=1; FunSel=2'b11; lh=0; #142.85;
    end
    
    always begin
        Clock <= ~Clock; #71.42;
        Clock <= ~Clock; #71.42;  
    end
endmodule
