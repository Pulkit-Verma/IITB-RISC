module read_data_modify(rd_addr_1,rd_addr_2,wr_addr,reg_write,mux_sel_1,mux_sel_2);

input [2:0] rd_addr_1,rd_addr_2,wr_addr;
input reg_write;
output reg mux_sel_1,mux_sel_2;

always @(*)
begin

if( reg_write && (rd_addr_1 == wr_addr) )
mux_sel_1 = 1;
else
mux_sel_1 = 0;

if(reg_write && (rd_addr_2 == wr_addr))
mux_sel_2 = 1;
else
mux_sel_2 = 0;

end

endmodule 