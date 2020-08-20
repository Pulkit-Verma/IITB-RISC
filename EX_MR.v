module EX_MR (clk,rst,m3_in,cz_op_in,reg_write_in,wr_add_in,mem_rd_in,mem_write_in,shift_in,rd_data_2_in,ALU_res_in,c_flag_in,z_flag_in,is_lw_in,cz_mod_in,curr_pc_in,pc_p1_in,is_sm_in,rd_data_1_in,rs1_in,rs2_in,opcode_in,m3_out,cz_op_out,reg_write_out,wr_add_out,mem_rd_out,mem_write_out,shift_out,rd_data_2_out,ALU_res_out,c_flag_out,z_flag_out,is_lw_out,cz_mod_out,curr_pc_out,pc_p1_out,is_sm_out,rd_data_1_out,rs1_out,rs2_out,opcode_out);

input clk,rst,reg_write_in,mem_rd_in,mem_write_in,c_flag_in,z_flag_in,is_lw_in,is_sm_in;
input [15:0] shift_in,rd_data_2_in,ALU_res_in,curr_pc_in,pc_p1_in,rd_data_1_in; 
input [1:0] m3_in,cz_op_in,cz_mod_in;
input [2:0] wr_add_in,rs1_in,rs2_in; 
input [3:0] opcode_in;
output reg reg_write_out,mem_rd_out,mem_write_out,c_flag_out,z_flag_out,is_lw_out,is_sm_out;
output reg [15:0] shift_out,rd_data_2_out,ALU_res_out,curr_pc_out,pc_p1_out,rd_data_1_out;
output reg [1:0] m3_out,cz_op_out,cz_mod_out;
output reg [2:0] wr_add_out,rs1_out,rs2_out;
output reg [3:0] opcode_out;

always @ (posedge clk)
begin
if(rst)
begin
reg_write_out<= 0;
mem_rd_out<= 0;
mem_write_out<= 0;
wr_add_out<= 3'b000;
shift_out<= 16'h0000;
m3_out<= 2'b00;
cz_op_out<= 2'b00;
rd_data_2_out<= 16'h0000;
ALU_res_out<= 16'h0000;
c_flag_out<= 0;
z_flag_out<= 0;
is_lw_out<= 0;
cz_mod_out<= 2'b00;
curr_pc_out<=16'h0000;
pc_p1_out<=16'h0000;
is_sm_out<= 0;
rd_data_1_out<= 16'h0000;
rs1_out<= 3'b000;
rs2_out<= 3'b000;
opcode_out<= 4'b1111;

end

else
begin 
reg_write_out<= reg_write_in;
mem_rd_out<= mem_rd_in;
mem_write_out<= mem_write_in;
wr_add_out<= wr_add_in;
shift_out<= shift_in;
m3_out<= m3_in;
cz_op_out<= cz_op_in;
rd_data_2_out<= rd_data_2_in;
ALU_res_out<= ALU_res_in;
c_flag_out<= c_flag_in;
z_flag_out<= z_flag_in;
is_lw_out<= is_lw_in;
cz_mod_out<= cz_mod_in;
curr_pc_out<=curr_pc_in;
pc_p1_out<=pc_p1_in;
is_sm_out<= is_sm_in;
rd_data_1_out<= rd_data_1_in;
rs1_out<= rs1_in;
rs2_out<= rs2_in;
opcode_out<= opcode_in;

end

end

endmodule 