

module synchronizer_tb;

	// Set up variables
	reg clock,reset,sensor,walk_request,reprogram;
	wire reset_sync,sensor_sync,wr_sync,prog_sync;
	
	// Intantiate the synchronizer 
	synchronizer my_sync(.clk(clock), .reset(reset), .sensor(sensor),.walk_request(walk_request), .reprogram(reprogram), .reset_sync(reset_sync),
	.sensor_sync(sensor_sync), .wr_sync(wr_sync), .prog_sync(prog_sync)
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
		#5 reset = 1'b0; sensor = 1'b0; walk_request = 1'b0; reprogram = 1'b0;

		#5 $display($time, "reset= %b, sensor=%b, walk_request= %b, reprogram= %b,--- reset_sync=%b, sensor_sync=%b, wr_sync=%b, prog_sync=%b",
		reset, sensor, walk_request, reprogram, reset_sync, sensor_sync, wr_sync,prog_sync);
		
		#10 reset = 1'b0; sensor = 1'b1; walk_request = 1'b0; reprogram = 1'b1;
		#10 $display("#",$time, "reset= %b, sensor=%b, walk_request= %b, reprogram= %b,--- reset_sync=%b, sensor_sync=%b, wr_sync=%b, prog_sync=%b",
		reset, sensor, walk_request, reprogram, reset_sync, sensor_sync, wr_sync,prog_sync);
        
        $finish;
	end
	/*
	initial
	begin
		$monitor($time, "reset= %b, sensor=%b, walk_request= %b, reprogram= %b,
		--- reset_sync=%b, sensor_sync=%b, wr_sync=%b, prog_sync=%b\n ",
		reset, sensor, walk_request, reprogram, reset_sync, sensor_sync, wr_sync,
		prog_sync);
	end*/
	
	
	
endmodule

