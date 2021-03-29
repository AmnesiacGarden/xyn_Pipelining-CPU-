`include "Defines.v"

module Register (
input             clk,
input             rst,
input             wen,
input [`Genbus]   waddr,
input [`Databus]  wdata,
input [`Genbus]   raddr_a,
input [`Genbus]   raddr_b,

output [`Databus] rdata_a,
output [`Databus] rdata_b
);

reg [`Regwidth] regs [0:31];
  
assign rdata_a = (raddr_a != 0) ? ((wen & raddr_a == waddr) ? wdata : regs[raddr_a]) : 32'd1; 
assign rdata_b = (raddr_b != 0) ? ((wen & raddr_b == waddr) ? wdata : regs[raddr_b]) : 32'd1; 

integer i;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        for(i = 0; i < 32; i = i + 1)
            regs[i] <= 32'd0;
    end else if(wen) begin
            regs[waddr] <= wdata;
    end
end

endmodule