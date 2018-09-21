
module top_module(clock,reset,sensor,walk_request,reprogram,time_parameter_selector,time_value,LEDs);

input reset,sensor,walk_request,reprogram;
input clock;
input [1:0] time_parameter_selector;
input [3:0] time_value;

output[6:0] LEDs;

wire reset_sync, sensor_sync, wr_sync, prog_sync;

wire wr;
//
wire [1:0] interval_code;
wire [3:0] value;

wire new_clk;

wire start_timer;
wire expired;

wire wr_reset;

// instantiation of the synchronizer
synchronizer my_synchronizer(.clk(clock), .reset(reset), .sensor(sensor), .walk_request(walk_request), .reprogram(reprogram),
                             .reset_sync(reset_sync), .sensor_sync(sensor_sync), .wr_sync(wr_sync), 
                             .prog_sync(prog_sync)
                             );

// instantiation of the walk register
walk_register my_walk_register(.clk(clock), .wr_sync(wr_sync), .wr_reset(wr_reset), .wr(wr)

                              );

// instantiation of the time parameters
time_parameter my_time_parameter(.clk(clock), .reset(reset_sync), .time_parameter_selector(time_parameter_selector),
                                 .time_value(time_value), .prog_sync(prog_sync), .interval_code(interval_code),
                                 .value(value)
                                 );
                                 
// instantiation of the divider
divider #(10)my_divider(.clk(clock), .reset(reset_sync), .new_clk(new_clk)  // user can change this #(...) any time acording to the clock frequency
                       );

// instantiation of the timer


timer my_timer(.clk1(new_clk), .value(value), .start_timer(start_timer), .expired(expired)
               );

// instantiation of the finite state machine
fsm my_fsm(.clk(clock), .reset(reset_sync), .sensor_sync(sensor_sync), .wr(wr), .prog_sync(prog_sync),
           .expired(expired), .wr_reset(wr_reset), .interval(interval_code), .start_timer(start_timer),
           .output1(LEDs)
           );

endmodule
