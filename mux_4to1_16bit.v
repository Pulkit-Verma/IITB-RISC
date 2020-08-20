module mux_4to1_16bit (in1,in2,in3,in4,sel,out);

input [15:0] in1,in2,in3,in4;
input [1:0] sel;
output reg [15:0] out;

always @ (*)
begin

case (sel)

2'b00:
out<= in1;

2'b01:
out<= in2;

2'b10:
out<= in3;

2'b11:
out<= in4;

default:
out<=16'bx;

endcase

end

endmodule 