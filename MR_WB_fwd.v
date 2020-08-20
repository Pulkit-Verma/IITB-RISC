module MR_WB_fwd (ex_mr_mem_wr,reg_addr,mr_wb_wr_addr,mr_wb_mem_rd,mux_sel);

input ex_mr_mem_wr,mr_wb_mem_rd;
input [2:0] reg_addr,mr_wb_wr_addr;
output reg mux_sel;

always @(*)
begin

if( ex_mr_mem_wr && mr_wb_mem_rd && ( mr_wb_wr_addr == reg_addr ) )
mux_sel =1;

else
mux_sel =0;

end

endmodule
