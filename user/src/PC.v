module PC(
    input  wire        clk,
    input  wire        rstn,
    input  wire [31:0] next_pc,
    input  wire        trap,
    input  wire [31:0] utvec,

    output reg  [31:0] pc,

    input uret,
    input [31:0] epc
);
// pc
    always @(posedge clk) begin
        if (!rstn) 
        begin
            pc <= 32'h0040_0000;
        end 
        else if (trap) 
        begin
            pc <= utvec;
        end
        else if (uret)
        begin
            pc <= epc;
        end
        else 
        begin
            pc <= next_pc;
        end
    end




endmodule
