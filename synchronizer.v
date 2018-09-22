
module synchronizer(clk,reset,sensor,walk_request,reprogram,reset_sync,sensor_sync,wr_sync,prog_sync);

input clk,reset,sensor,walk_request,reprogram;
output reg reset_sync,sensor_sync,wr_sync,prog_sync;

always @(negedge clk)
begin

	reset_sync = reset;
	sensor_sync = sensor;
	wr_sync = walk_request;
	prog_sync = reprogram;
	
	//$display("***%b",wr_sync);

end


endmodule
