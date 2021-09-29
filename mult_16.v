
module mult_16(
	CLK,
   a,b,
  c,bits   
  );
  input CLK;
  input [15:0] a,b;
  input [3:0] bits;
  output [15:0] c;
	wire[31:0] mult =b*a;
	reg [15:0] cc;
	assign c=cc;
	
	always@(posedge CLK) begin
		case (bits)
		4'd0: cc= mult[15:0];
		4'd1: cc= mult[16:1];
		4'd2: cc= mult[17:2];
		4'd3: cc= mult[18:3];
		4'd4: cc= mult[19:4];
		4'd5: cc= mult[20:5];
		4'd6: cc= mult[21:6];
		4'd7: cc= mult[22:7];
		4'd8: cc= mult[23:8];
		4'd9: cc= mult[24:9];
		4'd10: cc= mult[25:10];
		4'd11: cc= mult[26:11];
		4'd12: cc= mult[27:12];
		4'd13: cc= mult[28:13];
		4'd14: cc= mult[29:14];
		4'd15: cc= mult[30:15];
		
		
	
		endcase
	end

endmodule

module adder_16(
   a,b,
  c 
  );
  input [15:0] a,b;
  output [15:0] c;

	assign c = b + a;

endmodule
