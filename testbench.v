`timescale 1 ns/ 100 ps
module testbench;

reg clk,reset;
integer i,j,k;

iitb_risc dut(clk,reset);

//assign dut.curr_pc_out = 16'h0000;

initial 
begin

$readmemb("bin_program.txt",dut.c2.mem);

for( i=0;i<=6;i=i+1 )
dut.c10.regb[i] = 16'h0000;

dut.c10.regb[2] = 16'h0002;
dut.c10.regb[3] = 16'h0003;
dut.c10.regb[4] = 16'h0004;

/*
for( k=0;k<=15;k=k+1 )
begin
dut.c45.beq_pc[k] = 16'h0000;
dut.c45.target_pc[k] = 16'h0000;
dut.c45.history_bits[k] = 2'b00;
end
*/
//dut.c10.regb[4] = 16'h0110;
//dut.c10.regb[5] = 16'h0110;
//for( j=1;j<=9;j=j+1)

//dut.c15.data_mem[10] = 16'h0000 ;

/*
dut.c15.data_mem[0] = 16'h0001 ;
dut.c15.data_mem[1] = 16'h0008 ;
dut.c15.data_mem[2] = 16'hfffa ;
dut.c15.data_mem[3] = 16'h0003 ;		// for sorting even numbers
dut.c15.data_mem[4] = 16'h0099 ;
dut.c15.data_mem[5] = 16'hfff0 ;
dut.c15.data_mem[6] = 16'h0011 ;
dut.c15.data_mem[7] = 16'h0543 ;
dut.c15.data_mem[8] = 16'h5555 ;
dut.c15.data_mem[9] = 16'hf0f4 ;

dut.c15.data_mem[0] = 16'h0004 ;
dut.c15.data_mem[1] = 16'h0002 ;
dut.c15.data_mem[2] = 16'hfff5 ;
dut.c15.data_mem[3] = 16'h0001 ;		// for sorting even numbers
dut.c15.data_mem[4] = 16'h0097 ;
dut.c15.data_mem[5] = 16'hfff9 ;
dut.c15.data_mem[6] = 16'h0013 ;
dut.c15.data_mem[7] = 16'h0543 ;
dut.c15.data_mem[8] = 16'h5555 ;
dut.c15.data_mem[9] = 16'hf0f2 ;
*/
//dut.c15.data_mem[1] = 16'h0004 ;
dut.c15.data_mem[10] = 16'h0000 ;

//#10 for ( j=0;j<=6;j=j+1 )
//$display("reg_%d = %d\n",j,dut.c10.regb[j]);

end

initial
begin
reset = 1; 
clk = 0;
#12 reset = 0;
#1000 $finish;

end

always 
#10 clk = ~clk;

initial
begin
//$monitor($time," R0 = %b R2 = %b R3 = %b R5 = %b",dut.c10.regb[0],dut.c10.regb[2],dut.c10.regb[3],dut.c10.regb[5]);
//$monitor($time," mem10 = %h mem11 = %h mem12 = %h mem13 = %h mem14 = %h mem15 = %h mem16 = %h",dut.c15.data_mem[10],dut.c15.data_mem[11],dut.c15.data_mem[12],dut.c15.data_mem[13],dut.c15.data_mem[14],dut.c15.data_mem[15],dut.c15.data_mem[16]);
//$monitor( $time," beq_pc0 = %b beq_pc1 = %b history_bits0 = %b history_bits1 = %b",dut.c45.beq_pc[0],dut.c45.beq_pc[1],dut.c45.history_bits[0],dut.c45.history_bits[1] );
$monitor( $time," R4 = %d",dut.c10.regb[4] );
//$monitor( $time," mem2 = %h",dut.c15.data_mem[2] );


end

endmodule	 