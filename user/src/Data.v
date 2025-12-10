module Data(
    input  wire        clk,
    input  wire        we,
    input  wire [2:0]  funct3,
    input  wire [31:0] addr,
    input  wire [31:0] din,

    output wire  [31:0] dout
);
    reg [31:0]  ram [0:16*1024-1];    // 16K words data memory
    wire sel;

    assign sel = (addr >= 32'h1001_0000) && (addr <= 32'h1001_FFFF); 
    assign ram_addr = (addr - 32'h1001_0000) >> 2;

    wire [31:0] rdata;
    assign rdata = ram[ram_addr];

    reg [31:0] load_data;
    wire [31:0] load_byte;
    wire [31:0] load_half;

    assign load_half = addr[1] ? rdata[31:16] : rdata[15:0];
    assign load_byte = addr[0] ? load_half[15:8] : load_half[7:0];

    always @(*) begin
        case (funct3)
            3'b000: load_data = {{24{load_byte[7]}}, load_byte}; // lb
            3'b001: load_data = {{16{load_half[15]}}, load_half};// lh
            3'b010: load_data = rdata;  // lw
            3'b100: load_data = {{24{1'b0}}, load_byte}; // lbu
            3'b101: load_data = {{16{1'b0}}, load_half}; // lhu
            default: load_data = 0;
        endcase
    end
    assign dout = sel ? load_data : 32'hzzzz_zzzz;


    reg [31:0] wdata;  

    always @(*) begin
        case (funct3)
            3'b000: 
                begin
                    case (addr[1:0])
                        0: wdata = {rdata[31:8],din[7:0]};
                        1: wdata = {rdata[31:16],din[7:0],rdata[7:0]};
                        2: wdata = {rdata[31:24],din[7:0],rdata[15:0]};
                        3: wdata = {din[7:0],rdata[23:0]};
                        default: wdata = rdata;
                    endcase
                end
            3'b001: wdata = addr[1] ? {din[15:0],rdata[15:0]} : {rdata[31:16],din[15:0]};
            3'b010: wdata = din;
        endcase 
    end


    always @(posedge clk) begin
        if (we && sel) begin
            ram[ram_addr] <= wdata;
        end
    end

    initial begin
        $readmemh("C:\\Users\\kevin\\Desktop\\Single-cycle-RISCV\\user\\src\\data.hex", ram);
    end

endmodule

