module pc (clk,rst,stall,is_beq,is_jlr,pc_in,pc_out);

input clk,rst,stall,is_beq,is_jlr;
input [15:0] pc_in;
output reg [15:0] pc_out;

always @(posedge clk)
begin
if(rst)
pc_out<= 16'h0000;
else if( !stall || is_beq || is_jlr )
pc_out<=pc_in;

end

endmodule 