//implementation of the Finite State Machine

module fsm(clk,reset,sensor_sync,wr,prog_sync,expired,wr_reset,interval,start_timer,output1);

input clk,sensor_sync,wr,prog_sync,expired;
output reg wr_reset,start_timer;
output reg [1:0] interval;
output reg [6:0] output1;
input  reset;

reg temp_reset;


// possible states
parameter GREEN_M1 = 3'b000;
parameter GREEN_M2 = 3'b001;
parameter YELLOW_M = 3'b010;
parameter RED_M = 3'b011;
parameter GREEN_S = 3'b100;
parameter YELLOW_S = 3'b101;
parameter RED_s = 3'b110;
parameter WALK = 3'b111;

parameter code_t_base = 2'b00;
parameter code_t_yel = 2'b10;
parameter code_t_ext = 2'b01;
//parameter code_t_base_plus_ext = 2'b11;

reg [2:0] current_state;

initial
begin
  output1 = 7'b0000000;
  wr_reset = 1'b0;
  temp_reset = 1'b0;
end

always @(posedge clk)
begin
	// if get the reset of prog_sync if will set to the initial state of the loop
	if(prog_sync) 
		current_state = GREEN_M1;
	
end

// illustrate the functionality of the state machine
// output : walk, R_S, Y_S, G_S, R_M, Y_M,G_M1
// to run the system press reset

always @(posedge reset)
begin
    current_state = GREEN_M1;
    temp_reset = 1'b1;
end

always @(negedge expired or negedge reset)
begin
	start_timer = 1'b0;
end


always @(posedge expired or posedge temp_reset)
begin
  
    //$display("**%b",current_state);
	case(current_state)

	GREEN_M1:
	begin
		if((expired == 1'b1) & (sensor_sync == 1'b1))
		 begin
			current_state = GREEN_M2;
			interval = code_t_ext;
			start_timer = 1'b1;
		    output1 = 7'b0100001;
		 end
		else if((expired == 1'b1) & (sensor_sync == 1'b0))
		 begin
			current_state = GREEN_M2;
			interval = code_t_base;
			start_timer = 1'b1;
		    output1 = 7'b0100001;
		 end
		else
		 begin
			interval = code_t_base;
			start_timer = 1'b1;
		    output1 = 7'b0100001;
			current_state = GREEN_M1;
		 end
	end

	GREEN_M2:
	begin
		if(expired == 1'b1) 
		 begin
			current_state = YELLOW_M;
			interval = code_t_yel;
			start_timer = 1'b1;
		  output1 = 7'b0100010;
		 end
		else
			current_state = GREEN_M2;
	end

	YELLOW_M:
	begin
		if((expired == 1'b1) & (wr == 1'b1))
		 begin
			current_state = WALK;
			interval = code_t_ext;
			start_timer = 1'b1;
		    output1 = 7'b1100100;  // represent RED_M state also
		 end
		else if((expired == 1'b1) & (wr == 1'b0))
		 begin
			current_state = GREEN_S;
			interval = code_t_base;
			start_timer = 1'b1;
		    output1 = 7'b0001100;
		 end
		else
			current_state = YELLOW_M;

	end
	
	WALK:
	begin
		if(expired == 1'b1) 
		 begin
		  wr_reset = 1'b1;
			current_state = GREEN_S;
			interval = code_t_base;
			start_timer = 1'b1;
		    output1 = 7'b0001100;
		 end
		else
			current_state = WALK;
	end

	GREEN_S:
	begin
		if((expired == 1'b1) & (sensor_sync == 1'b1))
		 begin
		 	wr_reset = 1'b0;
			current_state = GREEN_S;
			interval = code_t_ext;
			start_timer = 1'b1;
		    output1 = 7'b0010100;
		 end
		else if((expired == 1'b1) & (sensor_sync == 1'b0))
		 begin
		 	wr_reset = 1'b0;
			current_state = YELLOW_S;
			interval = code_t_yel;
			start_timer = 1'b1;
		    output1 = 7'b0010100;
		 end
		else
			current_state = GREEN_S;
		
	end
	
	YELLOW_S:
	begin
	// loop back to the first state again 
		if(expired == 1'b1) 
		 begin
			current_state = GREEN_M1;   // this state represent the parallel state RED_S also
			interval = code_t_base;
			start_timer = 1'b1;
		  	output1 = 7'b0100001;
		 end
		else
			current_state = YELLOW_S;
	end

endcase
end

endmodule 
