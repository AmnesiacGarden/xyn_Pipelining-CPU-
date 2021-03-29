`include "Defines.v"

module Alu(
input wire[`sel]      alusel,
input wire[`Databus]  reg1,
input wire[`Databus]  reg2,

output reg[`Databus]  result,
output                zero
	
);

wire[`Databus] reg2_mux;
wire[`Databus] result_sum;
wire reg1_lt_reg2;

assign reg2_mux = ((alusel == `sub_s) ||  (alusel == `slt_s) ) ? (~reg2)+1 : reg2;
assign result_sum = reg1 + reg2_mux;
								
assign reg1_lt_reg2 = ((alusel == `slt_s)) ?
 						((reg1[31] && !reg2[31]) || (!reg1[31] && !reg2[31] && result_sum[31])|| (reg1[31] && reg2[31] && result_sum[31]))
 		                :	(reg1 < reg2);

assign zero = ((alusel == `beq_s) && (result_sum == `ZeroWord)) || (alusel == `j_s) ;

always @ (*) begin
	case (alusel)
        `add_s,`lw_s,`sw_s: begin
				result <= result_sum ;
		end
		`sub_s: begin
				result <= reg1 - reg2 ;
		end
		`or_s: begin
				result <= reg1 | reg2 ;
		end
		`and_s: begin
				result <= reg1 & reg2 ;
		end
        `slt_s: begin
				result <= reg1_lt_reg2 ;
		end
		default: begin
				result <= `ZeroWord;
		end
	endcase
end

endmodule