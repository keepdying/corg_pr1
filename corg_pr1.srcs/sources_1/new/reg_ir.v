module reg_ir(
    input [7:0] I,
    input Clock,
    input Enable,
    input [1:0] FunSel,
    input lh,
    output [15:0] IRout
    );
    
    reg[15:0] IR;
    
    reg_16bit ir(.E(Enable) , .Clock(Clock), .FunSel(FunSel), .I(IR), .Q(IRout));
    
    always @(*)
    begin
        if(lh)
            IR[15:8] <= I;
        else
            IR[7:0] <= I;
    end
endmodule

