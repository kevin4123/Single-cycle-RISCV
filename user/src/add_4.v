module add_4(
    input wire [31:0] in_pc,
    
    output wire [31:0] out_pc
);
    assign out_pc = in_pc + 32'd4;
    
endmodule //add_4
