module SeqDet(in, clk, rst, sat);

input in, clk, rst;
output reg sat;

reg[3:0] state;

always@(posedge clk or posedge rst)
begin
     if (rst)
	  begin
         state = 4'b0000;
			sat = 0;
	  end
     else
          case (state)
               4'b0000:
					if(~in)
                  state = 4'b0001;
               4'b0001:
					if(in)
                  state = 4'b0010;
					else
						state = 4'b0001;
               4'b0010:
					if(in)
                  state = 4'b0011;
					else
						state = 4'b0001;
               4'b0011:
					if(in)
						state = 4'b0100;
					else
						state = 4'b0001;
					4'b0100:
					if(in)
					   state = 4'b0101;
					else
						state = 4'b0001;
					4'b0101:
					if(in)
					   state = 4'b0110;
					else
						state = 4'b0001;
					4'b0110:
					if(in)
						state = 4'b0111;
					else
						state = 4'b0001;
					4'b0111:
					if(~in)
					begin
						state = 4'b1000;
						sat = 1;
					end
					else
						state = 4'b0000;
					4'b1000:
					if(sat)
						state = 4'b1000;
					else 
					begin
						state = 4'b0000;
						sat = 0;
					end
          endcase
end

endmodule