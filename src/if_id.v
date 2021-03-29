`include "Defines.v"

module if_id(
input        clk,
input        rst,
input [`Databus] if_pc,
input [`Databus] if_inst,

output reg [`Databus] id_pc,
output reg [`Databus] id_inst
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        id_pc <= `ZeroWord ;
        id_inst <= `ZeroWord ;
    end else begin
        id_pc <= if_pc ;
        id_inst <= if_inst ;
    end
end
    
endmodule