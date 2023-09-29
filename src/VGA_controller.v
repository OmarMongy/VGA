module VGA_controller(
input clk, reset_n,
output video_on,
output reg hsync, vsync,
output [9:0] pixel_x, pixel_y
);
wire done_y, done_x;

localparam 
			  //horizontal parameters / 2.5 to fit the Cyclone IV memory
			  horizontal_display = 256,
			  horizontal_back_porch = 6,
			  horizontal_retrace = 38,
			  horizontal_front_porch = 19,
			  
			  //vertical parameters
			  
			  vertical_display = 480,
			  vertical_back_porch = 33,
			  vertical_retrace = 2,
			  vertical_front_porch = 10;
			  

horizontal_counter U1(
  .clk(clk),
  .reset_n(reset_n),
  .done_x(done_x),
  .pixel_x(pixel_x)
);
vertical_counter U2(
  .clk(clk),
  .reset_n(reset_n),
  .enable(done_x),
  .done_y(done_y),
  .pixel_y(pixel_y)    
);

always@(*)
begin
  if(pixel_x < (horizontal_display + horizontal_front_porch) || pixel_x > (horizontal_display + horizontal_front_porch + horizontal_retrace -1))
  hsync = 1'b1;
else
  hsync = 1'b0;
end

always@(*)
begin
  if(pixel_y < (vertical_display + vertical_front_porch) || pixel_y > (vertical_display + vertical_front_porch + vertical_retrace -1))
  vsync = 1'b1;
else
  vsync = 1'b0;
end  

assign video_on = (pixel_x < horizontal_display && pixel_y < vertical_display )? 1'b1 : 1'b0;

endmodule
