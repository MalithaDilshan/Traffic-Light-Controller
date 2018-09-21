// Implementation of test bench for check the functionlity using the waveform
//`timescale 1ns/1ps

module top_module_tb;

	// Set up variables
	reg clock,reset,sensor,walk_request,reprogram;
	reg [1:0] time_parameter_selector;
	reg [3:0]time_value;
	//wire [3:0]value;
	wire [6:0]LEDs;
	
	// Intantiate the top module
	top_module my_top_module(.clock(clock), .reset(reset), .sensor(sensor),.walk_request(walk_request), .reprogram(reprogram), .time_parameter_selector(time_parameter_selector),
	                            .time_value(time_value), .LEDs(LEDs)
	                            );
	// generate a clock
	initial begin
    clock = 0;
     forever begin
        #1  clock = ~clock;
     end
  	end
	
	
	// Stimulate inputs
	initial
	begin
	   
	    #2 reset = 1'b0;
		//#1 reset = 1'b0; sensor = 1'b1; walk_request = 1'b1; reprogram = 1'b1; time_parameter_selector = 2'b00;time_value = 4'b0000;
		#3 reset = 1'b1;
		#4 reset = 1'b0; sensor = 1'b0; walk_request = 1'b0; reprogram = 1'b0; time_parameter_selector = 2'b00;time_value = 4'b0000;

		#260 walk_request = 1'b1;
		#50 walk_request = 1'b0;
		#140 sensor = 1'b1;
		#50 sensor = 1'b0;
        # 700 $finish;
		
	end
	
	
	
	
endmodule


