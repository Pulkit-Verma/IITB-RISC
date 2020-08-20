module reg_bank (clk,rd_addr_1,rd_addr_2,reg_write,wr_add,wr_data,pc,rd_data_1,rd_data_2);

input clk,reg_write;
input [2:0] rd_addr_1,rd_addr_2,wr_add;
input [15:0] wr_data,pc;
output [15:0] rd_data_1,rd_data_2;

reg [15:0] regb [7:0];

assign rd_data_1 = regb [rd_addr_1];
assign rd_data_2 = regb [rd_addr_2];

always @ (posedge clk) 
begin

regb [7] <= pc;
if( reg_write && (wr_add != 3'b111) )
regb [wr_add] <= wr_data;

end

//always @(pc)
//regb [7] <= pc;

endmodule 