`include "Defines.v"

module mm_wb(
input                 clk,
input                 rst,
input [`Databus]      mm_mmdata,
input [`Databus]      mm_result,
input [`Genbus]       mm_regdst,
input                 mm_memtoreg,
input                 mm_regwrite,

output reg [`Databus] wb_mmdata,
output reg [`Databus] wb_result,
output reg [`Genbus]  wb_regdst,
output reg            wb_memtoreg,
output reg            wb_regwrite
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        wb_mmdata   <= `ZeroWord ;
        wb_result   <= `ZeroWord ;
        wb_regdst   <= 5'd0 ;
        wb_memtoreg <= `Disable ;
        wb_regwrite <= `Disable ;
    end else begin
        wb_mmdata   <= mm_mmdata ;
        wb_result   <= mm_result ;
        wb_regdst   <= mm_regdst ;
        wb_memtoreg <= mm_memtoreg ;
        wb_regwrite <= mm_regwrite ;
    end
end
    
endmodule