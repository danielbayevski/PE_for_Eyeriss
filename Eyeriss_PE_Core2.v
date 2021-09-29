


`include "Sram.v"



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





module Eyeriss_PE_Core2(
input [15:0] ifmapin,filter,filter2,
input [15:0] inputPsum1,inputPsum2,
input [1:0] mode, // 0-idle 1-get data, 2-multiply, 3-output,
input CLK,clr,map_en,fil_en,psum_en,p_en_delay,regs_en,rst_accm,
input [3:0] mult_bits,
input [3:0] filter_iterator,
input [3:0] map_iterator,
input [3:0] psum_iterator,
output [15:0] out,out2,
output done,

output read_done
);

parameter IDLE=2'b00, DATA=2'b01, MULT=2'b10, ACCU=2'b11; // modes;


reg addrin; // mux selectors
reg bufen; //enable buffers of map,filter and multiplication, active in mult
reg PSUMBUFbufen; //enable buffer of PSUM, active in mult
reg outen,filterW;
reg PSUMIteratoren; //enable PSUM iterator and 
reg doneout; //signal PE is done with task
reg [3:0]map_iterator_d;



//buffers
//   b.addr, a.map, a.filter,a.PSUM, a.PSUMBUF, a.multiplier, a.multiplier buf,     a. - after, b. - before


//wires
wire [15:0] filterWire,mapWire,addrWire,outWire,PsumoutWire,buf2Wire,PsumbufWire,multWire;
wire [15:0] filterWire2,addrWire2,outWire2,PsumoutWire2,buf2Wire2,PsumbufWire2,multWire2;
wire clr_;
assign clr_=!clr;

//registors
reg addrin_d,addrin_d2;
reg bufen_d,bufen_d2; //TODO what im doing is really ill advised, be carefull
reg [11:0]zero_buffer;
reg [3:0] resetval;
reg read_don;
reg reset_accm,reset_accm_d;
reg [3:0] psum_iterator_delay2;
reg [3:0]psum_iterator_delay1;
reg [1:0] mode_d;
//assigns
assign out=outWire;
assign done= doneout;
assign read_done=read_don;



reg [15:0] mapreg,filterreg,multreg,Psumbuffer1,Psumbuffer2;
reg [15:0] filterreg2,multreg2,Psumbuffer12,Psumbuffer22;

assign addrWire = addrin_d2? inputPsum1:multreg;
assign addrWire2 = addrin_d2? inputPsum2:multreg2;
assign outWire = Psumbuffer2+addrWire;
assign outWire2 = Psumbuffer22+addrWire2;


mult_16 mult1(.a(filterreg),.b(mapreg),.c(multWire),.bits(mult_bits),.CLK(CLK));
mult_16 mult2(.a(filterreg2),.b(mapreg),.c(multWire2),.bits(mult_bits),.CLK(CLK));

Sram PSUM(.in(outWire),.out(PsumoutWire),.selector_i(psum_iterator_delay2),.selector_o(psum_iterator),.CLK(CLK),.clr_(clr_),.en(p_en_delay)); //PSUM reg
Sram ifmapReg(.in(ifmapin),.out(mapWire),.selector_i(map_iterator),.selector_o(map_iterator),.CLK(CLK),.clr_(clr_),.en(map_en)); // map reg
Sram filterReg(.in(filter),.out(filterWire),.selector_i(filter_iterator),.selector_o(filter_iterator),.CLK(CLK),.clr_(clr_),.en(fil_en)); // filter reg

Sram PSUM2(.in(outWire2),.out(PsumoutWire2),.selector_i(psum_iterator_delay2),.selector_o(psum_iterator),.CLK(CLK),.clr_(clr_),.en(p_en_delay)); //PSUM reg
//Sram filterReg2(.in(filter2),.out(filterWire2),.selector_i(filter_iterator),.selector_o(filter_iterator),.CLK(CLK),.clr_(clr_),.en(fil_en)); // filter reg





initial begin 
reset_accm =0;
psum_iterator_delay1=0;
end

always@(posedge CLK or posedge clr_) begin
	if (clr_)begin
		mapreg<=0;
		filterreg<=0;
		multreg<=0;
		filterreg2<=0;
		multreg2<=0;
		
		Psumbuffer1<= 0;
		Psumbuffer2<= 0;
		Psumbuffer12<= 0;
		Psumbuffer22<= 0;
		reset_accm_d<=0;
	end
	
	else begin
		bufen_d<=bufen;
		bufen_d2<=bufen_d;
		mode_d<=mode;
		mapreg<=regs_en? mapWire:0;
		filterreg<=regs_en? (zero_buffer[map_iterator]? 0:filterWire):0;
		filterreg2<=regs_en? (zero_buffer[map_iterator]? 0:filterWire2):0;
		multreg<=multWire;
		multreg2<=multWire2;
		Psumbuffer1<= rst_accm? PsumoutWire:0;
		Psumbuffer2<= reset_accm_d? 0:Psumbuffer1;
		Psumbuffer12<= rst_accm? PsumoutWire2:0;
		Psumbuffer22<= reset_accm_d? 0:Psumbuffer12;
		psum_iterator_delay1<= psum_iterator;
		psum_iterator_delay2<= psum_iterator_delay1;
		map_iterator_d<=map_iterator;
		addrin_d<=addrin;
		addrin_d2<=addrin_d;
		reset_accm_d<=reset_accm;
	end
	

end


//zerobuffer
always@(posedge CLK) begin

	if (mode==IDLE)begin
	zero_buffer[11:0]<=12'b0;
	end
	
	if((ifmapin==0) &&(mode_d==DATA))
		zero_buffer[map_iterator_d]<=1;
		
		
	if((mode==MULT)&&(zero_buffer[map_iterator]==1))
		filterW<=1;
		
	else
		filterW<=0;
	
	
end






always@*
	begin
	read_don<=0;

	 addrin<=0;
	 PSUMIteratoren<=0;
	 bufen<=0;
	 outen<=0;
	PSUMBUFbufen<=0;
	doneout<=0;
  reset_accm<=1;
		case (mode)
			default: begin 

	 addrin<=0;
	 PSUMIteratoren<=0;
	 bufen<=0;
	 outen<=0;
	resetval<=0;
	PSUMBUFbufen<=0;
			end
		
			DATA:begin 
				read_don<=1;
				outen<=0;
				bufen<=0;
				addrin<=0;
				PSUMIteratoren<=0;
				reset_accm<=0;
				end
			
			
			
			MULT: begin
					reset_accm<=0;
					addrin<=0;
					bufen<=1;
				end			
		
			
			ACCU:begin 
			reset_accm<=0;
				addrin<=1;
				outen<=1;
				bufen<=0;
				PSUMBUFbufen<=1;
				
				
			end
		endcase  
	end 



endmodule 


