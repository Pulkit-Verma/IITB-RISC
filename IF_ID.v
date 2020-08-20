module IF_ID (clk,rst,part_stall,stall,curr_pc_in,pc_p1_in,ir_in,new_count_in,curr_pc_out,pc_p1_out,ir_out,new_count_out);

input clk,rst,part_stall,stall;
input [15:0] curr_pc_in,pc_p1_in,ir_in,new_count_in;
output reg [15:0] curr_pc_out,pc_p1_out,ir_out,new_count_out;

always @ (posedge clk)
begin

if(rst)
begin
curr_pc_out<= 16'h0000;
pc_p1_out<= 16'h0000;
ir_out<= 16'hffff; 		// controller will run default case
new_count_out<=16'h0000;

end

else
begin
if(!stall)
begin
ir_out<= ir_in;
new_count_out<= new_count_in;

if(!part_stall)
begin
curr_pc_out<= curr_pc_in;
pc_p1_out<= pc_p1_in;

end

end

end

end

endmodule 