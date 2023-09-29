module vertical_counter(
input clk, reset_n, enable,
output [9:0] pixel_y,
output done_y
);
reg [9:0] pixel_reg, pixel_next;

always@(posedge clk, negedge reset_n)
begin
  if(~reset_n)
   pixel_reg <= 10'b0;
  else if(enable)
   pixel_reg <= pixel_next;
  else
    pixel_reg <= pixel_reg; 
end

always@(*)
begin
  pixel_next = done_y? 10'b0 : pixel_reg + 1;  
end

assign pixel_y = pixel_reg;
assign done_y = pixel_reg == 10'd524;
endmodule
