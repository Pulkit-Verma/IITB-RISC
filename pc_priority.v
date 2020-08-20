module pc_priority(is_jal,is_jlr,is_beq,is_R7_pc,jal_pc,jlr_pc,beq_pc,pc_p1,R7_pc,new_pc);

input is_jal,is_jlr,is_beq,is_R7_pc;
input [15:0] jal_pc,jlr_pc,beq_pc,pc_p1,R7_pc;
output reg [15:0] new_pc;

always @(*)
begin

if(is_R7_pc)
new_pc = R7_pc;
else if(is_jlr)
new_pc = jlr_pc;
else if(is_beq)
new_pc = beq_pc;
else if(is_jal)
new_pc = jal_pc;
else
new_pc = pc_p1;

end

endmodule 