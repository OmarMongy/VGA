module horizontal_counter(
input clk, reset_n,
output [9:0] pixel_x,
output done_x 
);
reg [9:0] pixel_reg, pixel_next;

always@(posedge clk, negedge reset_n)
begin
  if(~reset_n)
   pixel_reg <= 10'b0;
  else
   pixel_reg <= pixel_next; 
end

always@(*)
begin
  pixel_next = done_x? 10'b0 : pixel_reg + 1;  
end

assign pixel_x = pixel_reg;
assign done_x = pixel_reg == 10'd320;
endmodule
