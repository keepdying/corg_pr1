module alu_module_v2(
    input wire [3:0] FunSel,
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    output reg [7:0] OutALU,
    output wire [3:0] OutFLAG
    );
    
    wire [8:0] sum_temp, sub_temp;
    wire sum_carry;
    reg neg, zero, carry, overflow;
    
   
    assign OutFLAG = {zero, carry, neg, overflow};
    assign sum_carry = (FunSel == 4'b0101) ? Cin : 0;
    assign sum_temp = {1'b0,A} + {1'b0,B} + {8'b0, sum_carry};
    assign sub_temp = {1'b0,A} - {1'b0,B};
    
    always @(*)
        begin
            case(FunSel)
            4'b0000: begin 
                OutALU = A;
                 
                zero = (OutALU == 8'b0); 
                neg = OutALU[7];  
            end // A
            
            4'b0001: begin 
                OutALU = B;
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7]; 
            end // B
            
            4'b0010: begin 
                OutALU = ~A; 
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7];
            end // NOT A
            
            4'b0011: begin 
                OutALU = ~B; 
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7]; 
            end // NOT B
            
            4'b0100: begin 
                OutALU = sum_temp[7:0];
                 
                zero = (OutALU == 8'b0); 
                carry = sum_temp[8];
                neg = OutALU[7]; 
                overflow = sum_temp[7]; 
            end // A + B
            
            4'b0101: begin 
                OutALU = sum_temp[7:0];
                
                zero = (OutALU == 8'b0);
                carry = sum_temp[8];
                neg = OutALU[7]; 
                overflow = sum_temp[7]; 
            end // A + B + Cin
            
            4'b0110: begin 
                OutALU = sub_temp[7:0];
                
                zero = (OutALU == 8'b0);
                carry = sub_temp[8]; 
                neg = OutALU[7]; 
                overflow = sub_temp[7]; 
            end // A - B
            
            4'b0111: begin 
                OutALU = A & B; 
                 
                zero = (OutALU == 8'b0); 
                neg = OutALU[7]; 
            end // A AND B
            
            4'b1000: begin 
                OutALU = A | B; 
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7]; 
            end // A OR B
            
            4'b1001: begin 
                OutALU = A ^ B; 
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7];
            end // A XOR B
            
            4'b1010:begin 
                OutALU = A << 1;
                
                zero = (OutALU == 8'b0);
                carry = A[7];  
                neg = OutALU[7]; 

            end // LSL A
            
            4'b1011: begin 
                OutALU = A >> 1;
                
                zero = (OutALU == 8'b0);
                carry = A[0];  
                neg = OutALU[7];
            end // LSR A
            
            4'b1100: begin 
                OutALU = A <<< 1; 
                
                zero = (OutALU == 8'b0); 
                neg = OutALU[7]; 
                overflow = (A[7] ^ A[6]); 
            end // ASL A
            
            4'b1101: begin 
                OutALU = A >>> 1;
                
                zero = (OutALU == 8'b0); 
            end // ASR A
            
            4'b1110: begin 
                OutALU = {A[6:0], Cin}; 
                
                zero = (OutALU == 8'b0);
                carry = A[7];
                neg = OutALU[7]; 
                overflow = (A[7] ^ A[6]); 
                
            end // CSL A
                
            4'b1111: begin 
                OutALU = {Cin, A[7:1]}; 
                
                zero = (OutALU == 8'b0);
                carry = A[0];
                neg = OutALU[7]; 
                overflow = (A[7] ^ Cin); 

            end // CSR A
            endcase
        end
endmodule
