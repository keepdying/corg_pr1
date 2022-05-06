`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2022 13:18:01
// Design Name: 
// Module Name: reg_module_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_module_test();
    reg [7:0] I;
    reg Clock;
    reg [1:0] FunSel;
    reg [3:0] RegSel;
    reg [1:0] OutASel;
    reg [1:0] OutBSel;
    wire [7:0] OutA;
    wire [7:0] OutB;
    
    reg_module uut(I, Clock, FunSel, RegSel, OutASel, OutBSel, OutA, OutB);
    
    initial begin
        Clock=0; I=8'h17; FunSel=2'b10; RegSel=4'b0000; OutASel=2'b00; OutBSel=2'b01; #250;
        I=8'h17; FunSel=2'b01; RegSel=4'b1100; OutASel=2'b10; OutBSel=2'b11; #250;
        I=8'h17; FunSel=2'b11; RegSel=4'b0001; OutASel=2'b00; OutBSel=2'b01; #250;
        I=8'h17; FunSel=2'b01; RegSel=4'b0111; OutASel=2'b01; OutBSel=2'b11; #250;
    end
    
    always begin
        Clock <= ~Clock; #125;
        Clock <= ~Clock; #125;
    end
endmodule
