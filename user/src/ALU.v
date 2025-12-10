module ALU (
    input [31:0] a,             // 操作数A
    input [31:0] b,             // 操作数B
    input [3:0] ALU_op,         // ALU控制信号
    output reg [31:0] c         // ALU结果
);

    always @(*) begin
        case (ALU_op) 
            4'b0000: c = a + b;     // add
            4'b1000: c = a - b;     // sub
            4'b0010: c = {31'b0, $signed(a) < $signed(b)};      // slt
            4'b0011: c = {31'b0, a < b};     // sltu
            4'b0100: c = a ^ b;     // xor
            4'b0110: c = a | b;     // or
            4'b0111: c = a & b;     // and
            4'b0001: c = a << b[4:0];   // sll
            4'b0101: c = a >> b[4:0];   // srl
            4'b1101: c = $signed(a) >>> b[4:0];   // sra
            default: c = 32'b0;
        endcase
    end


endmodule

