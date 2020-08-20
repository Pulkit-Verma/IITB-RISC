module R7_pc_priority (is_R7_pc_Ex,is_R7_pc_MR,R7_pc_Ex,R7_pc_MR,new_R7_pc);

input is_R7_pc_Ex,is_R7_pc_MR;
input [15:0] R7_pc_Ex,R7_pc_MR;
output reg [15:0] new_R7_pc;

always @(*)
begin

if( is_R7_pc_MR )
new_R7_pc = R7_pc_MR;

else if( is_R7_pc_Ex )
new_R7_pc = R7_pc_Ex;

else
new_R7_pc = 16'h0000;

end

endmodule


