module forwarding_unit(rr_ex_rs1,rr_ex_rs2,ex_mr_reg_wr,mr_wb_reg_wr,ex_mr_rd,mr_wb_rd,sel1,sel2);

input [2:0] rr_ex_rs1,rr_ex_rs2,ex_mr_rd,mr_wb_rd;
input ex_mr_reg_wr,mr_wb_reg_wr;
output reg [1:0] sel1,sel2;

always @(*)
begin

if( rr_ex_rs1 == 3'b111)
sel1 = 2'b11;
else if( ex_mr_reg_wr && (ex_mr_rd == rr_ex_rs1) )
sel1 = 2'b01;
else if( mr_wb_reg_wr && (mr_wb_rd == rr_ex_rs1) )
sel1 = 2'b10;
else sel1 = 2'b00;

if( rr_ex_rs2 == 3'b111)
sel1 = 2'b11;
else if( ex_mr_reg_wr && (ex_mr_rd == rr_ex_rs2) )
sel2 = 2'b01;
else if( mr_wb_reg_wr && (mr_wb_rd == rr_ex_rs2) )
sel2 = 2'b10;
else sel2 = 2'b00;

end

endmodule
