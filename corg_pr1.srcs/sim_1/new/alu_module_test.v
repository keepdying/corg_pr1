`timescale 1ns / 1ps
module alu_module_test();
    reg [3:0] FunSel;
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    reg clk;
    wire [7:0] OutALU;
    wire [3:0] OutFLAG;
    
    alu_module uut(FunSel,A,B, Cin, clk, OutALU, OutFLAG);
    
    initial begin
        clk=0; A=8'd5; B=8'd3; FunSel=4'b0100; #250; // A + B
        A=8'd5; B=8'd3; FunSel=4'b0101; #250; // A + B + Cin
        A=8'd255; B=8'd3; FunSel=4'b0101; #250; // A + B + Cin
        A=8'd5; B=8'd3; FunSel=4'b0101; #250; // A + B + Cin
    end
    
    always begin
        clk <= ~clk; #125;
        clk <= ~clk; #125;
    end
    
    always @(posedge clk)
        begin
        Cin = OutFLAG[2];
        end
        
endmodule