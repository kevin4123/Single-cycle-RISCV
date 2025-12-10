// 只充当一个wrapper
module top (
    input  wire [31:0] Addr,
    output wire [31:0] Instr
);

Instr_m u_Instr_m(
	.Addr  	( Addr   ),
	.Instr 	( Instr  )
);


endmodule
