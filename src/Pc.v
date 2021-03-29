`include "Defines.v"

module Pc(
input                 clk,
input                 rst,
input [`Databus]      pc,

output reg [`Databus] addr
);

always @(posedge clk) begin
    addr <= pc ;
end
    
endmodule
