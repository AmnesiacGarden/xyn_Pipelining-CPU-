module Signex(
input  [15:0] imm,
output [31:0] eximm
);

assign eximm = {16'h0,imm} ;
    
endmodule
