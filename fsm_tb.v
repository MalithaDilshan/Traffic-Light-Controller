
module fsm_tb;

	// Set up variables
	reg clock,reset,sensor_sync,wr,prog_sync,expired;
	wire wr_reset;
	wire start_timer;
	wire [1:0] interval;
	wire [6:0] output1;
	
	// Intantiate the synchronizer 
	fsm my_fsm(.clk(clock), .reset(reset), .sensor_sync(sensor_sync), .wr(wr), .prog_sync(prog_sync),
	               .expired(expired), .wr_reset(wr_reset), .interval(interval), .start_timer(start_timer),
	               .output1(output1)
	);
	
	// generate a clock
	initial begin
    clock = 0;
     forever begin
        #5  clock = ~clock;
     end
  	end
		
	// Stimulate inputs
	initial
	begin
		#5 reset = 1'b1; sensor_sync = 1'b0; wr = 1'b0; prog_sync = 1'b0;
		   expired = 1'b0; 
		#3 reset = 1'b0;
        #10 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);
		
		/*
		#5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b0; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);*/

        #5 reset = 1'b0; sensor_sync = 1'b1; wr = 1'b0; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);

        //GREEN_M1
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b0; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);

        /*
        //YELLOW_M
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b0; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);
        */

        //GREEN_M2
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b1; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);

        //YELLOW_M
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b1; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);

        //WALK
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b1; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);

        //YELLOW_S
        #5 reset = 1'b0; sensor_sync = 1'b0; wr = 1'b1; prog_sync = 1'b0;
		   expired = 1'b1; 
		#1 expired = 1'b0;
        #2 $display($time," start_timer= %b , interval= %b  output1=%b  wr_reset=%b",start_timer, interval, output1, wr_reset);


		
		/*#6 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		#1 $display($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
		
		*/
		#50 $finish;
		
		
	end
	/*
	initial
	begin
		$monitor($time," start_timer= %b , value= %b --- expired=%b",start_timer,value,expired);
	end*/
	
	
	
endmodule


