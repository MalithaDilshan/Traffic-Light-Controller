

module divider_tb;

	// Set up variables
	reg clock,reset;
    wire new_clock;
	
	
	// Intantiate the synchronizer 
	divider my_divider(.clk(clock), .reset(reset), .new_clk(new_clock)
                    	);
	
	// generate a clock
	always begin     
        #1  clock = ~clock;
  	end
	
	
	// Stimulate inputs
	initial
	begin
        clock = 0;
        reset = 1'b1; 
        # 1 reset = 1'b0; 
        /*
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
        #1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
        #1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
	     */
	     

	#40 $finish;
		
		
	end
	/*
	initial
	begin
		$monitor($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
	end*/
	
	
	
endmodule

