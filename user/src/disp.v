module disp(
    input wire clk,
    input wire rstn,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] din,

    output wire [14:0] vaddr,
    output wire [7:0] vdata,
    output wire vwe
);

    wire sel = addr >= 32'hffff8000 && addr <= 32'hffffffff;   

    assign vaddr = addr[15:0];

    assign vdata = din[8:0];

    assign vwe = we && sel;


endmodule
