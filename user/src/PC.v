module PC(
    input  wire        clk,
    input  wire        rstn,
    input  wire [31:0] next_pc,

    output reg  [31:0] pc
);
// pc
    always @(posedge clk) begin
        if (!rstn) begin
            pc <= 32'h0040_0000;
        end else begin
            pc <= next_pc;
        end
    end

endmodule
