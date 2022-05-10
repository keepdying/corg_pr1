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
    
    wire [15:0] IROut;
    wire [7:0]  ALUOut, AOut, BOut, ARF_COut, Address, MemoryOut;
    reg [7:0] MuxAOut, MuxBOut, MuxCOut;
    wire [3:0]  ALUOutFlag, OutFlagReg;
    
    Memory _Memory(.address(Address),
                   .data(ALUOut),
                   .wr(Mem_WR),
                   .cs(Mem_CS),
                   .clock(Clock),
                   .o(MemoryOut)
                    );
    
    alu_module _alu_module(.FunSel(ALU_FunSel),
                           .A(MuxCOut),
                           .B(BOut),
                           .Cin(OutFlagReg[2]),
                           .OutALU(ALUOut),
                           .OutFLAG(ALUOutFlag)
    );
    
    reg_module _reg_module(.Clock(Clock),
                           .I(MuxAOut),
                           .FunSel(RF_FunSel),
                           .RegSel(RF_RegSel),
                           .OutASel(RF_OutASel),
                           .OutBSel(RF_OutBSel),
                           .OutA(AOut),
                           .OutB(BOut)
                            );
    
    arf_module _arf_module(.Clock(Clock),
                           .I(MuxBOut),
                           .FunSel(ARF_FunSel),
                           .RegSel(ARF_RegSel),
                           .OutCSel(ARF_OutCSel),
                           .OutDSel(ARF_OutDSel),
                           .OutC(ARF_COut),
                           .OutD(Address)
                            );
    
    reg_ir _reg_ir(.Clock(Clock),
                   .Enable(IR_Enable),
                   .FunSel(IR_Funsel),
                   .lh(IR_LH),
                   .I(MemoryOut),
                   .IRout(IROut));
                   
    reg_flag _reg_flag(.Clock(Clock),
                       .InFLAG(ALUOutFlag),
                       .OutFLAG(OutFlagReg));
                       
    always @(*)
        begin
            case(MuxASel)
            2'b00: MuxAOut <= IROut[7:0];
            2'b01: MuxAOut <= MemoryOut;
            2'b10: MuxAOut <= ARF_COut;
            2'b11: MuxAOut <= ALUOut;
            endcase
        end
    
    always @(*)
        begin
            case(MuxBSel)
            2'b01: MuxBOut <= IROut[7:0];
            2'b10: MuxBOut <= MemoryOut;
            2'b11: MuxBOut <= ALUOut;
            endcase
        end
            
    always @(*)
        begin
            if(MuxCSel)
                MuxCOut <= AOut;
            else
                MuxCOut <= ARF_COut;
        end
        
endmodule
