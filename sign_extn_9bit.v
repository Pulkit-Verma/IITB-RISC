module sign_extn_9bit (inp,out);

input [8:0] inp;
output [15:0] out;

assign out = { {7{inp[5]}},inp };

endmodule 