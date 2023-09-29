module memory_rom
#(parameter width = 3, depth = 16)
(
input clk,
input rd_ena,
input [depth-1:0] addr,
output reg [width-1:0] data
);
reg [width-1:0] rom [0:2**depth-1];

initial
$readmemb("bird_img.txt", rom); 
		  
always@(posedge clk)
begin
	if(rd_ena)
	data = rom[addr];
end
endmodule
