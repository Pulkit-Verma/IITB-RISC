module JAL_R7_decide (is_jal,rd,new_is_jal);

input is_jal;
input [2:0] rd;
output reg new_is_jal;

always @(*)
begin

if( is_jal && (rd == 3'b111) )
new_is_jal = 0;

else
new_is_jal = is_jal;

end

endmodule
 