module branch(
    input  wire [2:0]  funct3,
    input  wire [31:0] r1,
    input  wire [31:0] r2,

    output reg         branch
);

    always @(*) begin
        case (funct3)
            3'b000: branch = r1 == r2;
            3'b001: branch = r1 != r2;
            3'b100: branch = $signed(r1) < $signed(r2);
            3'b101: branch = $signed(r1) >= $signed(r2);
            3'b110: branch = r1 < r2;
            3'b111: branch = r1 >= r2;
            default: branch = 0;
        endcase
    end

endmodule
