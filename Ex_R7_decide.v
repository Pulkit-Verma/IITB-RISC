module Ex_R7_decide (opcode,wr_add,alu_out,cz_op,shift_out,is_R7_pc,R7_pc);

input [3:0] opcode;
input [2:0] wr_add;
input [15:0] alu_out, shift_out;
input [1:0] cz_op;
output reg is_R7_pc;
output reg [15:0] R7_pc;

always @(*)
begin

case(opcode)

4'b0000, 4'b0010:		// ADD, NDU
begin

if( (cz_op == 2'b00) && (wr_add == 3'b111) )
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

4'b0001:		// ADI
begin

if( wr_add == 3'b111)
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

4'b0011:		// LHI
begin

if( wr_add == 3'b111)
begin

is_R7_pc = 1;
R7_pc = shift_out;

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
