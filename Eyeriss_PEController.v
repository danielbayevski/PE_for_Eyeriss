
module Eyeriss_PEController(
		input clk,
		input   resetN,
		input [25:0] conf_i,
		input   empty,stall,empty_fil,empty_map,
		//input start,
		input outdelay_i,
		input [15:0] PSUM_i,
		output   		ready, //out ready sigbal for multicast and out controllers
		output   		read_next_p,write_next_p,p_en_delay,rst_accm,//out getNext signal for PE when in ACCUM mode
		output [1:0] modePE ,//modeControllersignal for PE
		output [25:0] conf_bits, //this is this way just because alon wanted it to be, it serves no real purpose...
		output fil_en, map_en,psum_en, regs_en,outdelay_o,
		output [15:0] PSUM_o,
		output [3:0] filter_iterator,
		output [3:0] map_iterator,
		output [3:0] psum_iterator
);


parameter IDLE=2'b00, DATA=2'b01, MULT=2'b10, ACCU=2'b11; // modes;

reg [1:0] cur_st , nxt_st;


wire filbiger;
wire [3:0] diff,diff_normlized;
 reg done_d, done_mult;
reg ready_r,p_write_delay2,outdelay_i_d,outdelay_i_dd; 
reg [1:0] modePE_r ; 
reg	get_next_PE_r,rst_accm_r;
reg p_delay1,p_delay2,m_delay1,m_delay2;
reg [25:0] conf_i_r;
reg [1:0] stalstate;
reg stal_d;
reg p_delay2_alt;
reg [3:0] map_iterator_r,psum_iterator_r;
reg [3:0] filter_iterator_r;
reg fil_en_r,map_en_r,psum_en_r,m_done;
reg [7:0] restval,iterator;
reg regs_en_r;
reg p_en_delay2,p_en_delay1;
reg start_d;
reg [3:0] psum_delay1,psum_delay2;
wire [1:0] stime,btime;
wire [1:0] minimal;
reg [1:0] minimal_delay;
reg [1:0] stopper;
reg again_accu,again_accu_,again_accu_d;
reg p_write_delay,empty_map_b,empty_fil_b;
wire start; 
assign start = ((empty_fil==0)&&(empty_map==0));
assign rst_accm=rst_accm_r;
assign filter_iterator=filter_iterator_r;
assign map_iterator=map_iterator_r;
assign psum_iterator=psum_iterator_r; 
assign fil_en = fil_en_r;// ||(start&&!start_d);
assign map_en = map_en_r;//||(start&&!start_d);
reg RDdelay_o_d=1;
assign RDdelay_o=RDdelay_o_d||cur_st==ACCU;
assign psum_en=psum_en_r;
reg [15:0]PSUM_o_d=0;
assign PSUM_o=PSUM_o_d;
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
    } = conf_i_r;
wire [4:0]maplen_w = conf_maplen>0? conf_maplen:16; 

assign filbiger = (maplen_w<=conf_filterlen)? 1:0;

assign diff = filbiger? conf_filterlen-maplen_w:maplen_w-conf_filterlen;
assign p_delay=p_delay2;
assign p_en_delay=(p_en_delay2&&(m_delay2==0));//||(rst_accm_r==0);
assign ready=ready_r;
assign modePE=modePE_r;
assign read_next_p=p_delay1;//get_next_PE_r||start;
assign write_next_p=p_write_delay;
assign conf_bits=conf_i_r;
assign regs_en= regs_en_r;

assign minimal = (maplen_w<3)||(conf_filterlen<3)? (maplen_w==1)||(conf_filterlen==1)? 1:2:0;
assign stime = (minimal>0)||(diff<3)? ((minimal==2)||(diff<2)? 2:3):0;
assign btime= ((minimal>0)||((diff<3)&&(diff>=0)))?1:0;
assign diff_normlized = (diff==0)? 0:(diff-1);
assign p_write_d=p_write_delay;
assign outdelay_o=outdelay_i_dd;


initial begin
stopper =btime;
again_accu=0;
m_done=0;
end

always @(posedge clk or negedge resetN) // State machine logic ////
   begin
	   
   if ( !resetN ) begin // Asynchronic reset
	map_iterator_r<=0;
	filter_iterator_r<=0;
	psum_iterator_r<=0;
		cur_st <= IDLE;
		done_mult <= 1'b0;	
		restval<=1'b1;
		iterator <=0;
		minimal_delay<=0;
	ready_r<=0;
	again_accu_<=0;
stopper <=btime;
	end // asynch
	else if( stall) begin
	cur_st<=IDLE;	
	
	end
	else if(conf_enable)  begin	
	
		if (cur_st == IDLE) begin
		minimal_delay<=(minimal>0)?2:0;
		m_done<=0;
		end
	
	
	
	
		 if (cur_st == DATA) begin 
		 minimal_delay<=minimal_delay==0? 0:minimal_delay-1;
		 m_done<=0;
		 stopper <=btime;
		ready_r<=0;
		restval<=1'b1;
		map_iterator_r <= (nxt_st==MULT)? 0:((map_iterator_r+1>=(maplen_w))||empty_map_b? map_iterator_r:map_iterator_r+1);
		filter_iterator_r <= (nxt_st==MULT)? 0:((filter_iterator_r+1>=(conf_filterlen))||empty_fil_b? filter_iterator_r:filter_iterator_r+1);
		psum_iterator_r <= (nxt_st==MULT)? 0:((psum_iterator_r>(diff_normlized))? psum_iterator_r:psum_iterator_r+1);
	end

// if differance is more than 2 - proceed normally, stop every diff CLK's so the PSUM's allign

		else if (cur_st == MULT) begin
		stopper<= stopper==stime? btime:stopper+1;	//if the differance is too small, we have to skip CLKS, diff =2 - skip every second CLK, diff = 1 - skip every CLK, diff=0 - skip two CLKS every CLK
		
			if (filbiger) begin
				map_iterator_r<=(nxt_st==ACCU)? 0:stopper<2? iterator>diff_normlized? map_iterator_r+1:map_iterator_r : map_iterator_r;
				filter_iterator_r<=(nxt_st==ACCU)? 0:(stopper<2? (iterator>diff_normlized? restval:filter_iterator_r+1) : filter_iterator_r);
				psum_iterator_r<= (nxt_st==ACCU)?0 : stopper<2 ?iterator >diff_normlized? 0:iterator+1 :iterator;; //stopper<2?  filter_iterator_r>diff? psum_iterator_r+1:psum_iterator_r :psum_iterator_r;
				restval<= (nxt_st==ACCU)?0 : stopper<2? iterator>diff_normlized? restval+1: restval : restval;
				iterator<= (nxt_st==ACCU)? 0:stopper<2? (iterator >diff_normlized? 0:iterator+1) :iterator;  //stopper<2 ?iterator >diff-1? 0:iterator+1 :iterator;
			end
			else begin
			
				filter_iterator_r<=(nxt_st==ACCU)? 0:stopper<2? iterator>diff_normlized? filter_iterator_r+1:filter_iterator_r : filter_iterator_r;
				map_iterator_r<=(nxt_st==ACCU)? 0:(stopper<2? (iterator>diff_normlized? restval:map_iterator_r+1) : map_iterator_r);
				psum_iterator_r<= (nxt_st==ACCU)?0 : stopper<2 ?iterator >diff_normlized? 0:iterator+1 :iterator;; //stopper<2?  map_iterator_r>diff? psum_iterator_r+1:psum_iterator_r :psum_iterator_r;
				restval<= (nxt_st==ACCU)?0 : stopper<2? iterator>diff_normlized? restval+1: restval : restval;
				iterator<= (nxt_st==ACCU)? 0:stopper<2? (iterator >diff_normlized? 0:iterator+1) :iterator;  //stopper<2 ?iterator >diff-1? 0:iterator+1 :iterator;
			
			
				
		
			end

	m_done<=m_done||((map_iterator_r>=maplen_w-1) && (filter_iterator_r>=conf_filterlen-1 ) );
	end
	
	else if (cur_st==ACCU) begin
	restval<=1;
		psum_iterator_r<= (nxt_st==IDLE)||psum_iterator_r==(diff)? 0:psum_iterator_r+1;
		ready_r<=psum_iterator_r==(diff_normlized);

	end
		
		
		cur_st <= nxt_st; // Update current state
		p_delay1<=(get_next_PE_r&&nxt_st==ACCU);//||(start&&!start_d);
		
		p_write_delay2<=p_write_delay; //this might suck as well
		p_write_delay<=(diff==0&&maplen_w==1&&conf_filterlen==1)? p_delay2_alt:p_delay2&&nxt_st==ACCU; //this makes problems, had to give it mux stuff, else the delays sucks on 1,1
		p_delay2<=(get_next_PE_r&&nxt_st==ACCU);
		p_delay2_alt<=p_delay2&&(diff==0)&&(nxt_st==IDLE);
		p_en_delay1<=psum_en_r;//&&(stopper<2);
		p_en_delay2<=p_en_delay1;//&&(nxt_st==MULT);//let see if that works
		m_delay1<=m_done;
		m_delay2<=m_delay1;
		stal_d<=stall;
		start_d<=start;
		psum_delay1<=psum_iterator_r;
		psum_delay2<=psum_delay1;
		again_accu_<=again_accu;
		again_accu_d<=again_accu_;
		empty_fil_b<=empty_fil;
		empty_map_b<=empty_map;
		outdelay_i_d<=outdelay_i;
		outdelay_i_dd<=outdelay_i_d;
		PSUM_o_d<=PSUM_i;
		end 
		
end // always state machine //////////////////////////////////////////



always@* //Update the next state/////////////////////
	begin
		 conf_i_r<=conf_i;

		nxt_st = cur_st;
		if (!conf_enable) nxt_st=IDLE;
		
		else if( stall) begin 
		nxt_st=IDLE;
		stalstate=cur_st;
		end

		else begin	
			
			if( (cur_st==IDLE  ) && ( stall==0 ) && ( stal_d ==1)) nxt_st=stalstate;
			if( ( cur_st==IDLE ) && ( start_d && (!stal_d)) ) nxt_st = DATA;
			if( (  cur_st==DATA ) && (minimal_delay==0)&&((map_iterator_r+1)>=maplen_w ) && ((filter_iterator_r+1)>=conf_filterlen) ) nxt_st = MULT; 
			if( ( cur_st==MULT )  && (m_delay2==1)&& (empty==0) ) nxt_st = ACCU; 
			if( ( cur_st==ACCU ) && ((psum_delay2==(diff)&&again_accu_d))) nxt_st = IDLE ;
		end
	end


always@ (cur_st) //Update the outputs /////////////
	begin
			///DEFUALT
			 
			

			case (cur_st)
					IDLE: begin
							modePE_r = IDLE ; 
			get_next_PE_r <= 0 ; 
				map_en_r <= 0;
				fil_en_r <= 0;
				psum_en_r<=0;
				regs_en_r<=0;
				rst_accm_r<=0;
				
						end
					DATA: begin
							rst_accm_r<=0; 
							again_accu<=0;
							modePE_r = DATA ; 
							psum_en_r<=1;
								map_en_r <= ((map_iterator_r>(maplen_w-1))||empty_map)? 0:1;
								fil_en_r <= (filter_iterator_r>(conf_filterlen-1))||empty_fil? 0:1;
								//get_next_PE_r <= (filter_iterator_r>(conf_filterlen-1))||empty? 0:1;
								//psum_en_r <= (filter_iterator_r>(conf_filterlen-1))||empty? 0:1;
						end
					MULT: begin
					rst_accm_r<=1;
							get_next_PE_r<=0;
							map_en_r <= 0;
							fil_en_r <= 0;
							regs_en_r<= stopper<2?1:0;
							modePE_r = MULT ; 
							psum_en_r<=1;
						end
					ACCU: begin
													get_next_PE_r <=1; 

					rst_accm_r<=1;
					psum_en_r<=0;
					regs_en_r<=0;
							again_accu<=1;
							modePE_r = ACCU ; 
						end
			endcase
	end
	
endmodule 


/*
			
//TODO: add the 24 bits of configuration

module PEController(
		input clk,
		input   resetN,
		
		input   		PEdone, //Signal from the PE when done
		input   [1:0] modeController, //mode from outController
		input   		get_next_in, //signal from outside contorller for ACCUM modeController
		input   [3:0] num_of_ifmap, 
		input   [3:0] num_of_filters,
		
		
		output   		ready, //out ready sigbal for multicast and out controllers
		output   		get_next_PE, //out getNext signal for PE when in ACCUM mode
		output   [1:0] modePE //modeControllersignal for PE 
		
);


parameter IDLE=2'b00, DATA=2'b01, MULT=2'b10, ACCU=2'b11; // modes;

reg [1:0] cur_st , nxt_st;



 reg done_d, done_mult;
reg ready_r; 
reg [1:0] modePE_r ; 
reg	get_next_PE_r;
 
 
assign ready=ready_r;
assign modePE=modePE_r;
assign get_next_PE=get_next_PE_r;
assign num_of_ifmapOut = num_of_ifmap;
assign num_of_filtersOut = num_of_filters;
assign num_of_channelsOut = num_of_channels;

always_ff@(posedge clk or negedge resetN) // State machine logic ////
   begin
	   
   if ( !resetN ) begin // Asynchronic reset
	
		cur_st <= IDLE;
		done_mult <= 1'b0;
		end // asynch
	else begin	
								// Synchronic logic	
		done_d <= PEdone; //For edge detect 
		cur_st <= nxt_st; // Update current state
		//if( ( cur_st==DATA ) && ( done_d == 0 ) && ( PEdone == 1 ) ) done_mult <= 1'b1;
		
		end 
		
end // always state machine //////////////////////////////////////////


always_comb //Update the next state/////////////////////
	begin
		nxt_st = cur_st;
		
		if( ( cur_st==IDLE ) && ( modeController == DATA ) ) nxt_st = DATA;
		if( (  cur_st==DATA ) && ( PEdone == 1 )  && ( done_d == 0 )) nxt_st = MULT; 
	//	if( ( cur_st==MULT )  && ( PEdone == 1 )  && ( done_d == 0 ) && ( done_mult ) ) begin  nxt_st = IDLE; done_mult <= 1'b0; end
		if( ( cur_st==MULT )  && ( PEdone == 1 )  && ( done_d == 0 ) ) nxt_st = IDLE; 
		if( ( cur_st==IDLE ) && ( modeController== ACCU ) ) nxt_st = ACCU ; 
		if( ( cur_st==ACCU ) && ( modeController== IDLE ) ) nxt_st = IDLE ; 
	end
	

always_comb //Update the outputs /////////////
	begin
			///DEFUALT
			ready_r = 1 ; 
			modePE_r = IDLE ; 
			get_next_PE_r = 0 ; 
			
			case (cur_st)
					IDLE: begin
							//NOTHING
						end
					DATA: begin
							ready_r = 0 ;
							modePE_r = DATA ; 
						end
					MULT: begin
							ready_r = 0 ;
							modePE_r = MULT ; 
						end
					ACCU: begin
							ready_r = 0 ;
							modePE_r = ACCU ; 
							get_next_PE_r = get_next_in ;
						end
			endcase
	end
	
endmodule 

			*/