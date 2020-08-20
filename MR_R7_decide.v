module MR_R7_decide (opcode,cz_op,wr_add,cz_reg_write,alu_out,mem_rd_data,is_R7_pc,R7_pc);

input [3:0] opcode;
input [2:0] wr_add;
input cz_reg_write;
input [15:0] alu_out, mem_rd_data;
input [1:0] cz_op;
output reg is_R7_pc;
output reg [15:0] R7_pc;

always @(*)
begin

case(opcode)

4'b0000, 4'b0010:		// ADC, ADZ, NDC, NDZ
begin

if( ( (cz_op == 2'b01) || (cz_op == 2'b10) ) && (wr_add == 3'b111) && cz_reg_write )
begin

is_R7_pc = 1;
R7_pc = alu_out;

end

else
begin

is_R7_pc = 0;
R7_pc = 16'h0000;

end

end

4'b0100, 4'b0110:		// LW LM
begin

if( wr_add == 3'b111)
begin

is_R7_pc = 1;
R7_pc = mem_rd_data;

end

else
begin

is_R7_pc = 0;
R7_pc = 16'h0000;

end

end


default:
begin

is_R7_pc = 0;
R7_pc = 16'h0000;		//won't be used

end

endcase

end

endmodule 