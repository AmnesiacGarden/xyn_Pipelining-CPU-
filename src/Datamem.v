`include "Defines.v"

module Datamem(
input 			   clk,
input 			   wen,
input			   ren,
input [`Databus]   addr,
input [`Databus]   data_i,

output [`Databus]  data_o
);

reg [`Regwidth] memory [0:127];

always @ (posedge clk) begin
	if(wen) begin
	      memory[addr[18:2]] <= data_i;

	end
end

assign data_o = ren ? `ZeroWord : memory[addr] ; 	

endmodule