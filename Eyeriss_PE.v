//a single Procesing Element

`include "Eyeriss_PEController.v"
`include "Eyeriss_PE_Core.v"
module Eyeriss_PE (

input [15:0] map, filter,
input [15:0] Psum_from_GLB,Psum_from_PE,
input getdata_fil,getdata_map,getdata_psum,
input [7:0] id_in,
input CLK,clr,
input [25:0] conf_i,
input stall,
input psum_i_empty,psum_i_full, //empty from back, full from front
//input start,


output ready,
output [15:0] psum_out,
output psum_o_empty, psum_o_full //empty to front, full to back 


);
wire [15:0]PSUM_out_d;
wire [15:0] PSUM_out;
wire gather_data,psum_empty,fil_en,map_en,p_delay,rst_accm;
wire [1:0] mode;
wire [15:0] PSUM_carrier,inputPsum;
wire [3:0] filter_iterator; //TODO: change for bigger filter later
wire [3:0] map_iterator;
wire [3:0] psum_iterator;
wire [15:0] fifofmap,fifofilter;
wire [15:0] out;
wire regs_en;
wire p_read,p_write;
wire psum_o_empty_w;
wire psum_o_empty_w2;
wire psum_i_full2;
reg psum_o_empty_r;
assign psum_o_empty=psum_o_empty_w2;//_r
reg [15:0] PSUM_out_r;
wire [25:0] conf_bits;
	wire conf_enable; 
	wire conf_psum_input;  //0- psum from PE, 1-psum from GLB
    wire [3:0]mult_bit_select;
	wire [3:0] conf_maplen;
    wire [7:0] conf_filterlen;
	wire [7:0] conf_id;

    assign {
        conf_enable,
	    conf_psum_input,
		mult_bit_select,
	    conf_maplen,
        conf_filterlen,
	    conf_id
    } = conf_bits;
assign psum_out=PSUM_out_d;//_r

 Eyeriss_PE_Core PE_core(.ifmapin(fifofmap),.filter(fifofilter),.inputPsum(inputPsum),.filter_iterator(filter_iterator),
	.map_iterator(map_iterator),.regs_en(regs_en),.rst_accm(rst_accm),
	.psum_iterator(psum_iterator),.mode(mode),.CLK(CLK),.clr(~clr),.out(out),.done(done),.p_en_delay(p_en_delay),
.mult_bits(mult_bit_select),.read_done(read_done),.fil_en(fil_en),.map_en(map_en),.psum_en(psum_en)
);





FIFObuffer16b_16b mapFifo(
.Clk(CLK),
.dataIn(map),
.RD(map_en),
.WR(gather_data_map),
.EN(conf_enable),
.dataOut(fifofmap),
.Rst(~clr),.EMPTY(empty_map),
.FULL()
);

FIFObuffer16b_16b filterFifo(.Clk(CLK),.dataIn(filter),.RD(fil_en),.WR(gather_data_fil),.EN(conf_enable),.dataOut(fifofilter),.Rst(~clr),.EMPTY(empty_fil),.FULL()
);

FIFObuffer16b_16b PSUMFifoin(.Clk(CLK),.dataIn(PSUM_carrier),.RD(p_read),.WR((!psum_i_empty&&!conf_psum_input)||(conf_psum_input&&gather_data_psum)),.EN(conf_enable),.dataOut(inputPsum),.Rst(~clr),.EMPTY(psum_empty),.FULL(psum_o_full)
);																

FIFObuffer16b_16b PSUMFifoOut(.Clk(CLK),.dataIn(out),.RD(!psum_i_full),.WR(p_write),.EN(conf_enable),.dataOut(PSUM_out),.Rst(~clr),.EMPTY(psum_o_empty_w),.FULL()
); 

// configutration bits
	
	/*
always@(posedge CLK or negedge clr) begin
psum_o_empty_r<=clr ? 0:psum_o_empty_w;
PSUM_out_r<=PSUM_out;


end
*/
assign PSUM_carrier = conf_psum_input? Psum_from_GLB:Psum_from_PE;
assign gather_data_fil = ((conf_enable)&&(id_in==conf_id)&&getdata_fil);
assign gather_data_map = ((conf_enable)&&(id_in==conf_id)&&getdata_map);
assign gather_data_psum = ((conf_enable)&&(id_in==conf_id)&&getdata_psum);
Eyeriss_PEController controller(
   .clk(CLK),
   .resetN(clr),
	.conf_i(conf_i),

	 .empty(psum_empty),.empty_fil(empty_fil),.empty_map(empty_map),
 //  .start(start),
   .stall(stall),
   .outdelay_i(psum_o_empty_w),
   .outdelay_o(psum_o_empty_w2),
   .PSUM_i(PSUM_out),
   .PSUM_o(PSUM_out_d),
	
	.rst_accm(rst_accm),
     .ready(ready), //out ready sigbal for multicast and out controllers
     .read_next_p(p_read), //out getNext signal for PE when in ACCUM mode
	 .write_next_p(p_write),
	 .p_en_delay(p_en_delay),
   .modePE(mode), //modeControllersignal for PE 
   .conf_bits(conf_bits),.regs_en(regs_en),
	.fil_en(fil_en), .map_en(map_en),.psum_en(psum_en),.filter_iterator(filter_iterator),
	.map_iterator(map_iterator),
	.psum_iterator(psum_iterator)
);







endmodule