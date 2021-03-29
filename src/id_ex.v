`include "Defines.v"

module id_ex(
input                 clk,
input                 rst,
input [`Databus]      id_pc,
input [`Databus]      id_reg1,
input [`Databus]      id_reg2,
input [`Databus]      id_signex,
input [`Genbus]       id_regrt,
input [`Genbus]       id_regrd,
input                 id_seldst,
input                 id_alusrc,
input                 id_memtoreg,
input                 id_regwrite,
input                 id_memread,
input                 id_memwrite,
input                 id_branch,
input [`aluop]        id_aluop,

output reg [`Databus] ex_pc,
output reg [`Databus] ex_reg1,
output reg [`Databus] ex_reg2,
output reg [`Databus] ex_signex,
output reg [`Genbus]  ex_regrt,
output reg [`Genbus]  ex_regrd,
output reg            ex_seldst,
output reg            ex_alusrc,
output reg            ex_memtoreg,
output reg            ex_regwrite,
output reg            ex_memread,
output reg            ex_memwrite,
output reg            ex_branch,
output reg [`aluop]   ex_aluop
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        ex_pc       <= `ZeroWord ;
        ex_reg1     <= `ZeroWord ;
        ex_reg2     <= `ZeroWord ;
        ex_signex   <= `ZeroWord ;
        ex_regrt    <= 5'd0 ;
        ex_regrd    <= 5'd0 ;
        ex_seldst   <= `Disable ;
        ex_alusrc   <= `Disable ;
        ex_memtoreg <= `Disable ;
        ex_regwrite <= `Disable ;
        ex_memread  <= `Disable ;
        ex_memwrite <= `Disable ;
        ex_branch   <= `Disable ;
        ex_aluop    <= 4'd0 ;
    end else begin
        ex_pc       <= id_pc ;
        ex_reg1     <= id_reg1 ;
        ex_reg2     <= id_reg2 ;
        ex_signex   <= id_signex ;
        ex_regrt    <= id_regrt ;
        ex_regrd    <= id_regrd ;
        ex_seldst   <= id_seldst ;
        ex_alusrc   <= id_alusrc ;
        ex_memtoreg <= id_memtoreg ;
        ex_regwrite <= id_regwrite ;
        ex_memread  <= id_memread ;
        ex_memwrite <= id_memwrite ;
        ex_branch   <= id_branch ;
        ex_aluop    <= id_aluop ;
    end
end
    
endmodule