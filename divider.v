// Implementation of the divider
// give the clock output which has 1 Hz clock rate
// It can be checked the functionality using the vcs clock wave


module divider(reset,clk, new_clk);

input clk,reset;
output reg new_clk;
parameter clk_rate = 5; // user can initialize the clock rate when instantiate the module 

reg [31:0]counter = 32'd1;

initial 
    new_clk = 1'b0;   //  initialize the new clock

always @(posedge clk)

begin
    if(reset)begin
        counter = 32'd1;
        new_clk = 1'b0;
    end

    else if(counter == clk_rate)
    begin
        new_clk =  1'b1;
        counter = 32'd1;
    end
        
    else
        counter = counter+1;

end

always @(negedge clk)
    new_clk = 1'b0;

endmodule
