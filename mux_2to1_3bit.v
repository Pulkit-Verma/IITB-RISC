module mux_2to1_3bit (in1,in2,sel,out);

input [2:0] in1,in2;
input sel;
output reg [2:0] out;

//assign out = (!sel)? in1 : in2;

always @(*)
begin

if(sel)
out = in2;
else
out = in1;

end

endmodule 