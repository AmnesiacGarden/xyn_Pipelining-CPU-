module Mux2 #(parameter width = 32)(
input [width-1:0]   a,
input [width-1:0]   b,
input               sel,
output [width-1:0]  c
);

assign c = sel ? b : a ;

endmodule