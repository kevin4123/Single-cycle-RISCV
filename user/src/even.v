module even(
    input wire [31:0] din,
    
    output wire [31:0] fout
);
    
    assign fout = {din[31:1], din[0]};


endmodule
