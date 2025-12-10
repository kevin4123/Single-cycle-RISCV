module led(
    input wire clk,
    input wire rstn,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] din,

    output reg  [7:0] led 
);

    wire sel;

    assign sel = addr == 32'hFFFF_0010;

    always @(posedge clk) begin
        if (!rstn) begin
            led <= 0;
        end
        else if (we && sel) begin
            led <= din[7:0];
        end
    end

endmodule
