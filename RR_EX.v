module RR_EX (clk,rst,nop,curr_pc_in,pc_p1_in,m2_in,m3_in,cz_op_in,cz_mod_in,ALU_op_in,reg_write_in,wr_add_in,mem_rd_in,mem_write_in,se6_in,se9_in,shift_in,rd_data_1_in,rd_data_2_in,is_lw_in,is_jlr_in,is_beq_in,is_lm_in,is_sm_in,addr_offset_in,rs1_in,rs2_in,opcode_in,curr_pc_out,pc_p1_out,m2_out,m3_out,cz_op_out,cz_mod_out,ALU_op_out,reg_write_out,wr_add_out,mem_rd_out,mem_write_out,se6_out,se9_out,shift_out,rd_data_1_out,rd_data_2_out,is_lw_out,is_jlr_out,is_beq_out,is_lm_out,is_sm_out,addr_offset_out,rs1_out,rs2_out,opcode_out);

input clk,rst,nop,m2_in,reg_write_in,mem_rd_in,mem_write_in,is_lw_in,is_jlr_in,is_beq_in,is_lm_in,is_sm_in;
input [15:0] curr_pc_in,pc_p1_in,se6_in,se9_in,shift_in,rd_data_1_in,rd_data_2_in,addr_offset_in; 
input [1:0] m3_in,cz_op_in,cz_mod_in,ALU_op_in;
input [2:0] wr_add_in,rs1_in,rs2_in;
input [3:0] opcode_in;
output reg m2_out,reg_write_out,mem_rd_out,mem_write_out,is_lw_out,is_jlr_out,is_beq_out,is_lm_out,is_sm_out;
output reg [15:0] curr_pc_out,pc_p1_out,se6_out,se9_out,shift_out,rd_data_1_out,rd_data_2_out,addr_offset_out;
output reg [1:0] m3_out,cz_op_out,cz_mod_out,ALU_op_out;
output reg [2:0] wr_add_out,rs1_out,rs2_out;
output reg [3:0] opcode_out;

always @ (posedge clk)
begin
if(rst)
begin
m2_out<= 0;
reg_write_out<= 0;
mem_rd_out<= 0;
mem_write_out<= 0;
curr_pc_out<= 16'h0000;
pc_p1_out<= 16'h0000;
wr_add_out<= 3'b000;
se6_out<= 16'h0000;
se9_out<= 16'h0000;
shift_out<= 16'h0000;
m3_out<= 2'b00;
cz_op_out<= 2'b00;
cz_mod_out<= 2'b00;
ALU_op_out<= 2'b00;
rd_data_1_out<= 16'h0000;
rd_data_2_out<= 16'h0000;
is_lw_out<= 0;
is_jlr_out<=0;
is_beq_out<=0;
is_lm_out<= 0;
is_sm_out<= 0;
addr_offset_out<= 16'h0000;
rs1_out<= 3'b000;
rs2_out<= 3'b000;
opcode_out<= 4'b1111;

end

else
begin 
m2_out<= m2_in;
mem_rd_out<= mem_rd_in;
curr_pc_out<= curr_pc_in;
pc_p1_out<= pc_p1_in;
wr_add_out<= wr_add_in;
se6_out<= se6_in;
se9_out<= se9_in;
shift_out<= shift_in;
m3_out<= m3_in;
ALU_op_out<= ALU_op_in;
rd_data_1_out<= rd_data_1_in;
rd_data_2_out<= rd_data_2_in;
addr_offset_out<=addr_offset_in;
rs1_out<= rs1_in;
rs2_out<= rs2_in;

if(nop)
begin
reg_write_out<= 0;
mem_write_out<= 0;
cz_op_out<= 2'b00;
cz_mod_out<= 2'b00;
is_lw_out<= 0;
is_jlr_out<=0;
is_beq_out<=0;
is_lm_out<= 0;
is_sm_out<= 0;
opcode_out<= 4'b1111;

end

else
begin
reg_write_out<= reg_write_in;
mem_write_out<= mem_write_in;
cz_op_out<= cz_op_in;
cz_mod_out<= cz_mod_in;
is_lw_out<= is_lw_in;
is_jlr_out<=is_jlr_in;
is_beq_out<=is_beq_in;
is_lm_out<=is_lm_in;
is_sm_out<=is_sm_in;
opcode_out<= opcode_in;

end

end

end

endmodule 