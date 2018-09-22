// Implementation of the Walk Register
// Inputs: wr_sync, wr_reset
// Outputs: wr

module walk_register(clk, wr_sync, wr_reset, wr);

input clk,wr_sync,wr_reset;
output reg wr;

always @(posedge clk)
begin

    if(wr_sync== 1'b1)
        wr = wr_sync;

    else
        wr = 1'b0;

end

always @(posedge wr_reset)
begin
    wr = 1'b0;
end


endmodule
