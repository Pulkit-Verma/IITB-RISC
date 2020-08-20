module JLR_R7_decide (is_jlr,rr_ex_rs2,new_is_jlr);

input is_jlr;
input [2:0] rr_ex_rs2;
output reg new_is_jlr;

always @(*)
begin

if( is_jlr && (rr_ex_rs2 == 3'b111) )
new_is_jlr = 0;

else
new_is_jlr = is_jlr;

end

endmodule 

