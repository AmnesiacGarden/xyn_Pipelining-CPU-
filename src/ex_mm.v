`include "Defines.v"

module ex_mm(
input                 clk,
input                 rst,
input [`Databus]      ex_pc,
input [`Databus]      ex_result,
input [`Databus]      ex_mmdata,
input [`Genbus]       ex_regdst,
input                 ex_zero,
input                 ex_memtoreg,
input                 ex_regwrite,
input                 ex_memread,
input                 ex_memwrite,
input                 ex_branch,

output reg [`Databus] mm_pc,
output reg [`Databus] mm_result,
output reg [`Databus] mm_mmdata,
output reg [`Genbus]  mm_regdst,
output reg            mm_zero,
output reg            mm_memtoreg,
output reg            mm_regwrite,
output reg            mm_memread,
output reg            mm_memwrite,
output reg            mm_branch
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        mm_pc       <= `ZeroWord ;
        mm_result   <= `ZeroWord ;
        mm_mmdata   <= `ZeroWord ;
        mm_regdst   <= 5'd0 ;
        mm_zero     <= `Disable ;
        mm_memtoreg <= `Disable ;
        mm_regwrite <= `Disable ;
        mm_memread  <= `Disable ;
        mm_memwrite <= `Disable ;
        mm_branch   <= `Disable ;
    end else begin
        mm_pc       <= ex_pc ;
        mm_result   <= ex_result ;
        mm_mmdata   <= ex_mmdata ;
        mm_regdst   <= ex_regdst ;
        mm_zero     <= ex_zero ;
        mm_memtoreg <= ex_memtoreg ;
        mm_regwrite <= ex_regwrite ;
        mm_memread  <= ex_memread ;
        mm_memwrite <= ex_memwrite ;
        mm_branch   <= ex_branch ;
    end
end
    
endmodule