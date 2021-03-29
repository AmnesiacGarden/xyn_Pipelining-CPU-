`include "Defines.v"

module pc_reg(
input                 clk,
input                 rst,
input                 pcsrc,
input [`Databus]      brpc,

output [`Databus] addr
);

reg [`Regwidth] pc;

assign addr = pc ;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        pc <= -4 ;
    end else begin
        if(pcsrc) begin
			pc <= brpc ;
        end else begin
            pc <= pc + 32'd4 ;
        end
    end
end
endmodule
