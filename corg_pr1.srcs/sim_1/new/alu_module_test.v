`timescale 1ns / 1ps
module alu_module_test();
    reg [3:0] FunSel;
    reg [7:0] A;
    reg [7:0] B;
    wire Cin;
    reg clk;
    wire [7:0] OutALU;
    wire [3:0] OutFLAG;
    wire [3:0] reg_flag_out;
    
    alu_module uut(FunSel, A, B, Cin, OutALU, OutFLAG);
    reg_flag reg_flag(OutFLAG, clk, reg_flag_out);
    
    assign Cin = reg_flag_out[2];
    
    initial begin
        clk=0;A=8'd0; B=8'd1; FunSel=4'b0000; #250; // A ZERO FLAG
        A=8'd1; B=8'd0; FunSel=4'b0001; #250; // B 
        A=8'd2; B=8'd1; FunSel=4'b0010; #250; // ~A
        A=8'd1; B=8'd0; FunSel=4'b0011; #250; // ~B
        A=8'd128; B=8'd128; FunSel=4'b0100; #250; // A + B
        A=8'd2; B=8'd1; FunSel=4'b0101; #250; // A + B + CIN
        A=8'd2; B=8'd1; FunSel=4'b0110; #250; // A - B = 2 - 1 = 1
        A=8'd1; B=8'd2; FunSel=4'b0110; #250; // A - B = 1 - 2 = -1
        A=8'd2; B=8'd1; FunSel=4'b0111; #250; // A AND B = 0
        A=8'd2; B=8'd1; FunSel=4'b1000; #250; // A OR B = 3
        A=8'd2; B=8'd1; FunSel=4'b1001; #250; // A XOR B = 3
        A=8'b10010000; B=8'h0; FunSel=4'b1010; #250; // lsl
        A=8'b00001001; B=8'h0; FunSel=4'b1011; #250; // lsr
        A=8'b10010000; B=8'h0; FunSel=4'b1100; #250; // asl
        A=8'b10010000; B=8'h0; FunSel=4'b1101; #250; // asr
        A=8'b10010000; B=8'h0; FunSel=4'b1110; #250; // csl
        A=8'b00001001; B=8'h0; FunSel=4'b1111; #250; // csr
    end
    
    always begin
        
        clk <= ~clk; #125;
//        clk <= ~clk; #125;
    end
    
endmodule