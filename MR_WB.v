module MR_WB (clk,rst,m3_in,reg_write_in,wr_add_in,shift_in,ALU_res_in,mem_rd_data_in,c_flag_in,z_flag_in,cz_mod_in,curr_pc_in,pc_p1_in,mem_rd_in,m3_out,reg_write_out,wr_add_out,shift_out,ALU_res_out,mem_rd_data_out,c_flag_out,z_flag_out,curr_pc_out,pc_p1_out,mem_rd_out);

input clk,rst,reg_write_in,c_flag_in,z_flag_in,mem_rd_in;
input [15:0] shift_in,ALU_res_in,mem_rd_data_in,curr_pc_in,pc_p1_in; 
input [1:0] m3_in,cz_mod_in;
input [2:0] wr_add_in;
output reg reg_write_out,c_flag_out,z_flag_out,mem_rd_out;
output reg [15:0] shift_out,ALU_res_out,mem_rd_data_out,curr_pc_out,pc_p1_out;
output reg [1:0] m3_out;
output reg [2:0] wr_add_out;

always @ (posedge clk)
begin
if(rst)
begin
reg_write_out<= 0;
wr_add_out<= 3'b000;
shift_out<= 16'h0000;
m3_out<= 2'b00;
ALU_res_out<= 16'h0000;
mem_rd_data_out<= 16'h0000;
curr_pc_out<= 16'h0000;
pc_p1_out<= 16'h0000;
c_flag_out<= 0;
z_flag_out<= 0;
mem_rd_out<=0;

end

else
begin 
reg_write_out<= reg_write_in;
wr_add_out<= wr_add_in;
shift_out<= shift_in;
m3_out<= m3_in;
ALU_res_out<= ALU_res_in;
mem_rd_data_out<= mem_rd_data_in;
curr_pc_out<=curr_pc_in;
pc_p1_out<=pc_p1_in;
mem_rd_out<=mem_rd_in;

if(cz_mod_in[1])
c_flag_out<= c_flag_in;
if(cz_mod_in[0])
z_flag_out<= z_flag_in;

end

end

endmodule 