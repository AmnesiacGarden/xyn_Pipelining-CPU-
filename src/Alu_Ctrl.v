`include "Defines.v"

module Alu_Ctrl(
input [`aluop]     aluop,
input [`fc]        func,

output reg [`sel]  alusel
);

always @ (*) begin
	casez({aluop,func})
            10'b0000_100000: alusel = `add_s ;
            10'b0000_100010: alusel = `sub_s ;
            10'b0000_101010: alusel = `slt_s ;
            10'b0000_100100: alusel = `and_s ;
            10'b0000_100101: alusel = `or_s ;
            10'b0011_??????: alusel = `lw_s ;
            10'b1011_??????: alusel = `sw_s ;
            10'b0100_??????: alusel = `beq_s ;
            10'b0010_??????: alusel = `j_s ;
            default      : alusel = 4'd0 ;
    endcase

end	

endmodule