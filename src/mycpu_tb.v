`timescale 1ns/1ns

`include "Defines.v"

module mycpu_tb();
reg clk = 0 ;
reg rst = 1 ;

mycpu mycpu(
	.clk(clk),
	.rst(rst)	
);

    initial
    forever #10 clk = ~clk;

    initial begin
    #20 rst= `Disable;
    #400 $stop;
  end

endmodule