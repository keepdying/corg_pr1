`timescale 1ns / 1ps

module ALUSystem(
    input wire[1:0] RF_OutASel,
    input wire[1:0] RF_OutBSel, 
    input wire[1:0] RF_FunSel,
    input wire[3:0] RF_RegSel,
    input wire[3:0] ALU_FunSel,
    input wire[1:0] ARF_OutCSel, 
    input wire[1:0] ARF_OutDSel, 
    input wire[1:0] ARF_FunSel,
    input wire[2:0] ARF_RegSel,
    input wire      IR_LH,
    input wire      IR_Enable,
    input wire[1:0] IR_Funsel,
    input wire      Mem_WR,
    input wire      Mem_CS,
    input wire[1:0] MuxASel,
    input wire[1:0] MuxBSel,
    input wire      MuxCSel,
    input wire      Clock
    );
    
    wire [15:0] IRout;
    wire [7:0]  OutALU, OutA, OutB, OutC, OutD, MemOut;
    reg [7:0] OutMuxA, OutMuxB, OutMuxC;
    wire [3:0]  OutFlag, OutFlagReg;
    
    Memory _Memory(.address(OutD),
                   .data(OutALU),
                   .wr(Mem_WR),
                   .cs(Mem_CS),
                   .clock(Clock),
                   .o(MemOut)
                    );
    
    alu_module _alu_module(.FunSel(ALU_FunSel),
                           .A(OutMuxC),
                           .B(OutB),
                           .Cin(OutFlagReg[2]),
                           .OutALU(OutALU),
                           .OutFLAG(OutFlag)
    );
    
    reg_module _reg_module(.Clock(Clock),
                           .I(OutMuxA),
                           .FunSel(RF_FunSel),
                           .RegSel(RF_RegSel),
                           .OutASel(RF_OutASel),
                           .OutBSel(RF_OutBSel),
                           .OutA(OutA),
                           .OutB(OutB)
                            );
    
    arf_module _arf_module(.Clock(Clock),
                           .I(OutMuxB),
                           .FunSel(ARF_FunSel),
                           .RegSel(ARF_RegSel),
                           .OutCSel(ARF_OutCSel),
                           .OutDSel(ARF_OutDSel),
                           .OutC(OutC),
                           .OutD(OutD)
                            );
    
    reg_ir _reg_ir(.Clock(Clock),
                   .Enable(IR_Enable),
                   .FunSel(IR_Funsel),
                   .lh(IR_LH),
                   .I(MemOut),
                   .IRout(IRout));
                   
    reg_flag _reg_flag(.Clock(Clock),
                       .InFLAG(OutFlag),
                       .OutFLAG(OutFlagReg));
                       
    always @(*)
        begin
            case(MuxASel)
            2'b00: OutMuxA <= IRout[7:0];
            2'b01: OutMuxA <= MemOut;
            2'b10: OutMuxA <= OutC;
            2'b11: OutMuxA <= OutALU;
            endcase
        end
    
    always @(*)
        begin
            case(MuxBSel)
            2'b01: OutMuxB <= IRout[7:0];
            2'b10: OutMuxB <= MemOut;
            2'b11: OutMuxB <= OutALU;
            endcase
        end
            
    always @(*)
        begin
            if(MuxCSel)
                OutMuxC <= OutA;
            else
                OutMuxC <= OutC;
        end
        
endmodule
