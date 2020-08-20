module sign_extn_6bit (inp,out);

input [5:0] inp;
output [15:0] out;

assign out = { {10{inp[5]}},inp };

endmodule 