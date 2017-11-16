module CRC4(a, clk, CRC);
input clk;
input [7:0] a;
reg b;
output reg [3:0] CRC;
integer i;

always@(posedge clk)
begin
	CRC = 4'b0000;
	#200;
	for(i = 7; i >= 0; i = i - 1)
	begin
		b = a[i] ^ CRC[3];
		CRC[3] = CRC[2];
		CRC[2] = CRC[1];
		CRC[1] = CRC[0] ^ b;
		CRC[0] = b;
	end
	for(i = 4; i > 0; i = i - 1)
	begin
		b = 1'b0 ^ CRC[3];
		CRC[3] = CRC[2];
		CRC[2] = CRC[1];
		CRC[1] = CRC[0] ^ b;
		CRC[0] = b;
	end
end

endmodule
