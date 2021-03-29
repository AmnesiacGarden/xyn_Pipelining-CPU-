`include "Defines.v"

module Instmem(
input   rst,
input [`Databus]    addr,
output [`Databus]   data_o
);

reg [`Regwidth] memory [0:127];

integer i;

assign data_o = memory[addr[18:2]];

// always @(*) begin
//     if (rst) begin
//         memory[0]  <= 32'h00004020;//add $t0,$zero,$zero
//         memory[1]  <= 32'h00004820;//add $t1,$zero,$zero
//         memory[2]  <= 32'h00005020;//add $t2,$zero,$zero
//         memory[3]  <= 32'h00005820;//add $t3,$zero,$zero
//         memory[4]  <= 32'had280000;//sw $t0,0($t1)
//         memory[5]  <= 32'h01497022;//sub $t6,$t2,$t1
//         memory[6]  <= 32'h00227824;//and $t7,$1,$2
//         memory[7]  <= 32'h0039c025;//or $t8,$1,$t9
//         memory[8]  <= 32'h0040c82a;//slt $t9,$2,$0
//         memory[9] <= 32'h8d250000;//lw $a1,0($t1)
//         for (i = 10; i < 128; i = i + 1) begin
//             memory[i] = 32'h0;
//         end
//     end
// end
always @(*) begin
    if (rst) begin
        memory[0]  <= 32'h00004020;//add $t0,$zero,$zero
        memory[1]  <= 32'h00004820;//add $t1,$zero,$zero
        memory[2]  <= 32'h00005020;//add $t2,$zero,$zero
        memory[3]  <= 32'h00005820;//add $t3,$zero,$zero
        memory[4]  <= 32'h00006020;//add $t4,$zero,$zero
        memory[5]  <= 32'had280000;//sw $t0,0($t1)
        memory[6]  <= 32'h01497022;//sub $t6,$t2,$t1
        memory[7]  <= 32'h00227824;//and $t7,$1,$2
        memory[8]  <= 32'h0039c025;//or $t8,$1,$t9
        memory[9]  <= 32'h0040c82a;//slt $t9,$2,$0
        memory[10] <= 32'h8d250000;//lw $a1,0($t1)
        memory[11] <= 32'h08000000;//j
        memory[12] <= 32'h10000000;//beq
        for (i = 13; i < 128; i = i + 1) begin
            memory[i] = 32'h0;
        end
    end
end

endmodule