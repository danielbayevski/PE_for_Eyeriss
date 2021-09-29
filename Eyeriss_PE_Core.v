

`include "Sram.v"
`include "mult_16.v"







module Eyeriss_PE_Core(
input [15:0] ifmapin,filter,
input [15:0] inputPsum,
input [1:0] mode, // 0-idle 1-get data, 2-multiply, 3-output,
input CLK,clr,map_en,fil_en,psum_en,p_en_delay,regs_en,rst_accm,
input [3:0] mult_bits,
input [3:0] filter_iterator,
input [3:0] map_iterator,
input [3:0] psum_iterator,
output [15:0] out,
output done,

output read_done
);

parameter IDLE=2'b00, DATA=2'b01, MULT=2'b10, ACCU=2'b11; // modes;


reg addrin; // mux selectors
reg bufen; //enable buffers of map,filter and multiplication, active in mult
reg PSUMBUFbufen; //enable buffer of PSUM, active in mult
reg filterW;
reg PSUMIteratoren; //enable PSUM iterator and 
reg doneout; //signal PE is done with task
reg [3:0]map_iterator_d;



//buffers
//   b.addr, a.map, a.filter,a.PSUM, a.PSUMBUF, a.multiplier, a.multiplier buf,     a. - after, b. - before


//wires
wire [15:0] filterWire,mapWire,addrWire,outWire,PsumoutWire,buf2Wire,PsumbufWire,multWire;
wire [15:0] mapwire;
wire [15:0] filterwire;
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

assign addrWire = addrin_d2? inputPsum:multreg;
//assign outWire = Psumbuffer2+addrWire;


adder_16 adder(.a(Psumbuffer2),.b(addrWire),.c(outWire));
mult_16 mult(.a(filterreg),.b(mapreg),.c(multWire),.bits(mult_bits),.CLK(CLK));


Sram PSUM(.in(outWire),.out(PsumoutWire),.selector_i(psum_iterator_delay2),.selector_o(psum_iterator),.CLK(CLK),.clr_(clr),.en(p_en_delay)); //PSUM reg
Sram ifmapReg(.in(ifmapin),.out(mapWire),.selector_i(map_iterator),.selector_o(map_iterator),.CLK(CLK),.clr_(clr),.en(map_en)); // map reg
Sram filterReg(.in(filter),.out(filterWire),.selector_i(filter_iterator),.selector_o(filter_iterator),.CLK(CLK),.clr_(clr),.en(fil_en)); // filter reg





initial begin 
reset_accm =0;
psum_iterator_delay1=0;
end

/*
change into this when running design vision, because it doesnt work otherwise
always@(posedge CLK or posedge clr) begin
	
	
	if (clr)begin
*/

always@(posedge CLK or posedge clr) begin
	
	
	if (clr)begin
		mapreg<=0;
		filterreg<=0;
		multreg<=0;
		Psumbuffer1<= 0;
		Psumbuffer2<= 0;
		reset_accm_d<=0;
	end
	
	else begin
		bufen_d<=bufen;
		bufen_d2<=bufen_d;
		mode_d<=mode;
		mapreg<=regs_en? mapWire:0;
		filterreg<=regs_en? (zero_buffer[map_iterator]? 0:filterWire):0;
		multreg<=multWire;//bufen_d2? multWire:0; TODO why is not like that?
		Psumbuffer1<= rst_accm? PsumoutWire:0;
		Psumbuffer2<= reset_accm_d? 0:Psumbuffer1;
		psum_iterator_delay1<= psum_iterator;
		psum_iterator_delay2<= psum_iterator_delay1;
		map_iterator_d<=map_iterator;
		addrin_d<=addrin;
		addrin_d2<=addrin_d;
		reset_accm_d<=reset_accm;
	end
	

end


//reg [3:0] psum_buffed_iterator1;



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

	
	 PSUMIteratoren<=0;
	 bufen<=0;
	doneout<=0;
  reset_accm<=1;
		case (mode)
			default: begin 

	 addrin<=0;
	 PSUMIteratoren<=0;
	 bufen<=0;
	 
	resetval<=0;
	
			end
		
			DATA:begin 
				read_don<=1;
				
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
				bufen<=0;
				PSUMBUFbufen<=1;
				
				
			end
		endcase  
	end 



endmodule 


