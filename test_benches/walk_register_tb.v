// Implementation of the testbench for the walk_register


`timescale 1ns / 1ps

module walk_register_tb;

	// Set up variables
	reg clock, wr_sync, wr_reset;
	wire wr;
	
	// Intantiate the synchronizer 
	walk_register my_walk_reg(.clk(clock), .wr_sync(wr_sync), .wr_reset(wr_reset),.wr(wr));
	
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
		#10 wr_sync = 1'b0; wr_reset = 1'b0;
		#1  $display($time, "wr_sync= %b, wr_reset= %b --- wr= %b",wr_sync,wr_reset,wr);
		
		#4 wr_sync = 1'b1; wr_reset = 1'b0;
        #1  $display($time, "wr_sync= %b, wr_reset= %b --- wr= %b", wr_sync,wr_reset,wr);

        #4 wr_sync = 1'b0; wr_reset = 1'b1;
		#1  $display($time, "wr_sync= %b, wr_reset= %b --- wr= %b",wr_sync,wr_reset,wr);
	
    #100 $finish;
    
    end
	
	
	
endmodule

