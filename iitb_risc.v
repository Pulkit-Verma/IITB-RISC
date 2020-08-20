`timescale 1 ns/ 100 ps

module iitb_risc (clk,reset);

input clk,reset;

wire [15:0] pc_adder_out,curr_pc_out,curr_ir,IF_ID_curr_pc,IF_ID_pc_p1,IF_ID_ir,se6_out,se9_out,lf7_out,ID_RR_curr_pc,ID_RR_pc_p1,ID_RR_se6,ID_RR_se9,ID_RR_shift,reg_rd_data_1,reg_rd_data_2,RR_EX_curr_pc,RR_EX_pc_p1,RR_EX_se6,RR_EX_se9,RR_EX_shift,RR_EX_rd_data_1,RR_EX_rd_data_2,EX_mux_out,EX_ALU_out,EX_MR_shift,EX_MR_rd_data_2,EX_MR_ALU_res,data_mem_rd_out,MR_WB_shift,MR_WB_ALU_res,MR_WB_mem_rd_out,WB_mux_out,EX_MR_curr_pc,EX_MR_pc_p1,MR_WB_curr_pc,MR_WB_pc_p1,ID_add_out,EX_add_out,pc_priority_out,new_ir_cnt_2,addr_offset_cnt_2,new_ir,ID_RR_addr_offset,RR_EX_addr_offset,EX_MR_rd_data_1,EX_new_rd_data_1,MR_new_wr_data,ID_new_count,new_count_cnt_2,MR_forward_out,EX_frwd_mux_out_1,EX_frwd_mux_out_2,new_rd_data_1,new_rd_data_2,predict_pc,predict_mux_out,prio_beq_pc,mem_fwd_wr_data,EX_R7_pc,MR_R7_pc,R7_pc_new;
wire is_lw_cnt,is_jal_cnt,is_jlr_cnt,is_beq_cnt,m2_cnt,reg_write_cnt,mem_rd_cnt,mem_write_cnt,ID_RR_is_lw,ID_RR_m2,ID_RR_reg_write,ID_RR_mem_rd,ID_RR_mem_write,RR_EX_m2,RR_EX_reg_write,RR_EX_mem_rd,RR_EX_mem_write,RR_EX_is_lw,EX_z_flag,EX_c_flag,EX_MR_reg_write,EX_MR_mem_rd,EX_MR_mem_write,EX_MR_c_flag,EX_MR_z_flag,EX_MR_is_lw,MR_reg_wr_new,MR_WB_reg_write,MR_WB_c_flag,MR_WB_z_flag,MR_new_z,MR_mux_out,cnt_ID_RR_rst,ID_RR_is_jlr,ID_RR_is_beq,RR_EX_is_jlr,RR_EX_is_beq,IF_ID_reset,ID_RR_reset,RR_EX_reset,is_lm_cnt_2,is_sm_cnt_2,ID_part_stall_control,ID_ir_mux_control,ID_RR_is_lm,ID_RR_is_sm,RR_EX_is_lm,RR_EX_is_sm,EX_MR_is_sm,EX_lm_or_sm,EX_is_eq,RR_mux_sel_1,RR_mux_sel_2,RR_nop,pc_stall,predict_mux_sel,prio_is_beq,pc_mux_sel,MR_WB_mem_rd,MR_fwd_mux_sel,EX_is_R7_pc,MR_is_R7_pc,is_jal_new,is_jlr_new,EX_MR_reset,is_R7_pc;
wire [1:0] m3_cnt,cz_op_cnt,cz_mod_cnt,ALU_op_cnt,ID_RR_m3,ID_RR_cz_op,ID_RR_cz_mod,ID_RR_ALU_op,RR_EX_m3,RR_EX_cz_op,RR_EX_cz_mod,RR_EX_ALU_op,EX_MR_m3,EX_MR_cz_op,EX_MR_cz_mod,MR_WB_m3,frwd_sel_1,frwd_sel_2;
wire [2:0] wr_add_cnt,ID_RR_wr_add,RR_EX_wr_add,EX_MR_wr_add,MR_WB_wr_add,ID_RR_rd_addr_1,ID_RR_rd_addr_2,reg_addr_cnt_2,new_rd_addr_1,new_wr_add,RR_EX_rs1,RR_EX_rs2,EX_MR_rs1,EX_MR_rs2,MR_reg_addr_mux_out;
wire [3:0] ID_RR_opcode,RR_EX_opcode,EX_MR_opcode;

pc c1 ( .clk(clk), .rst(reset), .stall(pc_stall), .is_beq(prio_is_beq), .is_jlr(is_jlr_new), .pc_in(predict_mux_out), .pc_out(curr_pc_out) );

inst_memory c2 ( .addr(curr_pc_out), .inst(curr_ir) );

pc_adder c3 ( .curr_pc(curr_pc_out), .next_pc(pc_adder_out) );

IF_ID c4 ( .clk(clk), .rst(IF_ID_reset), .part_stall(ID_part_stall_control), .stall(RR_nop), .curr_pc_in(curr_pc_out), .pc_p1_in(pc_adder_out), .ir_in(new_ir), .new_count_in(new_count_cnt_2), .curr_pc_out(IF_ID_curr_pc), .pc_p1_out(IF_ID_pc_p1), .ir_out(IF_ID_ir), .new_count_out(ID_new_count) );

controller c5 ( .ir(IF_ID_ir), .rst(reset), .is_lw(is_lw_cnt), .is_jal(is_jal_cnt), .is_jlr(is_jlr_cnt),.is_beq(is_beq_cnt), .m2(m2_cnt), .reg_write(reg_write_cnt), .mem_rd(mem_rd_cnt), .mem_write(mem_write_cnt), .wr_add(wr_add_cnt), .m3(m3_cnt), .cz_op(cz_op_cnt), .cz_mod(cz_mod_cnt), .ALU_op(ALU_op_cnt) );

sign_extn_6bit c6 ( .inp(IF_ID_ir[5:0]), .out(se6_out) );

sign_extn_9bit c7 ( .inp(IF_ID_ir[8:0]), .out(se9_out) );

left_shift_7bit c8 ( .inp(IF_ID_ir[8:0]), .out(lf7_out) );

ID_RR c9 ( .clk(clk), .rst(ID_RR_reset), .stall(RR_nop), .curr_pc_in(IF_ID_curr_pc), .pc_p1_in(IF_ID_pc_p1), .rd_addr_1_in(new_rd_addr_1), .rd_addr_2_in(IF_ID_ir[11:9]), .is_lw_in(is_lw_cnt), .is_jlr_in(is_jlr_cnt), .is_beq_in(is_beq_cnt), .m2_in(m2_cnt), .m3_in(m3_cnt), .cz_op_in(cz_op_cnt), .cz_mod_in(cz_mod_cnt), .ALU_op_in(ALU_op_cnt), .reg_write_in(reg_write_cnt), .wr_add_in(new_wr_add), .mem_rd_in(mem_rd_cnt), .mem_write_in(mem_write_cnt), .se6_in(se6_out), .se9_in(se9_out), .shift_in(lf7_out), .is_lm_in(is_lm_cnt_2), .is_sm_in(is_sm_cnt_2), .addr_offset_in(addr_offset_cnt_2), .opcode_in(IF_ID_ir[15:12]),
 .curr_pc_out(ID_RR_curr_pc), .pc_p1_out(ID_RR_pc_p1), .rd_addr_1_out(ID_RR_rd_addr_1), .rd_addr_2_out(ID_RR_rd_addr_2), .is_lw_out(ID_RR_is_lw), .is_jlr_out(ID_RR_is_jlr), .is_beq_out(ID_RR_is_beq), .m2_out(ID_RR_m2), .m3_out(ID_RR_m3), .cz_op_out(ID_RR_cz_op), .cz_mod_out(ID_RR_cz_mod), .ALU_op_out(ID_RR_ALU_op), .reg_write_out(ID_RR_reg_write), .wr_add_out(ID_RR_wr_add), .mem_rd_out(ID_RR_mem_rd), .mem_write_out(ID_RR_mem_write), .se6_out(ID_RR_se6), .se9_out(ID_RR_se9), .shift_out(ID_RR_shift), .is_lm_out(ID_RR_is_lm), .is_sm_out(ID_RR_is_sm), .addr_offset_out(ID_RR_addr_offset), .opcode_out(ID_RR_opcode) );

reg_bank c10 (.clk(clk), .rd_addr_1(ID_RR_rd_addr_1), .rd_addr_2(ID_RR_rd_addr_2), .reg_write(MR_WB_reg_write), .wr_add(MR_WB_wr_add), .wr_data(WB_mux_out), .pc(predict_mux_out), .rd_data_1(reg_rd_data_1), .rd_data_2(reg_rd_data_2) ); 
 
RR_EX c11 ( .clk(clk), .rst(RR_EX_reset), .nop(RR_nop), .curr_pc_in(ID_RR_curr_pc), .pc_p1_in(ID_RR_pc_p1), .m2_in(ID_RR_m2), .m3_in(ID_RR_m3), .cz_op_in(ID_RR_cz_op), .cz_mod_in(ID_RR_cz_mod), .ALU_op_in(ID_RR_ALU_op), .reg_write_in(ID_RR_reg_write), .wr_add_in(ID_RR_wr_add), .mem_rd_in(ID_RR_mem_rd), .mem_write_in(ID_RR_mem_write), .se6_in(ID_RR_se6), .se9_in(ID_RR_se9), .shift_in(ID_RR_shift), .rd_data_1_in(new_rd_data_1), .rd_data_2_in(new_rd_data_2), .is_lw_in(ID_RR_is_lw), .is_jlr_in(ID_RR_is_jlr), .is_beq_in(ID_RR_is_beq), .is_lm_in(ID_RR_is_lm), .is_sm_in(ID_RR_is_sm), .addr_offset_in(ID_RR_addr_offset), .rs1_in(ID_RR_rd_addr_1), .rs2_in(ID_RR_rd_addr_2), .opcode_in(ID_RR_opcode),
 .curr_pc_out(RR_EX_curr_pc), .pc_p1_out(RR_EX_pc_p1), .m2_out(RR_EX_m2), .m3_out(RR_EX_m3), .cz_op_out(RR_EX_cz_op), .cz_mod_out(RR_EX_cz_mod), .ALU_op_out(RR_EX_ALU_op), .reg_write_out(RR_EX_reg_write), .wr_add_out(RR_EX_wr_add), .mem_rd_out(RR_EX_mem_rd), .mem_write_out(RR_EX_mem_write), .se6_out(RR_EX_se6), .se9_out(RR_EX_se9), .shift_out(RR_EX_shift), .rd_data_1_out(RR_EX_rd_data_1), .rd_data_2_out(RR_EX_rd_data_2), .is_lw_out(RR_EX_is_lw), .is_jlr_out(RR_EX_is_jlr), .is_beq_out(RR_EX_is_beq), .is_lm_out(RR_EX_is_lm), .is_sm_out(RR_EX_is_sm), .addr_offset_out(RR_EX_addr_offset), .rs1_out(RR_EX_rs1), .rs2_out(RR_EX_rs2), .opcode_out(RR_EX_opcode) );
 
mux_2to1_16bit c12 ( .in1(EX_frwd_mux_out_2), .in2(RR_EX_se6), .sel(RR_EX_m2), .out(EX_mux_out) );

ALU  c13 ( .ALU_op(RR_EX_ALU_op), .cz_mod(RR_EX_cz_mod), .in1(EX_new_rd_data_1), .in2(EX_mux_out), .alu_out(EX_ALU_out), .z_flag(EX_z_flag), .c_flag(EX_c_flag) );

EX_MR c14 ( .clk(clk), .rst(EX_MR_reset), .m3_in(RR_EX_m3), .cz_op_in(RR_EX_cz_op), .reg_write_in(RR_EX_reg_write), .wr_add_in(RR_EX_wr_add), .mem_rd_in(RR_EX_mem_rd), .mem_write_in(RR_EX_mem_write), .shift_in(RR_EX_shift), .rd_data_2_in(EX_frwd_mux_out_2), .ALU_res_in(EX_ALU_out), .c_flag_in(EX_c_flag), .z_flag_in(EX_z_flag), .is_lw_in(RR_EX_is_lw), .cz_mod_in(RR_EX_cz_mod), .curr_pc_in(RR_EX_curr_pc), .pc_p1_in(RR_EX_pc_p1), .is_sm_in(RR_EX_is_sm), .rd_data_1_in(EX_frwd_mux_out_1), .rs1_in(RR_EX_rs1), .rs2_in(RR_EX_rs2), .opcode_in(RR_EX_opcode), 
 .m3_out(EX_MR_m3), .cz_op_out(EX_MR_cz_op), .reg_write_out(EX_MR_reg_write), .wr_add_out(EX_MR_wr_add), .mem_rd_out(EX_MR_mem_rd), .mem_write_out(EX_MR_mem_write), .shift_out(EX_MR_shift), .rd_data_2_out(EX_MR_rd_data_2), .ALU_res_out(EX_MR_ALU_res), .c_flag_out(EX_MR_c_flag), .z_flag_out(EX_MR_z_flag), .is_lw_out(EX_MR_is_lw), .cz_mod_out(EX_MR_cz_mod),.curr_pc_out(EX_MR_curr_pc), .pc_p1_out(EX_MR_pc_p1), .is_sm_out(EX_MR_is_sm), .rd_data_1_out(EX_MR_rd_data_1), .rs1_out(EX_MR_rs1), .rs2_out(EX_MR_rs2), .opcode_out(EX_MR_opcode) );

data_memory c15 ( .clk(clk), .mem_rd(EX_MR_mem_rd), .mem_write(EX_MR_mem_write), .mem_addr(EX_MR_ALU_res), .wr_data(mem_fwd_wr_data), .rd_data(data_mem_rd_out) );

cz_decide c16 ( .cz_op(EX_MR_cz_op), .c_flag(MR_WB_c_flag), .z_flag(MR_WB_z_flag), .reg_wr_default(EX_MR_reg_write), .reg_wr_new(MR_reg_wr_new) );
 
lw_z_decide c17 ( .mem_data(data_mem_rd_out), .new_z(MR_new_z) );

mux_2to1 c18 ( .in1(EX_MR_z_flag), .in2(MR_new_z), .sel(EX_MR_is_lw), .out(MR_mux_out) );

MR_WB c19 ( .clk(clk), .rst(reset), .m3_in(EX_MR_m3), .reg_write_in(MR_reg_wr_new), .wr_add_in(EX_MR_wr_add), .shift_in(EX_MR_shift), .ALU_res_in(EX_MR_ALU_res), .mem_rd_data_in(data_mem_rd_out), .c_flag_in(EX_MR_c_flag), .z_flag_in(MR_mux_out), .cz_mod_in(EX_MR_cz_mod), .curr_pc_in(EX_MR_curr_pc), .pc_p1_in(EX_MR_pc_p1), .mem_rd_in(EX_MR_mem_rd), .m3_out(MR_WB_m3), .reg_write_out(MR_WB_reg_write), .wr_add_out(MR_WB_wr_add), .shift_out(MR_WB_shift), .ALU_res_out(MR_WB_ALU_res), .mem_rd_data_out(MR_WB_mem_rd_out), .c_flag_out(MR_WB_c_flag), .z_flag_out(MR_WB_z_flag), .curr_pc_out(MR_WB_curr_pc), .pc_p1_out(MR_WB_pc_p1), .mem_rd_out(MR_WB_mem_rd) );

mux_4to1_16bit c20 ( .in1(MR_WB_mem_rd_out), .in2(MR_WB_ALU_res), .in3(MR_WB_shift), .in4(MR_WB_pc_p1), .sel(MR_WB_m3), .out(WB_mux_out) );

adder c21 ( .in1(IF_ID_curr_pc), .in2(se9_out), .out(ID_add_out) );

pc_priority c22 ( .is_jal(is_jal_new), .is_jlr(is_jlr_new), .is_beq(prio_is_beq), .is_R7_pc(is_R7_pc), .jal_pc(ID_add_out), .jlr_pc(EX_frwd_mux_out_1), .beq_pc(prio_beq_pc), .pc_p1(pc_adder_out), .R7_pc(R7_pc_new), .new_pc(pc_priority_out) );

or c23 ( IF_ID_reset, reset, is_jal_new, is_jlr_new, prio_is_beq, EX_is_R7_pc, MR_is_R7_pc );

or c24 ( ID_RR_reset, reset, is_jlr_new, prio_is_beq, EX_is_R7_pc, MR_is_R7_pc );

or c25 ( RR_EX_reset, reset, is_jlr_new, prio_is_beq, EX_is_R7_pc, MR_is_R7_pc );

and  c26 ( EX_is_eq, RR_EX_is_beq, EX_ALU_out[0] );

adder c27 ( .in1(RR_EX_curr_pc), .in2(RR_EX_se6), .out(EX_add_out) );

LM_SM_control c28 ( .ir(IF_ID_ir), .rst(reset), .count(ID_new_count), .is_lm(is_lm_cnt_2), .is_sm(is_sm_cnt_2), .reg_addr(reg_addr_cnt_2), .new_ir(new_ir_cnt_2), .addr_offset(addr_offset_cnt_2), .new_count(new_count_cnt_2) );

ir_mux_stall_control c29 ( .ir(IF_ID_ir), .rst(reset), .mux_control(ID_ir_mux_control), .stall(ID_part_stall_control) );

mux_2to1_16bit c30 ( .in1(curr_ir), .in2(new_ir_cnt_2), .sel(ID_ir_mux_control), .out(new_ir) );

mux_2to1_3bit c31 ( .in1(IF_ID_ir[8:6]), .in2(reg_addr_cnt_2), .sel(is_sm_cnt_2), .out(new_rd_addr_1) );

mux_2to1_3bit c32 ( .in1(wr_add_cnt), .in2(reg_addr_cnt_2), .sel(is_lm_cnt_2), .out(new_wr_add) );

or c33 ( EX_lm_or_sm,RR_EX_is_lm,RR_EX_is_sm );

mux_2to1_16bit c34 ( .in1(EX_frwd_mux_out_1), .in2(RR_EX_addr_offset), .sel(EX_lm_or_sm), .out(EX_new_rd_data_1) );

mux_2to1_16bit c35 ( .in1(EX_MR_rd_data_2), .in2(EX_MR_rd_data_1), .sel(EX_MR_is_sm), .out(MR_new_wr_data) );

mem_forward c36 ( .m3(EX_MR_m3), .alu_out(EX_MR_ALU_res), .shift_out(EX_MR_shift), .pc_p1(EX_MR_pc_p1), .mem_frwd_data(MR_forward_out) );

forwarding_unit c37 ( .rr_ex_rs1(RR_EX_rs1), .rr_ex_rs2(RR_EX_rs2), .ex_mr_reg_wr(EX_MR_reg_write), .mr_wb_reg_wr(MR_WB_reg_write), .ex_mr_rd(EX_MR_wr_add), .mr_wb_rd(MR_WB_wr_add), .sel1(frwd_sel_1), .sel2(frwd_sel_2) );

mux_4to1_16bit c38 ( .in1(RR_EX_rd_data_1), .in2(MR_forward_out), .in3(WB_mux_out), .in4(RR_EX_curr_pc), .sel(frwd_sel_1), .out(EX_frwd_mux_out_1) );

mux_4to1_16bit c39 ( .in1(RR_EX_rd_data_2), .in2(MR_forward_out), .in3(WB_mux_out), .in4(RR_EX_curr_pc), .sel(frwd_sel_2), .out(EX_frwd_mux_out_2) );

read_data_modify c40 ( .rd_addr_1(ID_RR_rd_addr_1), .rd_addr_2(ID_RR_rd_addr_2), .wr_addr(MR_WB_wr_add), .reg_write(MR_WB_reg_write), .mux_sel_1(RR_mux_sel_1), .mux_sel_2(RR_mux_sel_2) );

mux_2to1_16bit c41 ( .in1(reg_rd_data_1), .in2(WB_mux_out), .sel(RR_mux_sel_1), .out(new_rd_data_1) );

mux_2to1_16bit c42 ( .in1(reg_rd_data_2), .in2(WB_mux_out), .sel(RR_mux_sel_2), .out(new_rd_data_2) );

bubble_decide c43 ( .rs1(ID_RR_rd_addr_1), .rs2(ID_RR_rd_addr_2), .is_lw(RR_EX_is_lw), .is_lm_RR_EX(RR_EX_is_lm), .reg_write(RR_EX_reg_write), .rd(RR_EX_wr_add), .opcode(ID_RR_opcode), .nop(RR_nop) );

or c44 ( pc_stall,ID_part_stall_control,RR_nop );

branch_predict c45 ( .clk(clk), .curr_pc(curr_pc_out), .RR_EX_pc(RR_EX_curr_pc), .RR_EX_pc_p1(RR_EX_pc_p1), .RR_EX_target_pc(EX_add_out), .RR_EX_is_beq(RR_EX_is_beq), .RR_EX_is_taken(EX_is_eq), .next_pc(predict_pc), .mux_sel(predict_mux_sel), .pc_prio_is_beq(prio_is_beq), .pc_prio_beq_pc(prio_beq_pc) );

mux_2to1_16bit c46 ( .in1(pc_priority_out), .in2(predict_pc), .sel(pc_mux_sel), .out(predict_mux_out) );

and c47 ( pc_mux_sel,predict_mux_sel,!is_jal_new,!is_jlr_new,!prio_is_beq );

mux_2to1_3bit c48 ( .in1(EX_MR_rs2), .in2(EX_MR_rs1), .sel(EX_MR_is_sm), .out(MR_reg_addr_mux_out) );

MR_WB_fwd c49 ( .ex_mr_mem_wr(EX_MR_mem_write), .reg_addr(MR_reg_addr_mux_out), .mr_wb_wr_addr(MR_WB_wr_add), .mr_wb_mem_rd(MR_WB_mem_rd), .mux_sel(MR_fwd_mux_sel) );

mux_2to1_16bit c50 ( .in1(MR_new_wr_data), .in2(WB_mux_out), .sel(MR_fwd_mux_sel), .out(mem_fwd_wr_data) );

Ex_R7_decide c51 ( .opcode(RR_EX_opcode), .wr_add(RR_EX_wr_add), .alu_out(EX_ALU_out), .cz_op(RR_EX_cz_op), .shift_out(RR_EX_shift), .is_R7_pc(EX_is_R7_pc), .R7_pc(EX_R7_pc) );

MR_R7_decide c52 ( .opcode(EX_MR_opcode), .cz_op(EX_MR_cz_op), .wr_add(EX_MR_wr_add), .cz_reg_write(MR_reg_wr_new), .alu_out(EX_MR_ALU_res), .mem_rd_data(data_mem_rd_out), .is_R7_pc(MR_is_R7_pc), .R7_pc(MR_R7_pc) );

JAL_R7_decide c53 ( .is_jal(is_jal_cnt), .rd(wr_add_cnt), .new_is_jal(is_jal_new) );

JLR_R7_decide c54 ( .is_jlr(RR_EX_is_jlr), .rr_ex_rs2(RR_EX_rs2), .new_is_jlr(is_jlr_new) );

or c55 ( EX_MR_reset, reset, MR_is_R7_pc );

or c56 ( is_R7_pc, EX_is_R7_pc, MR_is_R7_pc );

R7_pc_priority c57 ( .is_R7_pc_Ex(EX_is_R7_pc), .is_R7_pc_MR(MR_is_R7_pc), .R7_pc_Ex(EX_R7_pc), .R7_pc_MR(MR_R7_pc), .new_R7_pc(R7_pc_new) );

endmodule 