module dataAddr(in, clk, rst, prev_sat, sat, return);

input in, clk, rst, prev_sat;
output reg sat, return;
integer count;

reg[3:0] state;

always@(posedge clk or posedge rst)
begin
     if (rst)
	  begin
         state = 4'b0000;
			sat = 0;
			count = 0;
			return = 0;
	  end
     else
	  if(prev_sat)
	  begin
			 count = count + 1;
			 case (state)
               4'b0000:
					if(in)		//multicast
						state = 4'b1111;
					else
                  state = 4'b0001;
               4'b0001:
					if(~in)
                  state = 4'b0010;
               4'b0010:
					if(~in)
                  state = 4'b0011;
               4'b0011:
					if(in)
						state = 4'b0100;
					4'b0100:
					if(in)
					   state = 4'b0101;
					4'b0101:
					if(in)
					   state = 4'b0110;
					4'b0110:
					if(in)
						state = 4'b0111;
					4'b0111:
					if(~in)
					begin
						state = 4'b1000;
						sat = 1;
					end
					4'b1000:
					if(sat)
						state = 4'b1000;
					else 
					begin
						state = 4'b0000;
						sat = 0;
					end
					4'b1111:
					if(count == 8)
					begin
						state = 4'b1000;
						sat = 1;
					end					
          endcase
			if(count == 8)
				if(~sat)
					return = 1;
		end		
end

endmodule
