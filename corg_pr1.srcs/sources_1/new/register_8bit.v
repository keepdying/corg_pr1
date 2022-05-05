module reg_8bit(
    input [7:0] I,
    input Clock,
    input E,
    input [1:0] FunSel,
    output reg[7:0] Q
    );

    always @(posedge Clock)
    begin
        if(E)
            case (FunSel)
            2'b00: Q <= Q - 8'd1;
            2'b01: Q <= Q + 8'd1;
            2'b10: Q <= I;
            2'b11: Q <= 0;
            endcase
        else
        Q <= Q;
    end
endmodule
