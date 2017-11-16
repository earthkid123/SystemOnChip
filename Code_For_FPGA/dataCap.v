module dataCap(in, clk, prevSat, return, captured, data);

input in, clk, prevSat;
output reg return, captured;
output reg [7:0] data;
integer count, i;

		
always@(posedge clk)
begin
	if(~prevSat)
	begin
		count = 0;
	end
	if(prevSat)
	begin
		if(count < 8)
			data[count] = in;
		count = count + 1;
	end		
end
	
always@(negedge clk)
begin
	if(count == 7)
	begin
		return = 1;
		captured = 1;
	end
	else
	begin
		return = 0;
		captured = 0;
	end
end

endmodule
	