`include "Defines.v"

module Ctrl(
input [`opcode]    op,

output reg         seldst,
output reg         alusrc,
output reg         memtoreg,
output reg         regwrite,
output reg         memread,
output reg         memwrite,
output reg         branch,
output reg [`aluop]  aluop
);

always @ (*) begin
	casez(op)
            6'b000000: begin //R
                seldst = `Enable ;
                alusrc = `Disable ;
                memtoreg = `Disable ;
                regwrite = `Enable ;
                memread = `Disable ;
                memwrite = `Disable ;
                branch = `Disable ;
                aluop = 4'b0000 ;
            end
            6'b100011: begin //lw
                seldst = `Disable ;
                alusrc = `Enable ;
                memtoreg = `Enable ;
                regwrite = `Enable ;
                memread = `Enable ;
                memwrite = `Disable ;
                branch = `Disable ;
                aluop = 4'b0011 ;
            end
            6'b101011: begin //sw
                seldst = `Disable ;
                alusrc = `Enable ;
                memtoreg = `Disable ;
                regwrite = `Disable ;
                memread = `Disable ;
                memwrite = `Enable ;
                branch = `Disable ;
                aluop = 4'b1011 ;
            end
            6'b000100: begin //beq
                seldst = `Disable ;
                alusrc = `Disable ;
                memtoreg = `Disable ;
                regwrite = `Disable ;
                memread = `Disable ;
                memwrite = `Disable ;
                branch = `Enable ;
                aluop = 4'b0100 ;
            end
            6'b000010: begin //j
                seldst = `Disable ;
                alusrc = `Disable ;
                memtoreg = `Disable ;
                regwrite = `Disable ;
                memread = `Disable ;
                memwrite = `Disable ;
                branch = `Enable ;
                aluop = 4'b0010 ; 
            end
            default: begin
                seldst = `Disable ;
                alusrc = `Disable ;
                memtoreg = `Disable ;
                regwrite = `Disable ;
                memread = `Disable ;
                memwrite = `Disable ;
                branch = `Disable ;
                aluop = 4'b0000 ;
            end
    endcase

end	

endmodule