module csr_op(
    input [2:0] funct3,
    input [31:0] a,
    input [31:0] r1,
    input [4:0] imm,

    output reg [31:0] c
);
    wire [31:0] b;

    assign b = funct3[2] ? {27'd0,imm} : r1;

    always @(*) begin
        case (funct3[1:0])
            1: c = b;           // csrw
            2: c = a | b;       // csrrs
            3: c = a & ~b;      // csrrc
            default: c = a;
        endcase
    end






endmodule
