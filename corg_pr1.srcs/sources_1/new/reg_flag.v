module reg_flag(
    input wire [3:0] InFLAG,
    input wire clk,
    output reg [3:0] OutFLAG
    );
    
    always @(negedge clk)
        begin
            OutFLAG <= InFLAG;
        end

endmodule
