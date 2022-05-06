module shift_module(
    input wire [7:0] I,
    input wire [3:0] FunSel,
    output reg [7:0] Q,
    output reg Cout
    );
    
    always @(*)
        begin
            case(FunSel)
            4'b1010: begin
            Cout <= I[7];
            Q <= I << 1;
            end
                     
            4'b1011: begin
            Cout <= I[0];
            Q <= I >> 1;
            end
                     
            4'b1100: begin
            Q <= I <<< 1;
            end
            
            4'b1101: begin
            Q <= I >>> 1;
            end
            
            4'b1110: begin
            Q <= {I[6:0], I[7]};
            Cout <= I[7];
            end
            
            4'b1111: begin
            Q <= {I[0], I[7:1]};
            Cout <= I[0];
            end
            
            endcase
        end
endmodule
