module VGA_top(
input clock, reset_n,
output [2:0] rgb,
output h_sync, v_sync
);

wire video_on;

wire [9:0] pixel_x, pixel_y;
wire done_y, done_x;
wire [15:0] address = {pixel_y[8:1],pixel_x[7:0]};

PLL_clk10MHz U0(
.inclk0(clock),
.c0(clk)
);

VGA_controller U1(
.clk(clk),
.reset_n(reset_n),
.video_on(video_on),
.pixel_x(pixel_x),
.pixel_y(pixel_y),
.hsync(h_sync),
.vsync(v_sync)
);

memory_rom U2(
.clk(clk),
.rd_ena(video_on),
.addr(address),
.data(rgb)
);

endmodule
