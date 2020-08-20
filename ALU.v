module ALU (ALU_op,cz_mod,in1,in2,alu_out,z_flag,c_flag);

input [1:0] ALU_op,cz_mod;
input [15:0] in1,in2;
output reg [15:0] alu_out;
output reg z_flag,c_flag;

reg carry;
reg [15:0] temp;

always @ (*)
begin

case (ALU_op)

2'b00:
{carry,alu_out} = in1+in2;

2'b01:
alu_out= ~(in1 & in2);

2'b10:begin
if(in1==in2)
alu_out = 16'h0001;
else
alu_out = 16'h0000;

end

default:
alu_out = 16'bx;

endcase

if(cz_mod[1])
begin

if(carry)
c_flag=1;

else
c_flag=0;

end

if(cz_mod[0])
begin

if(alu_out==16'b0)
z_flag=1;

else
z_flag=0;

end

end

endmodule 