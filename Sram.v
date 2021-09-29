
module Sram (in,selector_i,out,selector_o,CLK,clr_,en);

input [15:0]in;
input [3:0] selector_i,selector_o;
output[15:0]out;
input CLK,clr_,en;

reg [1:0] register [15:0]; //[3:0]<- change this 3 to 1,31,63,127
assign out=register[selector_o];

initial begin

register[0]	<=0;
register[1]<=0;
register[2]<=0;
register[3]<=0;
 register[4]<=0;
 register[5]<=0;
 register[6]<=0;
 register[7]<=0;
 register[8]<=0;
 register[9]<=0;
 register[10]<=0;
 register[11]<=0;
 register[12]<=0;
 register[13]<=0;
 register[14]<=0;
 register[15]<=0;

end


always@(posedge CLK or posedge clr_) begin
	if(clr_)begin
	register[0]	<=0;
register[1]<=0;
register[2]<=0;
register[3]<=0;
register[4]<=0;
register[5]<=0;
register[6]<=0;
register[7]<=0;
register[8]<=0;
register[9]<=0;
register[10]<=0;
register[11]<=0;
register[12]<=0;
register[13]<=0;
register[14]<=0;
register[15]<=0;

	end
	else begin
		if(en)
			register[selector_i]<=in;
	end
end


endmodule