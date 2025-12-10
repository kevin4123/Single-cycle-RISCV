
module Registers(
    input  wire        clk,
    input  wire        we,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2, 
    input  wire [4:0]  rd,
    input  wire [31:0] din,

    output wire [31:0] r1,
    output wire [31:0] r2
);
    reg [31:0] regfiles [1:31];


    // Write
    always @(posedge clk) begin
        if (we && rd != 0) begin
            regfiles[rd] <= din;
        end
    end

    // Read
    assign r1 = rs1 == 5'd0 ? 32'd0 : regfiles[rs1];
    assign r2 = rs2 == 5'd0 ? 32'd0 : regfiles[rs2];

endmodule


