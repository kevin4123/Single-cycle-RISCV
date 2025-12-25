module Decode(
    input  wire [31:0]   instr,

    output wire [4:0]    rs1,
    output wire [4:0]    rs2,
    output wire [4:0]    rd,

    output wire [31:0]   Imm,
    output wire          wreg,
    output wire [1:0]    wregSrc,
    output wire          pcSrc,
    output wire          jalr,
    output wire          btype,
    output wire [2:0]    funct3,
    output wire [3:0]    ALU_op,
    output wire          aluSrcB,
    output wire          store,
    output wire          load,
    output wire          csr,
    output wire          exception,
    output wire [31:0]   cause,

    output uret
    
);
    wire lui,auipc,jal,itype,rtype;

// instruction fields
    wire [6:0] opcode;
    wire [6:0] funct7;
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];

// register addresses
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd  = instr[11:7];
    
// Immediate values
    wire [31:0] u_imm;
    wire [31:0] i_imm;
    wire [31:0] s_imm;
    wire [31:0] b_imm;
    wire [31:0] j_imm;
    assign u_imm = {instr[31:12], 12'b0};
    assign i_imm = {{20{instr[31]}}, instr[31:20]};
    assign s_imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign b_imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign j_imm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

    assign Imm = (lui || auipc) ? u_imm : 
                    jal ? j_imm : 
                    (jalr || itype || load) ? i_imm : 
                    store ? s_imm :
                    btype ? b_imm : 0; 

// instruction identification
    assign lui = opcode == 7'b0110111 ? 1'b1 : 1'b0;
    assign auipc = opcode == 7'b0010111 ? 1'b1 : 1'b0;
    assign jal = opcode == 7'b1101111 ? 1'b1 : 1'b0;
    assign jalr = opcode == 7'b1100111 ? 1'b1 : 1'b0;
    assign btype = opcode == 7'b1100011 ? 1'b1 : 1'b0;
    assign itype = opcode == 7'b0010011 ? 1'b1 : 1'b0;
    assign rtype = opcode == 7'b0110011 ? 1'b1 : 1'b0; 
    assign store = opcode == 7'b0100011 ? 1'b1 : 1'b0; 
    assign load = opcode == 7'b0000011 ? 1'b1 : 1'b0;

    wire system,ebreak,ecall;

    assign system = opcode == 7'b1110011 ? 1'b1 : 1'b0;
    assign csr = system && (funct3 != 3'b000);
    assign ecall = system && (funct3 == 3'b000) && (rs2 == 0);
    assign ebreak = system && (funct3 == 3'b000) && (rs2 == 1);
    assign uret = system && (funct3 == 3'b000) && (rs2 == 2);
    
// control signals
    assign wreg = (lui || auipc || jal || jalr || itype || rtype || load || csr) ? 1 : 0;
    assign wregSrc = lui ? 0 :
                        auipc ? 1 :
                        (jal || jalr) ? 2 : 
                        (itype || rtype || csr) ? 3 : 3; 
    assign pcSrc = (jal || jalr) ? 1 : 0;

    assign ALU_op = (rtype || (itype && funct3 == 3'b101)) ? {funct7[5], funct3} : 
                    itype ? {1'b0, funct3} : 0 ;
    assign aluSrcB = (itype || load || store) ? 1 : 0;

    wire illegal_inst;
    assign illegal_inst = ~(lui || auipc || jal || jalr || btype || load || store || itype || rtype || system);

    assign exception = illegal_inst || ecall || ebreak ;

    assign cause = illegal_inst ? 2 : 
                    ebreak ? 3 : 
                    ecall ? 8 : 0; 

endmodule //Decode
