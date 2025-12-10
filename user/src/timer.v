module timer (
    input wire clk,
    input wire rstn,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] din,

    output wire [31:0] dout
);

    reg [63:0] t;

    always @(posedge clk) begin
        if (!rstn) begin
            t <= 0;
        end
        else begin
            t <= t + 1;
        end
    end

    wire sel = (addr == 32'hFFFF_0000) || (addr == 32'hFFFF_0004); 

    assign dout = ~sel ? 32'hzzzz_zzzz : 
                    (addr == 32'hFFFF_0000) ? t[31:0] : t[63:32];


endmodule
