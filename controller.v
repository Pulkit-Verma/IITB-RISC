module controller (ir,rst,is_lw,is_jal,is_jlr,is_beq,m2,reg_write,mem_rd,mem_write,wr_add,m3,cz_op,cz_mod,ALU_op);

input [15:0] ir;
input rst;
output reg is_lw,is_jal,is_jlr,is_beq,m2,reg_write,mem_rd,mem_write;
output reg [2:0] wr_add;
output reg [1:0] m3,cz_op,cz_mod,ALU_op; 

always @(ir)
begin
if(rst)
begin
is_lw<= 0;
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 0;
reg_write<= 0;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= 3'b000;
cz_op<= 2'b00;
m3<= 2'b00;
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end

else
begin

case (ir[15:12])

4'b0000:begin		//ADD ADC ADZ
is_lw<= 0;
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 0;
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[5:3];
cz_op<= ir[1:0];
m3<= 2'b01;
cz_mod<= 2'b11;
ALU_op<= 2'b00;

end

4'b0001:begin		//ADI		
is_lw<= 0;
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;	// not used
m2<= 1;
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[11:9];
cz_op<= 2'b00;
m3<= 2'b01;
cz_mod<= 2'b11;
ALU_op<= 2'b00;

end

4'b0010:begin		//NDU NDC NCZ
is_lw<= 0;	
is_jlr<= 0;
is_beq<=  0;
is_jal<= 0;
m2<= 0;
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[5:3];
cz_op<= ir[1:0];
m3<= 2'b01;
cz_mod<= 2'b01;
ALU_op<= 2'b01;

end

4'b0011:begin		//LHI
is_lw<= 0;	// not used
is_jal<= 0;
is_jlr<= 0;
is_beq<= 0;
m2<= 0;	// not used
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[11:9];
cz_op<= 2'b00;
m3<= 2'b10;
cz_mod<= 2'b00;
ALU_op<= 2'b00;	//not used

end

4'b0100:begin		//LW
is_lw<= 1;	// not used	
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 1;		
reg_write<= 1;
mem_rd<= 1;
mem_write<= 0; 
wr_add<= ir[11:9];
cz_op<= 2'b00;
m3<= 2'b00;
cz_mod<= 2'b01;
ALU_op<= 2'b00;

end

4'b0101:begin		//SW
is_lw<= 0;	
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 1;		
reg_write<= 0;
mem_rd<= 0;
mem_write<= 1; 
wr_add<= ir[11:9];	//not used
cz_op<= 2'b00;
m3<= 2'b00; 	//not used
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end

4'b1000:begin		//JAL
is_lw<= 0;	
is_jlr<= 0;
is_beq<= 0;
is_jal<= 1;
m2<= 0;		//not used		
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[11:9];
cz_op<= 2'b00;
m3<= 2'b11; 	
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end

4'b1001:begin		//JLR
is_lw<= 0;	
is_jlr<= 1;
is_beq<= 0;
is_jal<= 0;
m2<= 0;		//not used		
reg_write<= 1;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[11:9];
cz_op<= 2'b00;
m3<= 2'b11; 	
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end

4'b1100:begin		//BEQ
is_lw<= 0;	
is_jlr<= 0;
is_beq<= 1;
is_jal<= 0;
m2<= 0;				
reg_write<= 0;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= ir[11:9];		//not used
cz_op<= 2'b00;
m3<= 2'b00;		//not used 	
cz_mod<= 2'b00;
ALU_op<= 2'b10;


end

4'b0110:begin		//LM
is_lw<= 0;	
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 0;		//not used				
if(ir[7:0] != 8'h00 )
reg_write<= 1;
else
reg_write<= 0;

mem_rd<= 1;
mem_write<= 0; 
wr_add<= ir[11:9];		//not used
cz_op<= 2'b00;
m3<= 2'b00;		//not used 	
cz_mod<= 2'b00;
ALU_op<= 2'b00;		

end

4'b0111:begin		//SM
is_lw<= 0;	
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 0;				
reg_write<= 0;
mem_rd<= 0;
if(ir[7:0] != 8'h00 )
mem_write<= 1;
else
mem_write<= 0;

wr_add<= ir[11:9];		//not used
cz_op<= 2'b00;
m3<= 2'b00;		//not used 	
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end

default:begin
is_lw<= 0;
is_jlr<= 0;
is_beq<= 0;
is_jal<= 0;
m2<= 0;
reg_write<= 0;
mem_rd<= 0;
mem_write<= 0; 
wr_add<= 3'b000;
cz_op<= 2'b00;
m3<= 2'b00;
cz_mod<= 2'b00;
ALU_op<= 2'b00;

end 

endcase

end

end

endmodule 