module code(
    input  wire [31:0] addr,
    output reg [31:0] data
);
    reg [31:0] rom [0:1023]; // 1K instructions
    wire [9:0] rom_addr;
    assign rom_addr = (addr - 32'h0040_0000) >> 2;

// Instruction Memory
    initial begin
        $readmemh("C:\\Users\\kevin\\Desktop\\Single-cycle-RISCV\\user\\src\\instr_m.mem", rom);
    end

// Read logic
    always @(*)
    begin
        if (addr >= 32'h0040_0000 && addr <= 32'h0040_0FFF)
            data = rom[rom_addr];
        else
            data = 32'h0000_0000;
    end    

endmodule
