 // a line of PE units
 
 
`include "Eyeriss_PE.v"
module Eyeriss_Row_PE //#(parameter ARRAY_ROW_NUM=2)
(

input [58:0] GLB_BUS,
input CLK,clr,
input read,
input  [78:0]conf,//input  [25:0]conf [ARRAY_ROW_NUM-1:0],
input stall,
output ready_out,
output [15:0] psum_out,
output ready_for_input, output_ready //empty to front, full to back 



);


parameter ARRAY_ROW_NUM=3;
wire getdata_fil,getdata_map,getdata_psum;
wire [15:0] map, filter;
wire [7:0] id;
wire [15:0] psum_from_PE [ARRAY_ROW_NUM:0];
wire [15:0] Psum_from_GLB;
wire psum_full[ARRAY_ROW_NUM:0] , psum_empty[ARRAY_ROW_NUM:0];

wire ready[ARRAY_ROW_NUM-1:0];


assign psum_from_PE[0]=0;
assign psum_full [0]=0;
assign psum_empty [0]=0;
assign ready_for_input=psum_full[1];
assign output_ready=psum_empty[ARRAY_ROW_NUM];
assign psum_out=psum_from_PE[ARRAY_ROW_NUM];
assign psum_full[ARRAY_ROW_NUM]=read;
assign ready_out=ready[ARRAY_ROW_NUM-1];

assign {                          //GBL BUS 		 59 bits
	getdata_fil,           //gather filter to fifo   1  bit
	getdata_map,           //gather map  to fifo     1  bit
	getdata_psum,          //gather GLB PSUM to fifo 1  bit
	map,	        	   //map data to fifo        16 bits
	filter,	        	   //map filter to fifo      16 bits
	id, 	        	   	   //current PE_unit ID      8  bits
	Psum_from_GLB	 	   //PSUM data to fifo       16 bits
    } = GLB_BUS;




genvar i;
	generate
		for(i = 0; i < ARRAY_ROW_NUM; i=i+1) begin: PE_unit
		
			Eyeriss_PE pop(

			 .map(map),. filter(filter),
                        .Psum_from_GLB(Psum_from_GLB),.Psum_from_PE(psum_from_PE[i]),
                        .getdata_fil(getdata_fil),.getdata_map(getdata_map),.getdata_psum(getdata_psum),
                        .id_in(id),.CLK(CLK),.clr(~clr),
                        .conf_i(conf[(i+1)*26-1:i*26]),.stall(stall),
                        .psum_i_empty(psum_empty[i]),.psum_i_full(psum_full[i+1]),
                        .ready(ready[i]), //is it neccecery? probably not
                        .psum_out(psum_from_PE[i+1]),
                        .psum_o_empty(psum_empty[i+1]),. psum_o_full(psum_full[i])
						



);

		end
	endgenerate













endmodule