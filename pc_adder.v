module pc_adder(curr_pc,next_pc);

input [15:0] curr_pc;
output [15:0] next_pc;

assign next_pc = curr_pc + 1;

endmodule 
