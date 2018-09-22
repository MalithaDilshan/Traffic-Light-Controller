

module time_parameter_tb;

	// Set up variables
	reg clock,reset,prog_sync;
    reg [1:0] time_parameter_selector;
    reg [1:0] interval_code;
    reg [3:0] time_value;

    wire [3:0] value;
	
	
	// Intantiate the synchronizer 
	time_parameter my_time_parameter(.clk(clock), .reset(reset), .time_parameter_selector(time_parameter_selector), .time_value(time_value),
                                     .prog_sync(prog_sync), .interval_code(interval_code), .value(value)
	);
	
	// generate a clock
	always begin     
        #5  clock = ~clock;
  	end
	
	
	// Stimulate inputs
	initial
	begin
        clock = 0;

		#5 interval_code = 2'b10; reset = 1'b0;
        #6 $display($time," value= %d",value);
        /* #1 interval_code = 2'b00; reset = 1'b1;
           $display($time," value= %d",value);*/

        #1 time_parameter_selector  = 2'b10; time_value = 4'b1101; prog_sync = 1'b1;
        #2 interval_code = 2'b10; reset = 1'b0;
        #25 $display($time," value= %d",value);
        #1 prog_sync = 1'b0;
        #1 reset = 1'b1;
        #1 reset = 1'b0;
        #6 $display($time," value= %d",value);

        
        
	     
		#25 $finish;
		
		
	end
	/*
	initial
	begin
		$monitor($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
	end*/
	
	
	
endmodule

