/* @wavedrom 
{
    signal : [
        { name: "clk",  wave: "P....................", phase: 0, period: 1},
        { name: "rstn",  wave: "0.1..................", phase: 0, period: 1},
    ]
}
*/
`timescale 1ns/1ps

module tb_top;

//------------------------------------------
// 信号声明
//------------------------------------------
    reg        	    clk;
    reg [31:0]      Addr;
    reg [31:0]      Data_in;
    reg             Wr_en;

    wire [31:0] 	Data_out;
//------------------------------------------
// 实例化被测试模块
//------------------------------------------
top u_top(
	.clk      	( clk       ),
	.Addr     	( Addr      ),
	.Data_in  	( Data_in   ),
	.Wr_en    	( Wr_en     ),

	.Data_out 	( Data_out  )
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

//------------------------------------------
// Test sequence
//------------------------------------------

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);

        #5;     // Wait for a few time units
        Addr = 32'h1001_0000;   
        Data_in = 32'hDEAD_BEEF;   
        Wr_en = 1;
        #20;
        Addr = 32'h1001_0004;   
        Data_in = 32'h1234_5678;   
        Wr_en = 1;  
        #20;
        Addr = 32'h1001_0000;   
        Data_in = 32'h0000_0000;   
        Wr_en = 0;    
        #20;
        Addr = 32'h1001_0004;   
        Data_in = 32'h0000_0000;   
        Wr_en = 0; 
        #20;
        Addr = 32'h0000_0000;   
        Data_in = 32'h0000_0000;   
        Wr_en = 0;  

        #100;
        $finish;
    end
    
endmodule


