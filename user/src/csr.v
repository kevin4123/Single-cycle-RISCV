module csr(
    input clk,
    input rstn,
    input we,
    input [11:0] addr,
    input [31:0] din,
    
    output reg [31:0] dout,

    input exception,
    input [31:0] cause,
    input [31:0] pc,

    output trap,
    output [31:0] utvec,

    input uret,
    output [31:0] uepc,

    input interrupt,
    input [31:0] icause,
    input [31:0] pc4
);
    reg [31:0] ustatus,utvec,ucause,utval,uepc;

    always @(posedge clk) begin
        if(!rstn)
        begin
            ustatus <= 0;
            utvec <= 0;
            ucause <= 0;
            utval <= 0;
            uepc <= 0;
        end
        else if(exception)
        begin
            ustatus <= {ustatus[31:4],ustatus[0],ustatus[2:1],1'b0};
            ucause <= cause;
            uepc <= pc;
        end
        else if(interrupt)
        begin
            ustatus <= {ustatus[31:4],ustatus[0],ustatus[2:1],1'b0};
            ucause <= icause;
            uepc <= pc4;
        end
        else if(uret)
        begin
            ustatus <= {ustatus[31:1],ustatus[3]};
        end
        else if(we)
        begin
            case (addr)
                0: ustatus <= din;
                5: utvec <= din;
                65: uepc <= din;
                66: ucause <= din;
                67: utval <= din;
            endcase
        end
    end

    always @(*)
    begin
        if(~we)
            dout <= 32'hzzzz_zzzz;
        else
        begin
            case (addr)
                0: dout <= ustatus;
                5: dout <= utvec;
                65: dout <= uepc;
                66: dout <= ucause;
                67: dout <= utval;
                default: dout <= 0;
            endcase
        end
    end


    assign trap = exception || interrupt;

endmodule

