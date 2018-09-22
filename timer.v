// Implementation of the timer
// timer will act as the exact clock 


module timer(clk1,value,start_timer,expired);

input clk1,start_timer;
input [3:0] value;

output reg expired;

reg temp;
integer count;

initial
	count = 0;

always @(negedge start_timer)
begin
	temp = 1'b1;
end

always @(posedge clk1)
begin
    
	if((count < value) &(temp == 1'b1))
	begin
		//$display("count= %d ",count);
		count = count + 1;
		expired  = 1'b0;
	end

	if((count == value) &(temp == 1'b1))
	begin
		expired = 1'b1;
		count = 1'b0;
		temp = 1'b0;
	end
	
end

always @(negedge clk1)
begin
  if(expired == 1'b1)
    expired = 1'b0;
end

endmodule
