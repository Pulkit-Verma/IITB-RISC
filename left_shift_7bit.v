module left_shift_7bit (inp,out);

input [8:0] inp;
output [15:0] out;

assign out = inp << 7;

endmodule 