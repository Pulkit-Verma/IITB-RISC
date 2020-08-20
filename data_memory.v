module data_memory (clk,mem_rd,mem_write,mem_addr,wr_data,rd_data); 

input clk,mem_rd,mem_write;					
input [15:0] mem_addr;
input [15:0] wr_data;
output [15:0] rd_data;

reg [15:0] data_mem [65535:0];
 
assign rd_data = (mem_rd && !mem_write) ? data_mem [mem_addr] : 8'bz;

always @ (posedge clk)
begin

if(mem_write && !mem_rd)
data_mem [mem_addr]<= wr_data;
end

endmodule  

