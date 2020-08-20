module lw_z_decide (mem_data,new_z);

input [15:0] mem_data;
output reg new_z;

always @(*)
begin

if(mem_data==16'h0000)
new_z = 1;

else new_z = 0;

end

endmodule 