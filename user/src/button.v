module button(
    input wire clk,
    input wire rstn,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] din,

    output     [31:0] dout,

    input wire b0,
    input wire b1,
    input wire b2,
    input wire b3,
    input wire b4,
    input wire b5,
    input wire b6,
    input wire b7 
);
    wire sel = addr == 32'hFFFF_0020;

    // assign dout = {24'b0, b7, b6, b5, b4, b3, b2, b1, b0};

    assign dout = sel ? {24'b0, b7, b6, b5, b4, b3, b2, b1, b0} : 32'hzzzz_zzzz;


endmodule

