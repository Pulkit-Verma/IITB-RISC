module LM_SM_control (ir,rst,count,is_lm,is_sm,reg_addr,new_ir,addr_offset,new_count);

input [15:0] ir,count;
input rst;
output reg is_lm,is_sm;
output reg [15:0] new_ir,addr_offset,new_count;
output reg [2:0] reg_addr;

always @(ir)
begin
if(rst)
begin
is_lm = 0;
is_sm = 0;
reg_addr = 3'b000;		
addr_offset = 16'h0000;
new_ir = 16'hffff;  
new_count = 16'h0000; 

end

else if(ir[15:12] == 4'b0110)		// is_lm
begin
is_sm = 0;

if( ir[0] )
begin
is_lm = 1;
reg_addr = 3'b000;		// i.e. wr_add for reg_bank		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:1],1'b0};   

end

else if( ir[1] )
begin
is_lm = 1;
reg_addr = 3'b001;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:2],2'b00}; 

end

else if( ir[2] )
begin
is_lm = 1;
reg_addr = 3'b010;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:3],3'b000}; 

end
else if( ir[3] )
begin
is_lm = 1;
reg_addr = 3'b011;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:4],4'b0000}; 

end
else if( ir[4] )
begin
is_lm = 1;
reg_addr = 3'b100;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:5],5'b00000}; 

end
else if( ir[5] )
begin
is_lm = 1;
reg_addr = 3'b101;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:6],6'b000000}; 

end
else if( ir[6] )
begin
is_lm = 1;
reg_addr = 3'b110;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:7],7'b0000000}; 

end
else if( ir[7] )
begin
is_lm = 1;
reg_addr = 3'b111;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:8],8'b00000000}; 

end

else
begin
is_lm = 0;
reg_addr = 3'b000;		
addr_offset = 16'h0000;
new_ir = 16'hffff; 
//new_count = 16'h0000; 

end

if( (ir[7:0] == 0) ||(ir[7:0] == 1) || (ir[7:0] == 2) || (ir[7:0] == 4) || (ir[7:0] == 8) || (ir[7:0] == 16) || (ir[7:0] == 32) || (ir[7:0] == 64) || (ir[7:0] == 128) )
new_count = 16'h0000;

else
new_count = count + 1;

end

else if(ir[15:12] == 4'b0111)		// is_sm
begin
is_lm = 0;

if( ir[0] )
begin
is_sm = 1;
reg_addr = 3'b000;		// read from this register ( send to rd_add_1 )		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:1],1'b0};   

end 

else if( ir[1] )
begin
is_sm = 1;
reg_addr = 3'b001;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:2],2'b00}; 

end

else if( ir[2] )
begin
is_sm = 1;
reg_addr = 3'b010;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:3],3'b000}; 

end
else if( ir[3] )
begin
is_sm = 1;
reg_addr = 3'b011;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:4],4'b0000}; 

end
else if( ir[4] )
begin
is_sm = 1;
reg_addr = 3'b100;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:5],5'b00000}; 

end
else if( ir[5] )
begin
is_sm = 1;
reg_addr = 3'b101;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:6],6'b000000}; 

end
else if( ir[6] )
begin
is_sm = 1;
reg_addr = 3'b110;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:7],7'b0000000}; 

end
else if( ir[7] )
begin
is_sm = 1;
reg_addr = 3'b111;		
addr_offset = count;
//new_count = count+1;
new_ir = {ir[15:8],8'b00000000}; 

end

else
begin
is_sm = 0;
reg_addr = 3'b000;		
addr_offset = 16'h0000;
new_ir = 16'hffff; 
//new_count = 16'h0000; 

end

if( (ir[7:0] == 0) ||(ir[7:0] == 1) || (ir[7:0] == 2) || (ir[7:0] == 4) || (ir[7:0] == 8) || (ir[7:0] == 16) || (ir[7:0] == 32) || (ir[7:0] == 64) || (ir[7:0] == 128) )
new_count = 16'h0000;

else
new_count = count + 1;

end 

else		// neither lm nor sm
begin
is_lm = 0;
is_sm = 0;
reg_addr = 3'b000;		
addr_offset = 16'h0000;
new_ir = 16'hffff; 
new_count = 16'h0000;  

end

end

endmodule 