module ir_mux_stall_control(ir,rst,mux_control,stall);

input [15:0] ir;
input rst;
output reg mux_control,stall;

always @(ir)
begin

if(rst)
begin
mux_control = 0;
stall = 0;

end

else if( (ir[15:12] == 4'b0110) || (ir[15:12] == 4'b0111) )
begin

if( (ir[7:0] == 0) ||(ir[7:0] == 1) || (ir[7:0] == 2) || (ir[7:0] == 4) || (ir[7:0] == 8) || (ir[7:0] == 16) || (ir[7:0] == 32) || (ir[7:0] == 64) || (ir[7:0] == 128) )
begin
mux_control = 0;
stall = 0;

end

else
begin
mux_control = 1;
stall = 1;

end

end

else
begin
mux_control = 0;
stall = 0;

end

end

endmodule 