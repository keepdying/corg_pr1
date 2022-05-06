module alu_module(
    input wire [3:0] FunSel,
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    output reg [7:0] OutALU,
    output wire [3:0] OutFLAG
    );
    
    wire [7:0] shift_temp;
    wire neg, zero, carry, overflow, shift_carry;
    shift_module shifter(.I(A), .FunSel(FunSel), .Q(shift_temp), .Cout(shift_carry));
    
    wire [8:0] sum;
    wire [8:0] sub;
    assign carry = (FunSel == 4'b0101) ? Cin : 0;
    assign sum = A + B + carry;
    assign sub = A - B;
    
    always @(*)
        begin
            case(FunSel)
            4'b0000: OutALU = A; 
            4'b0001: OutALU = B;
            4'b0010: OutALU = ~A;
            4'b0011: OutALU = ~B;
            4'b0100: OutALU = sum[7:0]; // A + B
            4'b0101: OutALU = sum[7:0]; // A + B + Cin
            4'b0110: OutALU = sub[7:0]; // A - B
            4'b0111: OutALU = A & B; // bitwise and
            4'b1000: OutALU = A | B; // bitwise or
            4'b1001: OutALU = A ^ B; // bitwise xor
            default: OutALU = shift_temp;
            endcase
        end

    assign zero     = (OutALU == 7'b0);
    assign carry    = ((FunSel == 4'b010?) & sum[8]) | ((FunSel == 4'b0110) & sub[8]) | ((FunSel == 4'b1?1?) & shift_carry);
    assign neg      = OutALU[7];
//    assign overflow = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
    assign OutFLAG = {zero, carry, neg, overflow};
endmodule
