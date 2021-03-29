//------Data width------
`define        Genbus              4:0
`define        Databus             31:0

`define        op                  31:26
`define        fc                  5:0
`define        rs                  25:21
`define        rt                  20:16
`define        rd                  15:11
`define        sa                  10:6
`define        sel                 3:0
`define        imm                 15:0
`define        index               25:0

`define        aluop               3:0
`define        optype              9:6
`define        opcode              5:0

`define        related             3:0

`define        CP0Addr             7:0

`define        Regwidth            31:0

//------Defaults------
`define        Zero                1'b0
`define        ZeroWord            32'b0
`define        ZeroDouleWord       64'b0 
    
`define        Enable              1'b1
`define        Disable             1'b0

//------ALU_Ctrl------
`define        lw_s               4'b0010
`define        sw_s               4'b0010
`define        beq_s              4'b0110
`define        j_s                4'b1000
`define        add_s              4'b0010
`define        sub_s              4'b0110
`define        and_s              4'b0000
`define        or_s               4'b0001
`define        slt_s              4'b0111