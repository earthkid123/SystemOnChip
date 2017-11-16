module SOCFinal(in, clk, rst, SeqSat, dataSat, captured, CRCOut); 

input in, clk, rst;
wire call_for_rst, done, captured;
wire [7:0] data;
output wire SeqSat, dataSat, captured;
output wire [3:0] CRCOut;

assign reset = ~rst | call_for_rst | done;

SeqDet sd(.in(in), .clk(clk), .rst(reset), .sat(SeqSat));
dataAddr ad(.in(in), .clk(clk), .rst(reset), .prev_sat(SeqSat), .sat(dataSat), .return(call_for_rst));
dataCap	dc(.in(in), .clk(clk), .prevSat(dataSat), .return(done), .data(data), .captured(captured));
CRC4 CRC(.a(data), .clk(done), .CRC(CRCOut));

endmodule
