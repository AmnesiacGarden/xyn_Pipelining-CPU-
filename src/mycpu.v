`include "Defines.v"

module mycpu(
input        clk,
input        rst
);

// wire PCSrc;
wire [`Databus] pc;
// wire [`Databus] brpc;
wire [`Databus] addr;
wire [`Databus] npc;
wire [`Databus] inst;

wire [`Databus] if_id_npc;
wire [`Databus] if_id_inst;

wire         seldst;
wire         alusrc;
wire         memtoreg;
wire         regwrite;
wire         memread;
wire         memwrite;
wire         branch;
wire [`aluop]  aluop;

wire [`Databus] reg1;
wire [`Databus] reg2;

wire [`Databus] eximm;

wire [`Databus] ex_pc;
wire [`Databus] ex_reg1;
wire [`Databus] ex_reg2;
wire [`Databus] ex_signex;
wire [`Genbus]  ex_regrt;
wire [`Genbus]  ex_regrd;
wire            ex_seldst;
wire            ex_alusrc;
wire            ex_memtoreg;
wire            ex_regwrite;
wire            ex_memread;
wire            ex_memwrite;
wire            ex_branch;
wire [`aluop]   ex_aluop;

wire [`Databus] shift2;
wire [`Databus] brnpc;

wire [`sel]     alusel;
wire [`Databus] reg2_b;
wire [`Genbus]  regdst;
wire [`Databus] result;
wire            zero;

wire [`Databus] mm_pc;
wire [`Databus] mm_result;
wire [`Databus] mm_mmdata;
wire [`Genbus]  mm_regdst;
wire            mm_zero;
wire            mm_memtoreg;
wire            mm_regwrite;
wire            mm_memread;
wire            mm_memwrite;
wire            mm_branch;

wire [`Databus] mm_data;

wire [`Databus] wb_mmdata;
wire [`Databus] wb_result;
wire [`Genbus]  wb_regdst;
wire            wb_memtoreg;
wire            wb_regwrite;

wire [`Databus] wbdata;

// Mux2 #(32) PCMux2(
//     .a(npc),
//     .b(mm_pc),
//     .sel(1'd0),//mm_branch || mm_zero
//     .c(pc)
// );

// Pc Pc(
//     .clk(clk),
//     .rst(rst),
//     .pc(pc),
//     .addr(addr)
// );

// Add #(32) PCAdd(
//     .a(addr),
//     .b(32'd4),
//     .c(npc)
// );

pc_reg pc_reg(
    .clk(clk),
    .rst(rst),
    .pcsrc(mm_branch && mm_zero),
    .brpc(mm_pc),
//    .pc(addr),
    .addr(addr)
);

Instmem Instmem(
    .rst(rst),
    .addr(addr),
    .data_o(inst)
);
//------------------
if_id if_id(
    .clk(clk),
    .rst(rst),
    .if_pc(addr),
    .if_inst(inst),

    .id_pc(if_id_npc),
    .id_inst(if_id_inst)
);
//------------------

Ctrl Ctrl(
    .op(if_id_inst[`op]),

    .seldst(seldst),
    .alusrc(alusrc),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .memread(memread),
    .memwrite(memwrite),
    .branch(branch),
    .aluop(aluop)
);

Register Register(
    .clk(clk),
    .rst(rst),
    .wen(wb_regwrite),
    .waddr(wb_regdst),
    .wdata(wbdata),
    .raddr_a(if_id_inst[`rs]),
    .raddr_b(if_id_inst[`rt]),

    .rdata_a(reg1),
    .rdata_b(reg2)
);

Signex Signex(
    .imm(if_id_inst[`imm]),
    .eximm(eximm)
);

//------------------
id_ex id_ex(
    .clk(clk),
    .rst(rst),
    .id_pc(if_id_npc),
    .id_reg1(reg1),
    .id_reg2(reg2),
    .id_signex(eximm),
    .id_regrt(if_id_inst[`rt]),
    .id_regrd(if_id_inst[`rd]),
    .id_seldst(seldst),
    .id_alusrc(alusrc),
    .id_memtoreg(memtoreg),
    .id_regwrite(regwrite),
    .id_memread(memread),
    .id_memwrite(memwrite),
    .id_branch(branch),
    .id_aluop(aluop),
    
    .ex_pc(ex_pc),
    .ex_reg1(ex_reg1),
    .ex_reg2(ex_reg2),
    .ex_signex(ex_signex),
    .ex_regrt(ex_regrt),
    .ex_regrd(ex_regrd),
    .ex_seldst(ex_seldst),
    .ex_alusrc(ex_alusrc),
    .ex_memtoreg(ex_memtoreg),
    .ex_regwrite(ex_regwrite),
    .ex_memread(ex_memread),
    .ex_memwrite(ex_memwrite),
    .ex_branch(ex_branch),
    .ex_aluop(ex_aluop)
);
//------------------

assign shift2 = ex_signex << 2 ;

Add #(32) NPCAdd(
    .a(ex_pc),
    .b(shift2),
    .c(brnpc)
);

Mux2 #(32) ALUMux2(
    .a(ex_reg2),
    .b(ex_signex),
    .sel(ex_alusrc),
    .c(reg2_b)
);

Alu_Ctrl Alu_Ctrl(
    .aluop(ex_aluop),
    .func(ex_signex[`fc]),
    
    .alusel(alusel)
);

Alu Alu(
    .alusel(alusel),
    .reg1(ex_reg1),
    .reg2(reg2_b),
    
    .result(result),
    .zero(zero)
	
);

Mux2 #(5) DSTMux2(
    .a(ex_regrt),
    .b(ex_regrd),
    .sel(ex_seldst),
    .c(regdst)
);

//------------------
ex_mm ex_mm(
    .clk(clk),
    .rst(rst),
    .ex_pc(brnpc),
    .ex_result(result),
    .ex_mmdata(ex_reg2),
    .ex_regdst(regdst),
    .ex_zero(zero),
    .ex_memtoreg(ex_memtoreg),
    .ex_regwrite(ex_regwrite),
    .ex_memread(ex_memread),
    .ex_memwrite(ex_memwrite),
    .ex_branch(ex_branch),
    
    .mm_pc(mm_pc),
    .mm_result(mm_result),
    .mm_mmdata(mm_mmdata),
    .mm_regdst(mm_regdst),
    .mm_zero(mm_zero),
    .mm_memtoreg(mm_memtoreg),
    .mm_regwrite(mm_regwrite),
    .mm_memread(mm_memread),
    .mm_memwrite(mm_memwrite),
    .mm_branch(mm_branch)
);
//------------------

Datamem Datamem(
    .clk(clk),
    .wen(mm_memwrite),
    .ren(mm_memread),
    .addr(mm_result),
    .data_i(mm_mmdata),
    
    .data_o(mm_data)
);

//------------------
mm_wb mm_wb(
    .clk(clk),
    .rst(rst),
    .mm_mmdata(mm_data),
    .mm_result(mm_result),
    .mm_regdst(mm_regdst),
    .mm_memtoreg(mm_memtoreg),
    .mm_regwrite(mm_regwrite),
    
    .wb_mmdata(wb_mmdata),
    .wb_result(wb_result),
    .wb_regdst(wb_regdst),
    .wb_memtoreg(wb_memtoreg),
    .wb_regwrite(wb_regwrite)
);
//------------------

Mux2 #(32) REGMux2(
    .a(wb_result),
    .b(wb_mmdata),
    .sel(wb_memtoreg),
    .c(wbdata)
);


endmodule