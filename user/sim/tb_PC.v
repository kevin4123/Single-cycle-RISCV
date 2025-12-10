/* @wavedrom 
{
    signal : [
        { name: "clk",  wave: "P....................", phase: 0, period: 1},
        { name: "rstn",  wave: "0.1..................", phase: 0, period: 1},
        { name: "next_pc",  wave: "222222222222222222", phase: 0, period: 1, data: ["n", "n+4", "n+8", "n+12", "n+16", "n+20", "n+24", "n+28", "n+32", "n+36"]},
        { name: "pc",  wave: "222222222222222222", phase: 0, period: 1, data: ["default","n", "n+4", "n+8", "n+12", "n+16", "n+20", "n+24", "n+28", "n+32", "n+36"]},
    ]
}
*/
`timescale 1ns/1ps

module tb_top;

//------------------------------------------
// 信号声明
//------------------------------------------
    reg         clk;
    reg         rstn;
    reg [31:0] next_pc;

    wire [31:0] 	pc;

//------------------------------------------
// 实例化被测试模块
//------------------------------------------
top u_top(
	.clk     	( clk      ),
	.rstn    	( rstn     ),
	.next_pc 	( next_pc  ),

	.pc      	( pc       )
);
//------------------------------------------
// 产生时钟：20ns, 50MHz
//------------------------------------------
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
//------------------------------------------
// 复位
//------------------------------------------
    initial begin
        rstn = 0;
        #45;
        rstn = 1;
    end
//------------------------------------------
// Test sequence
//------------------------------------------

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);

        #5;     // Wait for a few time units  

        next_pc = 32'h0000_0000;
        #20;
        next_pc = 32'h0000_0004;
        #20;
        next_pc = 32'h0000_0008;
        #20;
        next_pc = 32'h0000_000C;
        #20;
        next_pc = 32'h0000_0010;
        #20;
        next_pc = 32'h0000_0014;
        #20;
        next_pc = 32'h0000_0018;
        
        #100;
        $finish;
    end
    
endmodule


