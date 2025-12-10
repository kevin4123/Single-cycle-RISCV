module term(
    input wire clk,
    input wire rstn,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] din,

    output reg [31:0] dout,

    // keyboard
    input wire [15:0] key_data,
    input wire key_av,

    output wire key_en,

    // terminal
    output wire [7:0] term_data,
    output wire term_en
);

    wire sel;
    assign sel = addr == 32'hFFFF_0030;

    // terminal
    assign term_en = sel && we;
    assign term_data = din[7:0];

    // keyboard
    assign key_en = sel && !we;
    always @(posedge clk) begin
        if (key_en) 
            dout <= {24'b0, key_data[7:0]};
        else
            dout <= 32'hzzzz_zzzz;
    end


endmodule
