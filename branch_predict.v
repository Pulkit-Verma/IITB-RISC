/*
module branch_predict(clk,curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,RR_EX_is_taken,next_pc,mux_sel,pc_prio_is_beq,pc_prio_beq_pc);
//module branch_predict(curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,ALU_out_zero,next_pc,mux_sel,pc_prio_is_beq,pc_prio_beq_pc);

input clk,RR_EX_is_beq,RR_EX_is_taken;
input [15:0] curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc;
output reg [15:0] next_pc,pc_prio_beq_pc;
output reg mux_sel,pc_prio_is_beq;

integer i,j,location;
reg is_present_1,is_present_2;
reg [1:0] case_no;
reg [3:0] position = 4'b0000;
reg [15:0] beq_pc [15:0];
reg [15:0] target_pc [15:0];
reg [1:0] history_bits [15:0];  
//wire RR_EX_is_taken;

//assign RR_EX_is_taken = RR_EX_is_beq & ALU_out_zero;

always @(curr_pc)
begin
	is_present_1 = 0;

	for( i=0;i<=15;i=i+1 )
	begin

		if( curr_pc == beq_pc[i] )
		begin
			next_pc = target_pc[i];
			mux_sel = history_bits[i][1];		// and this with !is_jlr and !is_beq and !is_jal
			is_present_1 = 1;
		end

	end

	if(!is_present_1)		// true if either inst is not beq or the current beq is encountered for the first time
	begin
	mux_sel = 0;  
   next_pc = 16'h0000; // won't be loaded as mux_sel = 0 
	
	end
	
end


always @(*)//RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,RR_EX_is_taken)
begin

	is_present_2 = 0;
  // add_new_beq = 0;	
	//update_hb = 0;
	//case_no = 2'b00;
	
	if(RR_EX_is_beq)
	begin
		
		for(j=0;j<=15;j=j+1)
		begin

			if( RR_EX_pc == beq_pc[j] )
			begin
				is_present_2 = 1;
				
				case( {history_bits[j][1],RR_EX_is_taken} )
				
				2'b00:begin
					pc_prio_is_beq = 0;
					pc_prio_beq_pc = target_pc[j];		// won't be loaded
					if(history_bits[j] == 2'b01)
					begin	
							history_bits[j] = 2'b00;
					end
					
						end
				
				2'b01:begin
					pc_prio_is_beq = 1;
					pc_prio_beq_pc = target_pc[j];
					history_bits[j] = history_bits[j] + 2'b01;
					
						end
				
				2'b10:begin
					pc_prio_is_beq = 1;
					pc_prio_beq_pc = RR_EX_pc_p1; 
					history_bits[j] = history_bits[j] - 2'b01;			
					
					end
				
				2'b11:begin
					pc_prio_is_beq = 0;
					pc_prio_beq_pc = target_pc[j];		//won't be loaded 	
					if(history_bits[j] == 2'b10)
					begin	
						history_bits[j] = 2'b11;
						  
					end		
					
						end
					
				endcase	

			end

		end
		
		if(is_present_2 == 0)		// encountered a new beq instruction
		begin
		
		pc_prio_is_beq = RR_EX_is_taken;
		pc_prio_beq_pc = RR_EX_target_pc;
	   beq_pc[position] = RR_EX_pc;
		target_pc[position] = RR_EX_target_pc;
		history_bits[position] = { RR_EX_is_taken, ~RR_EX_is_taken };
		position = position + 1;	
			
		end

	end
	
	else
	begin
	pc_prio_is_beq = 0;
	pc_prio_beq_pc = 16'h0000;		// not loaded
	
	end
	
end

endmodule 
*/




module branch_predict(clk,curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,RR_EX_is_taken,next_pc,mux_sel,pc_prio_is_beq,pc_prio_beq_pc);
//module branch_predict(curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,ALU_out_zero,next_pc,mux_sel,pc_prio_is_beq,pc_prio_beq_pc);

input clk,RR_EX_is_beq,RR_EX_is_taken;
input [15:0] curr_pc,RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc;
output reg [15:0] next_pc,pc_prio_beq_pc;
output reg mux_sel,pc_prio_is_beq;

integer i,j,location;
reg is_present_1,is_present_2,add_new_beq,update_hb,new_RR_EX_is_taken;
reg [1:0] case_no;
reg [3:0] position = 4'b0000;
reg [15:0] beq_pc [15:0];
reg [15:0] target_pc [15:0];
reg [1:0] history_bits [15:0]; 
reg [15:0] new_RR_EX_pc,new_RR_EX_target_pc;
//wire RR_EX_is_taken;

//assign RR_EX_is_taken = RR_EX_is_beq & ALU_out_zero;

always @(curr_pc)
begin
	is_present_1 = 0;

	for( i=0;i<=15;i=i+1 )
	begin

		if( curr_pc == beq_pc[i] )
		begin
			next_pc = target_pc[i];
			mux_sel = history_bits[i][1];		// and this with !is_jlr and !is_beq and !is_jal
			is_present_1 = 1;
		end

	end

	if(!is_present_1)		// true if either inst is not beq or the current beq is encountered for the first time
	begin
	mux_sel = 0;  
   next_pc = 16'h0000; // won't be loaded as mux_sel = 0 
	
	end
	
end


always @(*)//RR_EX_pc,RR_EX_pc_p1,RR_EX_target_pc,RR_EX_is_beq,RR_EX_is_taken)
begin

	
  // add_new_beq = 0;	
	//update_hb = 0;
	//case_no = 2'b00;
	
	if(RR_EX_is_beq)
	begin
	
	is_present_2 = 0;
		
		for(j=0;j<=15;j=j+1)
		begin

			if( RR_EX_pc == beq_pc[j] )
			begin
				is_present_2 = 1;
				add_new_beq = 0;
				
				case( {history_bits[j][1],RR_EX_is_taken} )
				
				2'b00:begin
					pc_prio_is_beq = 0;
					pc_prio_beq_pc = target_pc[j];		// won't be loaded
					if(history_bits[j] == 2'b01)
					begin	
						//history_bits[j] = 2'b00;
							update_hb = 1;
							case_no = 2'b00;
							location = j;
					end
					
						end
				
				2'b01:begin
					pc_prio_is_beq = 1;
					pc_prio_beq_pc = target_pc[j];
					//history_bits[j] = history_bits[j] + 2'b01;
					update_hb = 1;
					case_no = 2'b01;
					location = j;
					
						end
				
				2'b10:begin
					pc_prio_is_beq = 1;
					pc_prio_beq_pc = RR_EX_pc_p1; 
					//history_bits[j] = history_bits[j] - 2'b01;			
					update_hb = 1;
					case_no = 2'b10;
					location = j;
					
						end
				
				2'b11:begin
					pc_prio_is_beq = 0;
					pc_prio_beq_pc = target_pc[j];		//won't be loaded 	
					if(history_bits[j] == 2'b10)
					begin	
						//history_bits[j] = 2'b11;
						  update_hb = 1;
						  case_no = 2'b11;
						  location = j;
					end		
					
						end
					
				endcase	

			end

		end
		
		if(is_present_2 == 0)		// encountered a new beq instruction
		begin
		add_new_beq = 1;
		update_hb = 0;	
		pc_prio_is_beq = RR_EX_is_taken;
		pc_prio_beq_pc = RR_EX_target_pc; 
		new_RR_EX_pc = RR_EX_pc;
		new_RR_EX_target_pc = RR_EX_target_pc;
		new_RR_EX_is_taken = RR_EX_is_taken;
			
		end

	end
	
	else
	begin
	pc_prio_is_beq = 0;
	pc_prio_beq_pc = 16'h0000;		// not loaded
	add_new_beq = 0;	
	update_hb = 0;
	
	end
	
end


always @(posedge clk)
begin

	if(update_hb)
	begin
	
		case(case_no)
	
		2'b00:
		history_bits[location] = 2'b00;
		
		2'b01:
		history_bits[location] = history_bits[location] + 2'b01;
		
		2'b10:
		history_bits[location] = history_bits[location] - 2'b01;
		
		2'b11:
		history_bits[location] = 2'b11;
		
		endcase
		
		
	
	end

	else if(add_new_beq)
	begin
		beq_pc[position] = new_RR_EX_pc;
		target_pc[position] = new_RR_EX_target_pc;
		history_bits[position] = { new_RR_EX_is_taken, ~ new_RR_EX_is_taken };
		position = position + 1;

	end

end

endmodule 









