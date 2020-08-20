module bubble_decide( rs1,rs2,is_lw,is_lm_RR_EX,reg_write,rd,opcode,nop);

input [2:0] rs1,rs2,rd;
input is_lw,is_lm_RR_EX,reg_write;
input [3:0] opcode;
output reg nop;

always @(*)
begin

//if( (is_lw || (is_lm_RR_EX && !is_lm_ID_RR) ) && reg_write && ( (rs1 == rd) || (rs2 == rd) ) )
if( (is_lw || is_lm_RR_EX) && reg_write && ( (rs1 == rd) || (rs2 == rd) ) )
begin

case (opcode)

4'b0011, 4'b1000:		// LHI JAL
nop = 0;

4'b0001, 4'b0100, 4'b0101, 4'b1001:		// ADI, LW, SW, JLR
begin

if( (rs2 == rd) && (rs1 != rd) )
nop = 0;

else
nop = 1;

end

4'b0110:		// LM 
begin

if( (rs1 == rd) && (rs2 != rd) )
nop = 0;

else
nop = 1;

end

4'b0000, 4'b0010, 4'b0111, 4'b1100:		// ADD, NAND, SM, BEQ
nop = 1;

default:
nop = 0;

endcase

end

else

nop = 0;

end

endmodule 