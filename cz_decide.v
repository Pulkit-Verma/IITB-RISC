module cz_decide (cz_op,c_flag,z_flag,reg_wr_default,reg_wr_new);

input [1:0] cz_op;
input c_flag,z_flag,reg_wr_default;
output reg reg_wr_new;

//assign reg_wr_new = ( (cz_op[1] && c_flag && !cz_op[0]) || (cz_op[0] && z_flag && !cz_op[1]) )? 1 : (cz_op==2'b00)? reg_wr_default : 0;

always @(*)
begin

if( (cz_op[1] && c_flag && !cz_op[0]) || (cz_op[0] && z_flag && !cz_op[1]) )
reg_wr_new = 1;
else if(cz_op==2'b00)
reg_wr_new = reg_wr_default;
else reg_wr_new = 0;

end

endmodule    