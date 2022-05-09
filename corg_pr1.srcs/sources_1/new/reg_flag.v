module reg_flag(
    input wire [3:0] InFLAG,
    input wire Clock,
    output reg [3:0] OutFLAG
    );
    
    always @(negedge Clock)
        begin
            OutFLAG <= InFLAG;
        end

endmodule
