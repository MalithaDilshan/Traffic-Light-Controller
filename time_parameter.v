//Implementation of the time p

module time_parameter(clk,reset,time_parameter_selector,time_value,prog_sync,interval_code,value);

input clk,reset,prog_sync;
input [1:0] time_parameter_selector;
input [3:0] time_value;
input [1:0] interval_code;

output reg [3:0] value;

// parameters for accessing the values using the following codes
parameter code_t_base = 2'b00;
parameter code_t_yel = 2'b10;
parameter code_t_ext = 2'b01;
parameter code_t_base_plus_ext = 2'b11;


// store the time values
reg [3:0] time_base = 4'b0110;
reg [3:0] time_yel = 4'b0010;
reg [3:0] time_ext = 4'b0011;
//reg [3:0] time_base_plus_ext = 4'b1001;

// register for store the time value and initally store the default values
reg [3:0] temp_base = 4'b0110;
reg [3:0] temp_yel = 4'b0010;
reg [3:0] temp_ext = 4'b0011;


always @(posedge reset)
begin
    time_base = 4'b0110;
    time_yel = 4'b0010;
    time_ext = 4'b0011;

end


always @(posedge clk)
begin
    
// assuming the all three types of time can be updated one by one manually
// using the switche and buttons

    if(time_parameter_selector == 2'b00)
        temp_base = time_value;

    if(time_parameter_selector == 2'b10)
        temp_yel = time_value;

    if(time_parameter_selector == 2'b01)
        temp_ext = time_value;
    

    //$display("**** %b",temp_base);
end


always @(posedge clk)
begin
    if((prog_sync) & (reset == 1'b0))
    begin

        time_base = temp_base;
        time_yel = temp_yel;
        time_ext = temp_ext;

    end
    
    case(interval_code)
       
        code_t_base:begin
            value = time_base;
            //$display("%b",value);
            end
        code_t_yel:begin
            value = time_yel;
            //$display($time);
            end
        code_t_ext:begin
            value = time_ext;
            //$display("%b",value);
            end

    endcase
    //$display("**** %b",value);

end

endmodule
