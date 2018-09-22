
`timescale 1ns / 1ps

module timer_tb;

	// Set up variables
	reg clock,start_timer;
	reg [3:0] value;
	wire expired;
	
	// Intantiate the synchronizer 
	timer my_timer(.clk1(clock), .start_timer(start_timer), .value(value), .expired(expired)
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
		#5 start_timer = 1'b1; value = 4'b0111;

		#12 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		
		
	    #25 $finish;
		
		
	end
	/*
	initial
	begin
		$monitor($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
	end*/
	
	
	
endmodule

