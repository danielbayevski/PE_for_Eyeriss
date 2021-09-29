`include "Eyeriss_PE.v"
`include "clock.sv"
`include "FIFObuffer16b_16b.v"
module Eyeriss_PE_tb();

reg [17:0] dismod;
reg clrr;
reg [15:0] filterp,mapp,pp;
reg gm, gf, gp;
wire [15:0] filter,map,p;
clock clk(.CLK(CLK));
wire [31:0] out, done;
reg [3:0]maplen;
reg [7:0] fillen;
reg [31:0] expctdoutput [11:0];
wire [15:0] psum_out;
wire clrrr;
assign clrrr=!clrr;
wire pnm;


Eyeriss_PE pe(.map(map), .filter(filter),.Psum_from_GLB(p),.Psum_from_PE(16'b0),.getdata_fil(gf),.getdata_map(gm),.getdata_psum(gp),
.id_in(8'b1),.stall(1'b0),.psum_i_empty(1'b0),.psum_i_full(1'b0),
 
.CLK(CLK),
.clr(~clr),
.conf_i({6'b110000,maplen,fillen,8'b00000001}),
							// enable, GLB input, 0 mult bit, 4 map len,7 fitler len, id =1; 
							//	1bit	1bit 	   4bit			4bit		8bit		8bit 
.ready(),.psum_out(psum_out),.psum_o_empty(pnm),.psum_o_full()
);
/*        conf_i = 
  wire conf_enable;                                               1
	wire conf_psum_input;  //0- psum from PE, 1-psum from GLB     1
    wire [3:0]mult_bit_select;                                    0000
	wire [3:0] conf_maplen;                                       0010
    wire [7:0] conf_filterlen;                                    00000011
	wire [7:0] conf_id;                                           00000001
	=> 11000000100000001100000001
*/                 
reg rid;
reg[15:0]check;
wire [15:0] outcheck;
assign clr=clrr;
assign filter=filterp;
assign map=mapp;
assign p=pp;
initial rid=0;
initial check=0;

FIFObuffer16b_16b Fifo_outside(
.Clk(CLK),
.dataIn(psum_out),
.RD(rid),
.WR(!pnm),
.EN(1'b1),
.dataOut(outcheck),
.Rst(clr),.EMPTY(), 
.FULL()
);

wire [15:0]testwire;
wire eme,emr,fle,flr;
reg wr;

/*
FIFObuffer16b_16b test_e(
.Clk(CLK),
.dataIn(dismod),
.RD(!flr),
.WR(wr),
.EN(1'b1),
.dataOut(testwire),
.Rst(clrr),.EMPTY(eme), 
.FULL(fle)
);

FIFObuffer16b_16b test_r(
.Clk(CLK),
.dataIn(testwire),
.RD(1'b0),
.WR(!eme),
.EN(1'b1),
.dataOut(),
.Rst(clrr),.EMPTY(emr), 
.FULL(flr)
);
*/

 

//TODO: more tests,how about a test every 1000 CLKS 
	
 initial dismod=0;
always@(posedge CLK) begin
 dismod<=dismod+1;
 
 case(dismod)
/* 
 default: 
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
   clrr<=0;
   filterp<=0;
   mapp<=0;
   
   end 
 */
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

18'd0: begin
clrr<=1;  
 end   
18'd1: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=45;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21977;
 end   
18'd2: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=81;
   mapp<=0;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23436;
 end   
18'd3: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=27;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd4: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=61;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd5: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=91;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd6: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=95;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd7: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=42;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=27;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd9: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=36;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd10: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=91;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd11: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd12: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd13: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd14: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd15: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd16: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd17: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd18: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd19: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21977;
 end   
18'd142: begin  
rid<=1;
end
18'd143: begin  
end
18'd144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd146: begin  
rid<=0;
end
18'd201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=26;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=24923;
 end   
18'd202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=71;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23776;
 end   
18'd203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=38;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=69;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=12;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=67;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=99;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=35;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=94;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24923;
 end   
18'd214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24923;
 end   
18'd215: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24923;
 end   
18'd216: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24923;
 end   
18'd217: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24923;
 end   
18'd342: begin  
rid<=1;
end
18'd343: begin  
end
18'd344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd346: begin  
rid<=0;
end
18'd401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=11;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11767;
 end   
18'd402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=53;
   mapp<=33;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12209;
 end   
18'd403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=68;
   mapp<=73;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12584;
 end   
18'd404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=47;
   mapp<=64;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12207;
 end   
18'd405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=44;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=57;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11767;
 end   
18'd542: begin  
rid<=1;
end
18'd543: begin  
end
18'd544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd548: begin  
rid<=0;
end
18'd601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=29;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1189;
 end   
18'd602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd742: begin  
rid<=1;
end
18'd743: begin  
end
18'd744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd745: begin  
rid<=0;
end
18'd801: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=46;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11128;
 end   
18'd802: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=5;
   mapp<=90;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17786;
 end   
18'd803: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=90;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd804: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=29;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd805: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=70;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd806: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=50;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd807: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=6;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd808: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=1;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd809: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd810: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd811: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd812: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd813: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11128;
 end   
18'd814: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11128;
 end   
18'd815: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11128;
 end   
18'd816: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11128;
 end   
18'd817: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11128;
 end   
18'd942: begin  
rid<=1;
end
18'd943: begin  
end
18'd944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd946: begin  
rid<=0;
end
18'd1001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=76;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10707;
 end   
18'd1002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=31;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd1003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=8;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd1004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=44;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd1005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=39;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd1006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=26;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd1007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=23;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd1008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd1009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd1010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd1011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd1012: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd1013: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10707;
 end   
18'd1014: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10707;
 end   
18'd1142: begin  
rid<=1;
end
18'd1143: begin  
end
18'd1144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd1145: begin  
rid<=0;
end
18'd1201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=15;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=270;
 end   
18'd1202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=82;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1240;
 end   
18'd1203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=455;
 end   
18'd1204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=41;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=645;
 end   
18'd1205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=33;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=535;
 end   
18'd1206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd1342: begin  
rid<=1;
end
18'd1343: begin  
end
18'd1344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd1345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd1346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd1347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd1348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd1349: begin  
rid<=0;
end
18'd1401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=72;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4621;
 end   
18'd1402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=70;
   mapp<=30;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7734;
 end   
18'd1403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=29;
   mapp<=77;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8101;
 end   
18'd1404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=6;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8066;
 end   
18'd1405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=73;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=11925;
 end   
18'd1406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=86;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9017;
 end   
18'd1407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=21;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=5418;
 end   
18'd1408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd1409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd1410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd1411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd1412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd1542: begin  
rid<=1;
end
18'd1543: begin  
end
18'd1544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd1545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd1546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd1547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd1548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd1549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd1550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd1551: begin  
rid<=0;
end
18'd1601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=61;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17109;
 end   
18'd1602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=36;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14874;
 end   
18'd1603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=55;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17549;
 end   
18'd1604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=67;
   mapp<=90;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16343;
 end   
18'd1605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=55;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=13609;
 end   
18'd1606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=74;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=16572;
 end   
18'd1607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=31;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd1608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd1609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd1610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd1611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd1612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd1613: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17109;
 end   
18'd1742: begin  
rid<=1;
end
18'd1743: begin  
end
18'd1744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd1745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd1746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd1747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd1748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd1749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd1750: begin  
rid<=0;
end
18'd1801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=57;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7110;
 end   
18'd1802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=87;
   mapp<=66;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6382;
 end   
18'd1803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=30;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2339;
 end   
18'd1804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=7;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8346;
 end   
18'd1805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=91;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5836;
 end   
18'd1806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=7;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3668;
 end   
18'd1807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd1808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd1809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd1942: begin  
rid<=1;
end
18'd1943: begin  
end
18'd1944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd1945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd1946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd1947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd1948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd1949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd1950: begin  
rid<=0;
end
18'd2001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=9;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=405;
 end   
18'd2002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=9;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=415;
 end   
18'd2003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=58;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2630;
 end   
18'd2004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=21;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=975;
 end   
18'd2005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=88;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4000;
 end   
18'd2006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=22;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=1040;
 end   
18'd2007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=46;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2130;
 end   
18'd2008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=6;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=340;
 end   
18'd2009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=30;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1430;
 end   
18'd2010: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=13;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=675;
 end   
18'd2011: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=68;
   mapp<=0;
   pp<=100;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[10]<=3160;
 end   
18'd2012: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd2142: begin  
rid<=1;
end
18'd2143: begin  
end
18'd2144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd2145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd2146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd2147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd2148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd2149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd2150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd2151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd2152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd2153: begin  
check<=expctdoutput[9]-outcheck;
end
18'd2154: begin  
check<=expctdoutput[10]-outcheck;
end
18'd2155: begin  
rid<=0;
end
18'd2201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=2;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23394;
 end   
18'd2202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=50;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd2203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=91;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd2204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=36;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd2205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=74;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd2206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=20;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd2207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=96;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd2208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=21;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd2209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=48;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd2210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=99;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd2211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd2212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd2213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2218: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2219: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2220: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23394;
 end   
18'd2342: begin  
rid<=1;
end
18'd2343: begin  
end
18'd2344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd2345: begin  
rid<=0;
end
18'd2401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=34;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2754;
 end   
18'd2402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=53;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4303;
 end   
18'd2403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=99;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8039;
 end   
18'd2404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1488;
 end   
18'd2405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=38;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=3118;
 end   
18'd2406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=50;
 end   
18'd2407: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=88;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=7188;
 end   
18'd2408: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=27;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2257;
 end   
18'd2409: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=67;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=5507;
 end   
18'd2410: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=28;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=2358;
 end   
18'd2411: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd2542: begin  
rid<=1;
end
18'd2543: begin  
end
18'd2544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd2545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd2546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd2547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd2548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd2549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd2550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd2551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd2552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd2553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd2554: begin  
rid<=0;
end
18'd2601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4119;
 end   
18'd2602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=49;
   mapp<=7;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5381;
 end   
18'd2603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=19;
   mapp<=21;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5868;
 end   
18'd2604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=56;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd2605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=98;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd2606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=3;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd2607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=24;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd2608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=8;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd2609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=44;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd2610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd2611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd2612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd2613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2619: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2620: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4119;
 end   
18'd2742: begin  
rid<=1;
end
18'd2743: begin  
end
18'd2744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd2745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd2746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd2747: begin  
rid<=0;
end
18'd2801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=87;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7557;
 end   
18'd2802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=14;
   mapp<=95;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7311;
 end   
18'd2803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=3;
   mapp<=85;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12594;
 end   
18'd2804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=48;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd2805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd2806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=58;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd2807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd2808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=80;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd2809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd2810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd2811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd2812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd2813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7557;
 end   
18'd2814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7557;
 end   
18'd2942: begin  
rid<=1;
end
18'd2943: begin  
end
18'd2944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd2945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd2946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd2947: begin  
rid<=0;
end
18'd3001: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=92;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19386;
 end   
18'd3002: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=38;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17763;
 end   
18'd3003: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=79;
   mapp<=98;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20361;
 end   
18'd3004: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=90;
   mapp<=9;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10692;
 end   
18'd3005: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=57;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=13178;
 end   
18'd3006: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd3007: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd3008: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd3009: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd3010: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd3011: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd3012: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd3142: begin  
rid<=1;
end
18'd3143: begin  
end
18'd3144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd3145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd3146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd3147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd3148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd3149: begin  
rid<=0;
end
18'd3201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=88;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8848;
 end   
18'd3202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=56;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5271;
 end   
18'd3203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=11;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1051;
 end   
18'd3204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=2;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=722;
 end   
18'd3205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=34;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4214;
 end   
18'd3206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=72;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd3207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd3208: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd3342: begin  
rid<=1;
end
18'd3343: begin  
end
18'd3344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd3345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd3346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd3347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd3348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd3349: begin  
rid<=0;
end
18'd3401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=75;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3450;
 end   
18'd3402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=62;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=4660;
 end   
18'd3403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=6470;
 end   
18'd3404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd3542: begin  
rid<=1;
end
18'd3543: begin  
end
18'd3544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd3545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd3546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd3547: begin  
rid<=0;
end
18'd3601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=76;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15915;
 end   
18'd3602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=92;
   mapp<=44;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19649;
 end   
18'd3603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=89;
   mapp<=16;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=19672;
 end   
18'd3604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=75;
   mapp<=81;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=21237;
 end   
18'd3605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=12;
   mapp<=98;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16814;
 end   
18'd3606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=22;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=16392;
 end   
18'd3607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd3608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd3609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd3610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd3611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd3612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd3613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15915;
 end   
18'd3614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15915;
 end   
18'd3615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15915;
 end   
18'd3742: begin  
rid<=1;
end
18'd3743: begin  
end
18'd3744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd3745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd3746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd3747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd3748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd3749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd3750: begin  
rid<=0;
end
18'd3801: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=89;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5465;
 end   
18'd3802: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=55;
   mapp<=69;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11530;
 end   
18'd3803: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=23;
   mapp<=61;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10312;
 end   
18'd3804: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd3805: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd3806: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd3807: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd3808: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd3942: begin  
rid<=1;
end
18'd3943: begin  
end
18'd3944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd3945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd3946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd3947: begin  
rid<=0;
end
18'd4001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=54;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16021;
 end   
18'd4002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=21;
   mapp<=85;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10054;
 end   
18'd4003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=89;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11163;
 end   
18'd4004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=76;
   mapp<=26;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9296;
 end   
18'd4005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=17;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=7435;
 end   
18'd4006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=57;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=11892;
 end   
18'd4007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd4008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd4009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd4010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd4011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd4012: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd4013: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16021;
 end   
18'd4142: begin  
rid<=1;
end
18'd4143: begin  
end
18'd4144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd4145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd4146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd4147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd4148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd4149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd4150: begin  
rid<=0;
end
18'd4201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=55;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5910;
 end   
18'd4202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=34;
   mapp<=25;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4363;
 end   
18'd4203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=49;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5553;
 end   
18'd4204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=41;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd4205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd4206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd4342: begin  
rid<=1;
end
18'd4343: begin  
end
18'd4344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd4345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd4346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd4347: begin  
rid<=0;
end
18'd4401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=49;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18659;
 end   
18'd4402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=37;
   mapp<=18;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23021;
 end   
18'd4403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=66;
   mapp<=53;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=26642;
 end   
18'd4404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=49;
   mapp<=39;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=23556;
 end   
18'd4405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=93;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd4406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=95;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd4407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd4408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd4409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd4410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd4411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd4412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd4413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18659;
 end   
18'd4414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18659;
 end   
18'd4415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18659;
 end   
18'd4542: begin  
rid<=1;
end
18'd4543: begin  
end
18'd4544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd4545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd4546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd4547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd4548: begin  
rid<=0;
end
18'd4601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=71;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6106;
 end   
18'd4602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=365;
 end   
18'd4603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=6268;
 end   
18'd4604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=82;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5852;
 end   
18'd4605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=55;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=3945;
 end   
18'd4606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=34;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2464;
 end   
18'd4607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=14;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1054;
 end   
18'd4608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=1;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=141;
 end   
18'd4609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=16;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=1216;
 end   
18'd4610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd4742: begin  
rid<=1;
end
18'd4743: begin  
end
18'd4744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd4745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd4746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd4747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd4748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd4749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd4750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd4751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd4752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd4753: begin  
rid<=0;
end
18'd4801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=55;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=715;
 end   
18'd4802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=85;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1115;
 end   
18'd4803: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=53;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=709;
 end   
18'd4804: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=12;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=186;
 end   
18'd4805: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=8;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=144;
 end   
18'd4806: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=32;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=466;
 end   
18'd4807: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=45;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=645;
 end   
18'd4808: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=13;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=239;
 end   
18'd4809: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=56;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=808;
 end   
18'd4810: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=21;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=363;
 end   
18'd4811: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd4942: begin  
rid<=1;
end
18'd4943: begin  
end
18'd4944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd4945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd4946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd4947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd4948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd4949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd4950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd4951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd4952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd4953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd4954: begin  
rid<=0;
end
18'd5001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=81;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6642;
 end   
18'd5002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=44;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3618;
 end   
18'd5003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=96;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7892;
 end   
18'd5004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=22;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1834;
 end   
18'd5005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=29;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2418;
 end   
18'd5006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=61;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=5052;
 end   
18'd5007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=35;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2930;
 end   
18'd5008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=50;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=4170;
 end   
18'd5009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd5142: begin  
rid<=1;
end
18'd5143: begin  
end
18'd5144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd5145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd5146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd5147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd5148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd5149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd5150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd5151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd5152: begin  
rid<=0;
end
18'd5201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=49;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14110;
 end   
18'd5202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=86;
   mapp<=59;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19442;
 end   
18'd5203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=13;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12215;
 end   
18'd5204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=74;
   mapp<=39;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14087;
 end   
18'd5205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=22;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd5206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=68;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd5207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd5208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd5209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd5210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd5211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd5212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd5213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14110;
 end   
18'd5214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14110;
 end   
18'd5215: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14110;
 end   
18'd5342: begin  
rid<=1;
end
18'd5343: begin  
end
18'd5344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd5345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd5346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd5347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd5348: begin  
rid<=0;
end
18'd5401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=77;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3369;
 end   
18'd5402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=14;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4994;
 end   
18'd5403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=14;
   mapp<=91;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6524;
 end   
18'd5404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=24;
   mapp<=2;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10475;
 end   
18'd5405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=34;
   mapp<=25;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11997;
 end   
18'd5406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=74;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=11781;
 end   
18'd5407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=72;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=9160;
 end   
18'd5408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd5409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=33;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd5410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=70;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd5411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd5412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd5413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3369;
 end   
18'd5414: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3369;
 end   
18'd5415: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3369;
 end   
18'd5416: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3369;
 end   
18'd5542: begin  
rid<=1;
end
18'd5543: begin  
end
18'd5544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd5545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd5546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd5547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd5548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd5549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd5550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd5551: begin  
rid<=0;
end
18'd5601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=85;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15130;
 end   
18'd5602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=2;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd5603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=80;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd5604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=13;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd5605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=27;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd5606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=2;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd5607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd5608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd5609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd5610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd5611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd5612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd5742: begin  
rid<=1;
end
18'd5743: begin  
end
18'd5744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd5745: begin  
rid<=0;
end
18'd5801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=32;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3247;
 end   
18'd5802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=5;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3645;
 end   
18'd5803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=93;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7599;
 end   
18'd5804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=23;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6799;
 end   
18'd5805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=72;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=10182;
 end   
18'd5806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=61;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2686;
 end   
18'd5807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd5808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd5809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd5810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd5811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd5942: begin  
rid<=1;
end
18'd5943: begin  
end
18'd5944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd5945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd5946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd5947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd5948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd5949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd5950: begin  
rid<=0;
end
18'd6001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=70;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=24351;
 end   
18'd6002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=35;
   mapp<=42;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20739;
 end   
18'd6003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=33;
   mapp<=22;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24823;
 end   
18'd6004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=11;
   mapp<=86;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=25003;
 end   
18'd6005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=60;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd6006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=96;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd6007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=67;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd6008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=85;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd6009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd6010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd6011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd6012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd6013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24351;
 end   
18'd6142: begin  
rid<=1;
end
18'd6143: begin  
end
18'd6144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd6145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd6146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd6147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd6148: begin  
rid<=0;
end
18'd6201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=78;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=29103;
 end   
18'd6202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=93;
   mapp<=95;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21311;
 end   
18'd6203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=51;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20452;
 end   
18'd6204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=84;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd6205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=18;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd6206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=64;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd6207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=19;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd6208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=52;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd6209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd6210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd6211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd6212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd6213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6214: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6215: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6216: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6217: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6218: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6219: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6220: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=29103;
 end   
18'd6342: begin  
rid<=1;
end
18'd6343: begin  
end
18'd6344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd6345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd6346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd6347: begin  
rid<=0;
end
18'd6401: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=15;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5699;
 end   
18'd6402: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=76;
   mapp<=10;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8767;
 end   
18'd6403: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=27;
   mapp<=57;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8938;
 end   
18'd6404: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=43;
   mapp<=70;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6006;
 end   
18'd6405: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=58;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8441;
 end   
18'd6406: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=64;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd6407: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=9;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd6408: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd6409: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd6410: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd6411: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd6412: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd6542: begin  
rid<=1;
end
18'd6543: begin  
end
18'd6544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd6545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd6546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd6547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd6548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd6549: begin  
rid<=0;
end
18'd6601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=27;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7229;
 end   
18'd6602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=29;
   mapp<=77;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6891;
 end   
18'd6603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=28;
   mapp<=74;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5757;
 end   
18'd6604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=23;
   mapp<=25;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5269;
 end   
18'd6605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=20;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=7097;
 end   
18'd6606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=2;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=9100;
 end   
18'd6607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd6608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=23;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd6609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=96;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd6610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd6611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd6612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd6613: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7229;
 end   
18'd6742: begin  
rid<=1;
end
18'd6743: begin  
end
18'd6744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd6745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd6746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd6747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd6748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd6749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd6750: begin  
rid<=0;
end
18'd6801: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=71;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15408;
 end   
18'd6802: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=11;
   mapp<=25;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9059;
 end   
18'd6803: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=47;
   mapp<=64;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9370;
 end   
18'd6804: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=53;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd6805: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=20;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd6806: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=90;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd6807: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=24;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd6808: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd6809: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd6810: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd6811: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd6812: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd6813: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15408;
 end   
18'd6814: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15408;
 end   
18'd6815: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15408;
 end   
18'd6816: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15408;
 end   
18'd6942: begin  
rid<=1;
end
18'd6943: begin  
end
18'd6944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd6945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd6946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd6947: begin  
rid<=0;
end
18'd7001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=13;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10199;
 end   
18'd7002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=58;
   mapp<=51;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10541;
 end   
18'd7003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=78;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd7004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=65;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd7005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=7;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd7006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=77;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd7007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd7008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd7009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd7010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd7011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd7142: begin  
rid<=1;
end
18'd7143: begin  
end
18'd7144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd7145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd7146: begin  
rid<=0;
end
18'd7201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=60;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2511;
 end   
18'd7202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=57;
   mapp<=3;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2305;
 end   
18'd7203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=24;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1187;
 end   
18'd7204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=77;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3057;
 end   
18'd7205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=8;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=391;
 end   
18'd7206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=13;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=818;
 end   
18'd7207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=3456;
 end   
18'd7208: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=1;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=259;
 end   
18'd7209: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=2210;
 end   
18'd7210: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=60;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=2514;
 end   
18'd7211: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=28;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd7212: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd7213: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2511;
 end   
18'd7342: begin  
rid<=1;
end
18'd7343: begin  
end
18'd7344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd7345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd7346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd7347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd7348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd7349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd7350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd7351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd7352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd7353: begin  
check<=expctdoutput[9]-outcheck;
end
18'd7354: begin  
rid<=0;
end
18'd7401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=4;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2036;
 end   
18'd7402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=35;
   mapp<=40;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3217;
 end   
18'd7403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=56;
   mapp<=11;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3730;
 end   
18'd7404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=72;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2643;
 end   
18'd7405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd7406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=23;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd7407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd7408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd7409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd7542: begin  
rid<=1;
end
18'd7543: begin  
end
18'd7544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd7545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd7546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd7547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd7548: begin  
rid<=0;
end
18'd7601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=22;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16804;
 end   
18'd7602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=17;
   mapp<=26;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19435;
 end   
18'd7603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=12;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd7604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=17;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd7605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=96;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd7606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=85;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd7607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=41;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd7608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=23;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd7609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=29;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd7610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd7611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd7612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd7613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7616: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7617: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7618: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7619: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16804;
 end   
18'd7742: begin  
rid<=1;
end
18'd7743: begin  
end
18'd7744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd7745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd7746: begin  
rid<=0;
end
18'd7801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=54;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3186;
 end   
18'd7802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=32;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1738;
 end   
18'd7803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=96;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5204;
 end   
18'd7804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=55;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3000;
 end   
18'd7805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=53;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2902;
 end   
18'd7806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=62;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3398;
 end   
18'd7807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=84;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4596;
 end   
18'd7808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=34;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1906;
 end   
18'd7809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd7942: begin  
rid<=1;
end
18'd7943: begin  
end
18'd7944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd7945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd7946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd7947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd7948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd7949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd7950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd7951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd7952: begin  
rid<=0;
end
18'd8001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=23;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14378;
 end   
18'd8002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=42;
   mapp<=32;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12912;
 end   
18'd8003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=54;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17533;
 end   
18'd8004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=11;
   mapp<=7;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16378;
 end   
18'd8005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=41;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd8006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=75;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd8007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=59;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=25;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd8009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd8010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd8011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd8012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd8013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14378;
 end   
18'd8142: begin  
rid<=1;
end
18'd8143: begin  
end
18'd8144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd8145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd8146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd8147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd8148: begin  
rid<=0;
end
18'd8201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=37;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19305;
 end   
18'd8202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=34;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18641;
 end   
18'd8203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=56;
   mapp<=5;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=26716;
 end   
18'd8204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=93;
   mapp<=83;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=20285;
 end   
18'd8205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=76;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd8206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=5;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd8207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=62;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd8209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd8210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd8211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd8212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd8213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19305;
 end   
18'd8214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19305;
 end   
18'd8215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19305;
 end   
18'd8216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19305;
 end   
18'd8217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19305;
 end   
18'd8342: begin  
rid<=1;
end
18'd8343: begin  
end
18'd8344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd8345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd8346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd8347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd8348: begin  
rid<=0;
end
18'd8401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18084;
 end   
18'd8402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=43;
   mapp<=13;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21031;
 end   
18'd8403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=96;
   mapp<=41;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24393;
 end   
18'd8404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=73;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd8405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=40;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd8406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=13;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd8407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=75;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=72;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd8409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=18;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd8410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd8411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd8412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd8413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8417: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8418: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8419: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8420: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18084;
 end   
18'd8542: begin  
rid<=1;
end
18'd8543: begin  
end
18'd8544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd8545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd8546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd8547: begin  
rid<=0;
end
18'd8601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=88;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=25438;
 end   
18'd8602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=85;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd8603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=90;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd8604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=97;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd8605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=89;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd8606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=90;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd8607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd8609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd8610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd8611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd8612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd8742: begin  
rid<=1;
end
18'd8743: begin  
end
18'd8744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd8745: begin  
rid<=0;
end
18'd8801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=81;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6211;
 end   
18'd8802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=3;
   mapp<=51;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10167;
 end   
18'd8803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=29;
   mapp<=40;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8171;
 end   
18'd8804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=75;
   mapp<=44;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9944;
 end   
18'd8805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=8;
   mapp<=58;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=13494;
 end   
18'd8806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=35;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=6617;
 end   
18'd8807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd8808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd8809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd8810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd8811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd8812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd8813: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6211;
 end   
18'd8814: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6211;
 end   
18'd8815: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6211;
 end   
18'd8942: begin  
rid<=1;
end
18'd8943: begin  
end
18'd8944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd8945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd8946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd8947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd8948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd8949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd8950: begin  
rid<=0;
end
18'd9001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=77;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9676;
 end   
18'd9002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=15;
   mapp<=56;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7478;
 end   
18'd9003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=83;
   mapp<=61;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10683;
 end   
18'd9004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=27;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6517;
 end   
18'd9005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=67;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=8221;
 end   
18'd9006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=41;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=6962;
 end   
18'd9007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=29;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=3972;
 end   
18'd9008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=40;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=9487;
 end   
18'd9009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=13;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=2274;
 end   
18'd9010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd9011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd9012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd9013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9676;
 end   
18'd9014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9676;
 end   
18'd9142: begin  
rid<=1;
end
18'd9143: begin  
end
18'd9144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd9145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd9146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd9147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd9148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd9149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd9150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd9151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd9152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd9153: begin  
rid<=0;
end
18'd9201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=75;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1886;
 end   
18'd9202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=86;
   mapp<=1;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7997;
 end   
18'd9203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=11994;
 end   
18'd9204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=59;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=10475;
 end   
18'd9205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=70;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=7698;
 end   
18'd9206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=28;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=4472;
 end   
18'd9207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=27;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=9309;
 end   
18'd9208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd9209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd9210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd9342: begin  
rid<=1;
end
18'd9343: begin  
end
18'd9344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd9345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd9346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd9347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd9348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd9349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd9350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd9351: begin  
rid<=0;
end
18'd9401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=40;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3480;
 end   
18'd9402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=47;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1890;
 end   
18'd9403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=4;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=180;
 end   
18'd9404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=3;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=150;
 end   
18'd9405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=21;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=880;
 end   
18'd9406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=63;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2570;
 end   
18'd9407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=6;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=300;
 end   
18'd9408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=63;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=2590;
 end   
18'd9409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=10;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=480;
 end   
18'd9410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=2930;
 end   
18'd9411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=89;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=3660;
 end   
18'd9412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd9542: begin  
rid<=1;
end
18'd9543: begin  
end
18'd9544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd9545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd9546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd9547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd9548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd9549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd9550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd9551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd9552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd9553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd9554: begin  
check<=expctdoutput[10]-outcheck;
end
18'd9555: begin  
rid<=0;
end
18'd9601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=3;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=57;
 end   
18'd9602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=13;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=49;
 end   
18'd9603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=91;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=293;
 end   
18'd9604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=4;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=42;
 end   
18'd9605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=18;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=94;
 end   
18'd9606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=32;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=146;
 end   
18'd9607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=50;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=210;
 end   
18'd9608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=5;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=85;
 end   
18'd9609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=75;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=305;
 end   
18'd9610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=39;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=207;
 end   
18'd9611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd9742: begin  
rid<=1;
end
18'd9743: begin  
end
18'd9744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd9745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd9746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd9747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd9748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd9749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd9750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd9751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd9752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd9753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd9754: begin  
rid<=0;
end
18'd9801: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=13;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=611;
 end   
18'd9802: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1102;
 end   
18'd9803: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=48;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=644;
 end   
18'd9804: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=953;
 end   
18'd9805: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=64;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=872;
 end   
18'd9806: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd9942: begin  
rid<=1;
end
18'd9943: begin  
end
18'd9944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd9945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd9946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd9947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd9948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd9949: begin  
rid<=0;
end
18'd10001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=40;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13578;
 end   
18'd10002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=45;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11898;
 end   
18'd10003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=8;
   mapp<=78;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16214;
 end   
18'd10004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=18;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd10005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=70;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd10006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=1;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd10007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=23;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd10008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=32;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd10009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd10010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd10011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd10012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd10013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10018: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13578;
 end   
18'd10142: begin  
rid<=1;
end
18'd10143: begin  
end
18'd10144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd10145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd10146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd10147: begin  
rid<=0;
end
18'd10201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=15;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7803;
 end   
18'd10202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=65;
   mapp<=70;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6393;
 end   
18'd10203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=28;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3372;
 end   
18'd10204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=43;
   mapp<=1;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2045;
 end   
18'd10205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=47;
   mapp<=3;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5579;
 end   
18'd10206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd10207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd10208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd10209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd10210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd10211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd10212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd10213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7803;
 end   
18'd10214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7803;
 end   
18'd10342: begin  
rid<=1;
end
18'd10343: begin  
end
18'd10344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd10345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd10346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd10347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd10348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd10349: begin  
rid<=0;
end
18'd10401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=58;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23838;
 end   
18'd10402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=54;
   mapp<=9;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=22294;
 end   
18'd10403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=88;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24248;
 end   
18'd10404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=46;
   mapp<=49;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=21485;
 end   
18'd10405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=90;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd10406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=49;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd10407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=43;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd10408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd10409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd10410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd10411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd10412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd10413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23838;
 end   
18'd10414: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23838;
 end   
18'd10415: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23838;
 end   
18'd10416: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23838;
 end   
18'd10417: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23838;
 end   
18'd10542: begin  
rid<=1;
end
18'd10543: begin  
end
18'd10544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd10545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd10546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd10547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd10548: begin  
rid<=0;
end
18'd10601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=83;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6329;
 end   
18'd10602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=35;
   mapp<=67;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6831;
 end   
18'd10603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd10604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd10605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd10742: begin  
rid<=1;
end
18'd10743: begin  
end
18'd10744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd10745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd10746: begin  
rid<=0;
end
18'd10801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=66;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8368;
 end   
18'd10802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=44;
   mapp<=53;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8215;
 end   
18'd10803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=55;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8205;
 end   
18'd10804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=18;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd10805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=26;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd10806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=11;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd10807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd10808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd10809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd10810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd10811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd10812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd10813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8368;
 end   
18'd10814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8368;
 end   
18'd10942: begin  
rid<=1;
end
18'd10943: begin  
end
18'd10944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd10945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd10946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd10947: begin  
rid<=0;
end
18'd11001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=64;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11044;
 end   
18'd11002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=42;
   mapp<=49;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9943;
 end   
18'd11003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=75;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd11004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=13;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd11005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=42;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd11006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=96;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd11007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd11008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd11009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd11010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd11011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd11142: begin  
rid<=1;
end
18'd11143: begin  
end
18'd11144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd11145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd11146: begin  
rid<=0;
end
18'd11201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=4;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2380;
 end   
18'd11202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=5;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd11203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=26;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd11204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=12;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd11205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd11206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd11207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd11208: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd11342: begin  
rid<=1;
end
18'd11343: begin  
end
18'd11344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd11345: begin  
rid<=0;
end
18'd11401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=94;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12006;
 end   
18'd11402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=56;
   mapp<=36;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9524;
 end   
18'd11403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=52;
   mapp<=36;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10196;
 end   
18'd11404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=36;
   mapp<=41;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9155;
 end   
18'd11405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=38;
   mapp<=14;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8491;
 end   
18'd11406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd11407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=55;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd11408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd11409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=31;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd11410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd11411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd11412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd11413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12006;
 end   
18'd11414: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12006;
 end   
18'd11542: begin  
rid<=1;
end
18'd11543: begin  
end
18'd11544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd11545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd11546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd11547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd11548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd11549: begin  
rid<=0;
end
18'd11601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=90;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8018;
 end   
18'd11602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=50;
   mapp<=11;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11198;
 end   
18'd11603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=62;
   mapp<=37;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9943;
 end   
18'd11604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=34;
   mapp<=86;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5240;
 end   
18'd11605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=93;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8012;
 end   
18'd11606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=53;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4163;
 end   
18'd11607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=16;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6660;
 end   
18'd11608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=52;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6590;
 end   
18'd11609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=8;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd11610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd11611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=33;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd11612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd11613: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8018;
 end   
18'd11614: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8018;
 end   
18'd11615: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8018;
 end   
18'd11742: begin  
rid<=1;
end
18'd11743: begin  
end
18'd11744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd11745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd11746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd11747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd11748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd11749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd11750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd11751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd11752: begin  
rid<=0;
end
18'd11801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=80;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2774;
 end   
18'd11802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=18;
   mapp<=3;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1258;
 end   
18'd11803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=56;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5364;
 end   
18'd11804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=48;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4302;
 end   
18'd11805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=24;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2266;
 end   
18'd11806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=17;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=1644;
 end   
18'd11807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=13;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1262;
 end   
18'd11808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=9;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1294;
 end   
18'd11809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=28;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=2320;
 end   
18'd11810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd11811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd11812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd11942: begin  
rid<=1;
end
18'd11943: begin  
end
18'd11944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd11945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd11946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd11947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd11948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd11949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd11950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd11951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd11952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd11953: begin  
rid<=0;
end
18'd12001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=2;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15903;
 end   
18'd12002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=61;
   mapp<=61;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11477;
 end   
18'd12003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=89;
   mapp<=64;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9897;
 end   
18'd12004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=48;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd12005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=82;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd12006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd12007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd12008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd12009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd12010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd12011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd12012: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd12142: begin  
rid<=1;
end
18'd12143: begin  
end
18'd12144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd12145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd12146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd12147: begin  
rid<=0;
end
18'd12201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=31;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2552;
 end   
18'd12202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=69;
   mapp<=2;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2903;
 end   
18'd12203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=78;
   mapp<=23;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1882;
 end   
18'd12204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=59;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1663;
 end   
18'd12205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=8;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1871;
 end   
18'd12206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=19;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd12207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd12208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd12209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd12210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd12342: begin  
rid<=1;
end
18'd12343: begin  
end
18'd12344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd12345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd12346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd12347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd12348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd12349: begin  
rid<=0;
end
18'd12401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=22;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1782;
 end   
18'd12402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=4;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=98;
 end   
18'd12403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2044;
 end   
18'd12404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=85;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=1900;
 end   
18'd12405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=13;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=326;
 end   
18'd12406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=98;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2206;
 end   
18'd12407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=89;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2018;
 end   
18'd12408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd12542: begin  
rid<=1;
end
18'd12543: begin  
end
18'd12544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd12545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd12546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd12547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd12548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd12549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd12550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd12551: begin  
rid<=0;
end
18'd12601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=69;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11923;
 end   
18'd12602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=58;
   mapp<=61;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19899;
 end   
18'd12603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=34;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16296;
 end   
18'd12604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=71;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd12605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=64;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd12606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=17;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd12607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=15;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd12608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=55;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd12609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd12610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd12611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd12612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd12613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12616: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12617: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12618: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11923;
 end   
18'd12742: begin  
rid<=1;
end
18'd12743: begin  
end
18'd12744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd12745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd12746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd12747: begin  
rid<=0;
end
18'd12801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=10;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15280;
 end   
18'd12802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=84;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19185;
 end   
18'd12803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=74;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd12804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=80;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd12805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=15;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd12806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd12807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd12808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd12809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd12810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd12811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd12942: begin  
rid<=1;
end
18'd12943: begin  
end
18'd12944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd12945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd12946: begin  
rid<=0;
end
18'd13001: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=98;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8117;
 end   
18'd13002: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=73;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8827;
 end   
18'd13003: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=88;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7743;
 end   
18'd13004: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=77;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4273;
 end   
18'd13005: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=32;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5834;
 end   
18'd13006: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=56;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=8051;
 end   
18'd13007: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=89;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd13008: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd13009: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd13010: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd13011: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd13142: begin  
rid<=1;
end
18'd13143: begin  
end
18'd13144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd13145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd13146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd13147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd13148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd13149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd13150: begin  
rid<=0;
end
18'd13201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=71;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26138;
 end   
18'd13202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=33;
   mapp<=23;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17460;
 end   
18'd13203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=67;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20007;
 end   
18'd13204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=53;
   mapp<=28;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=22541;
 end   
18'd13205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=95;
   mapp<=84;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=25448;
 end   
18'd13206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=68;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd13207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd13208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd13209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd13210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd13211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd13212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd13213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26138;
 end   
18'd13214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26138;
 end   
18'd13215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26138;
 end   
18'd13216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26138;
 end   
18'd13342: begin  
rid<=1;
end
18'd13343: begin  
end
18'd13344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd13345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd13346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd13347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd13348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd13349: begin  
rid<=0;
end
18'd13401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=9;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13339;
 end   
18'd13402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=93;
   mapp<=50;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14847;
 end   
18'd13403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=86;
   mapp<=98;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8082;
 end   
18'd13404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=80;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7952;
 end   
18'd13405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=16;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=9520;
 end   
18'd13406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=49;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7565;
 end   
18'd13407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd13408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=28;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd13409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd13410: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd13411: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd13542: begin  
rid<=1;
end
18'd13543: begin  
end
18'd13544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd13545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd13546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd13547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd13548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd13549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd13550: begin  
rid<=0;
end
18'd13601: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=26;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5458;
 end   
18'd13602: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=66;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5601;
 end   
18'd13603: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=87;
   mapp<=26;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5932;
 end   
18'd13604: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=81;
   mapp<=16;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4803;
 end   
18'd13605: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=64;
   mapp<=16;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5148;
 end   
18'd13606: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=40;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3194;
 end   
18'd13607: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=86;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4943;
 end   
18'd13608: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=21;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd13609: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd13610: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=21;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd13611: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=64;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd13612: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd13613: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5458;
 end   
18'd13614: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5458;
 end   
18'd13615: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5458;
 end   
18'd13616: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5458;
 end   
18'd13742: begin  
rid<=1;
end
18'd13743: begin  
end
18'd13744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd13745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd13746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd13747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd13748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd13749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd13750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd13751: begin  
rid<=0;
end
18'd13801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=23;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6175;
 end   
18'd13802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=31;
   mapp<=73;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3404;
 end   
18'd13803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=6;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6259;
 end   
18'd13804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=68;
   mapp<=41;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7152;
 end   
18'd13805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=18;
   mapp<=45;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5066;
 end   
18'd13806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=2;
   mapp<=62;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6826;
 end   
18'd13807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=7;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd13808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=7;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd13809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd13810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=12;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd13811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=36;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd13812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd13813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6175;
 end   
18'd13814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6175;
 end   
18'd13815: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6175;
 end   
18'd13816: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6175;
 end   
18'd13817: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6175;
 end   
18'd13942: begin  
rid<=1;
end
18'd13943: begin  
end
18'd13944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd13945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd13946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd13947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd13948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd13949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd13950: begin  
rid<=0;
end
18'd14001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=91;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3563;
 end   
18'd14002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=12;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11116;
 end   
18'd14003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=31;
   mapp<=56;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9079;
 end   
18'd14004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=90;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=12312;
 end   
18'd14005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=93;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=11267;
 end   
18'd14006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=96;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=11084;
 end   
18'd14007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=52;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=6835;
 end   
18'd14008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=54;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=5772;
 end   
18'd14009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=45;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=5759;
 end   
18'd14010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd14011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd14012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd14013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3563;
 end   
18'd14014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3563;
 end   
18'd14142: begin  
rid<=1;
end
18'd14143: begin  
end
18'd14144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd14145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd14146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd14147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd14148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd14149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd14150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd14151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd14152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd14153: begin  
rid<=0;
end
18'd14201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=23;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18629;
 end   
18'd14202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=18;
   mapp<=22;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23482;
 end   
18'd14203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=66;
   mapp<=4;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20335;
 end   
18'd14204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=59;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd14205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=98;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd14206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=86;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd14207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd14208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd14209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd14210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd14211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd14212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd14213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18629;
 end   
18'd14214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18629;
 end   
18'd14342: begin  
rid<=1;
end
18'd14343: begin  
end
18'd14344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd14345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd14346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd14347: begin  
rid<=0;
end
18'd14401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=98;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14174;
 end   
18'd14402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=30;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13472;
 end   
18'd14403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=92;
   mapp<=22;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13970;
 end   
18'd14404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=46;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14368;
 end   
18'd14405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=78;
   mapp<=92;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16990;
 end   
18'd14406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=37;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8906;
 end   
18'd14407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=25;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=9802;
 end   
18'd14408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd14409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd14410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd14411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd14412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd14413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14174;
 end   
18'd14414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14174;
 end   
18'd14415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14174;
 end   
18'd14416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14174;
 end   
18'd14542: begin  
rid<=1;
end
18'd14543: begin  
end
18'd14544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd14545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd14546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd14547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd14548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd14549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd14550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd14551: begin  
rid<=0;
end
18'd14601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=97;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11482;
 end   
18'd14602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=28;
   mapp<=82;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12909;
 end   
18'd14603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=51;
   mapp<=40;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11147;
 end   
18'd14604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=16;
   mapp<=15;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8899;
 end   
18'd14605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=30;
   mapp<=75;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=15954;
 end   
18'd14606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=62;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=11868;
 end   
18'd14607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd14608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd14609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd14610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd14611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd14612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd14613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11482;
 end   
18'd14614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11482;
 end   
18'd14615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11482;
 end   
18'd14742: begin  
rid<=1;
end
18'd14743: begin  
end
18'd14744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd14745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd14746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd14747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd14748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd14749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd14750: begin  
rid<=0;
end
18'd14801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=62;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16569;
 end   
18'd14802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=55;
   mapp<=29;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17501;
 end   
18'd14803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=75;
   mapp<=20;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18460;
 end   
18'd14804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=92;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd14805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=61;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd14806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=54;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd14807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=98;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd14808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=46;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd14809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd14810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd14811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd14812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd14813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16569;
 end   
18'd14814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16569;
 end   
18'd14942: begin  
rid<=1;
end
18'd14943: begin  
end
18'd14944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd14945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd14946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd14947: begin  
rid<=0;
end
18'd15001: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=63;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11289;
 end   
18'd15002: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=75;
   mapp<=69;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8443;
 end   
18'd15003: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=15;
   mapp<=38;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5639;
 end   
18'd15004: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=21;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7623;
 end   
18'd15005: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=75;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8739;
 end   
18'd15006: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=15;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4594;
 end   
18'd15007: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=28;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd15008: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=34;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd15009: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd15010: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd15011: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd15142: begin  
rid<=1;
end
18'd15143: begin  
end
18'd15144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd15145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd15146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd15147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd15148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd15149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd15150: begin  
rid<=0;
end
18'd15201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=50;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7241;
 end   
18'd15202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=33;
   mapp<=57;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6671;
 end   
18'd15203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=25;
   mapp<=62;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6223;
 end   
18'd15204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=10;
   mapp<=61;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5787;
 end   
18'd15205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=24;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4882;
 end   
18'd15206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=49;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5757;
 end   
18'd15207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd15208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd15209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd15210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd15211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd15212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd15213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7241;
 end   
18'd15342: begin  
rid<=1;
end
18'd15343: begin  
end
18'd15344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd15345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd15346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd15347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd15348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd15349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd15350: begin  
rid<=0;
end
18'd15401: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=14;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5510;
 end   
18'd15402: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=64;
   mapp<=78;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7054;
 end   
18'd15403: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=93;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=3626;
 end   
18'd15404: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd15405: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd15406: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd15542: begin  
rid<=1;
end
18'd15543: begin  
end
18'd15544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd15545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd15546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd15547: begin  
rid<=0;
end
18'd15601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=85;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13034;
 end   
18'd15602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=52;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13421;
 end   
18'd15603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=73;
   mapp<=37;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18814;
 end   
18'd15604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=52;
   mapp<=4;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16257;
 end   
18'd15605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=94;
   mapp<=37;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=20719;
 end   
18'd15606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=76;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd15607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=26;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd15608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd15609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd15610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd15611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd15612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd15613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13034;
 end   
18'd15742: begin  
rid<=1;
end
18'd15743: begin  
end
18'd15744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd15745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd15746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd15747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd15748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd15749: begin  
rid<=0;
end
18'd15801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=41;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8425;
 end   
18'd15802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=89;
   mapp<=40;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11447;
 end   
18'd15803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=19;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd15804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=65;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd15805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=5;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd15806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd15807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd15808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd15809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd15810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd15811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd15942: begin  
rid<=1;
end
18'd15943: begin  
end
18'd15944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd15945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd15946: begin  
rid<=0;
end
18'd16001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=9;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1305;
 end   
18'd16002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6225;
 end   
18'd16003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=95;
   mapp<=9;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6371;
 end   
18'd16004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=64;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=9441;
 end   
18'd16005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=66;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=7664;
 end   
18'd16006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd16007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd16008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd16009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd16010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd16142: begin  
rid<=1;
end
18'd16143: begin  
end
18'd16144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd16145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd16146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd16147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd16148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd16149: begin  
rid<=0;
end
18'd16201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=31;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8555;
 end   
18'd16202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=68;
   mapp<=72;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8374;
 end   
18'd16203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=26;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd16204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd16205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd16206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd16207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd16342: begin  
rid<=1;
end
18'd16343: begin  
end
18'd16344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd16345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd16346: begin  
rid<=0;
end
18'd16401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=2;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16756;
 end   
18'd16402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=55;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18453;
 end   
18'd16403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=60;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=22738;
 end   
18'd16404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=74;
   mapp<=52;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=23296;
 end   
18'd16405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=72;
   mapp<=82;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=22317;
 end   
18'd16406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=21;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd16407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd16408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd16409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd16410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd16411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd16412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd16413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16756;
 end   
18'd16414: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16756;
 end   
18'd16415: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16756;
 end   
18'd16416: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16756;
 end   
18'd16542: begin  
rid<=1;
end
18'd16543: begin  
end
18'd16544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd16545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd16546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd16547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd16548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd16549: begin  
rid<=0;
end
18'd16601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=12;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14415;
 end   
18'd16602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=72;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11041;
 end   
18'd16603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=39;
   mapp<=5;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15850;
 end   
18'd16604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=28;
   mapp<=95;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16762;
 end   
18'd16605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=12;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd16606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=62;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd16607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd16608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd16609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd16610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd16611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd16612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd16613: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14415;
 end   
18'd16614: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14415;
 end   
18'd16615: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14415;
 end   
18'd16742: begin  
rid<=1;
end
18'd16743: begin  
end
18'd16744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd16745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd16746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd16747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd16748: begin  
rid<=0;
end
18'd16801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=86;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5899;
 end   
18'd16802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=19;
   mapp<=8;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4392;
 end   
18'd16803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=58;
   mapp<=23;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5550;
 end   
18'd16804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=45;
   mapp<=59;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4917;
 end   
18'd16805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=6;
   mapp<=34;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8087;
 end   
18'd16806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=66;
   mapp<=4;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=11095;
 end   
18'd16807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd16808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd16809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=92;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd16810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd16811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=32;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd16812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd16813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5899;
 end   
18'd16814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5899;
 end   
18'd16815: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5899;
 end   
18'd16816: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5899;
 end   
18'd16817: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5899;
 end   
18'd16942: begin  
rid<=1;
end
18'd16943: begin  
end
18'd16944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd16945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd16946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd16947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd16948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd16949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd16950: begin  
rid<=0;
end
18'd17001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=18;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=27416;
 end   
18'd17002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=76;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd17003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=20;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd17004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=11;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd17005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=82;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd17006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=56;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd17007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=90;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd17008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=25;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd17009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=24;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd17010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=86;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd17011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd17012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd17013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17018: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17019: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17020: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27416;
 end   
18'd17142: begin  
rid<=1;
end
18'd17143: begin  
end
18'd17144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd17145: begin  
rid<=0;
end
18'd17201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=26;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19205;
 end   
18'd17202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=71;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18778;
 end   
18'd17203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=97;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd17204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=12;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd17205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=3;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd17206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=27;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd17207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=8;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd17208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=45;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd17209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=8;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd17210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd17211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd17212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd17213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17218: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17219: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19205;
 end   
18'd17342: begin  
rid<=1;
end
18'd17343: begin  
end
18'd17344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd17345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd17346: begin  
rid<=0;
end
18'd17401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=1;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2551;
 end   
18'd17402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=50;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3207;
 end   
18'd17403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=28;
   mapp<=13;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2179;
 end   
18'd17404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=11;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3224;
 end   
18'd17405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5193;
 end   
18'd17406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=49;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6521;
 end   
18'd17407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=92;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6683;
 end   
18'd17408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=54;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6088;
 end   
18'd17409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=69;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=6961;
 end   
18'd17410: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd17411: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=65;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd17412: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd17413: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2551;
 end   
18'd17414: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2551;
 end   
18'd17542: begin  
rid<=1;
end
18'd17543: begin  
end
18'd17544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd17545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd17546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd17547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd17548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd17549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd17550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd17551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd17552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd17553: begin  
rid<=0;
end
18'd17601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=42;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17108;
 end   
18'd17602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=77;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14626;
 end   
18'd17603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=77;
   mapp<=72;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10968;
 end   
18'd17604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=70;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd17605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd17606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd17607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd17608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd17609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd17610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd17742: begin  
rid<=1;
end
18'd17743: begin  
end
18'd17744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd17745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd17746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd17747: begin  
rid<=0;
end
18'd17801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=10;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26308;
 end   
18'd17802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=82;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd17803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=58;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd17804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=26;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd17805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=87;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd17806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=70;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd17807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=28;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd17808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=51;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd17809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=58;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd17810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=13;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd17811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd17812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd17813: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17814: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17815: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17816: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17817: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17818: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17819: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17820: begin  
  clrr<=0;
  maplen<=10;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26308;
 end   
18'd17942: begin  
rid<=1;
end
18'd17943: begin  
end
18'd17944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd17945: begin  
rid<=0;
end
18'd18001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=34;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6918;
 end   
18'd18002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=41;
   mapp<=42;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10966;
 end   
18'd18003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=18;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8108;
 end   
18'd18004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=3;
   mapp<=72;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8756;
 end   
18'd18005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=67;
   mapp<=28;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16340;
 end   
18'd18006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=65;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=13550;
 end   
18'd18007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=38;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=11292;
 end   
18'd18008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd18009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=57;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd18010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd18011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=14;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd18012: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd18013: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6918;
 end   
18'd18014: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6918;
 end   
18'd18015: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6918;
 end   
18'd18016: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6918;
 end   
18'd18142: begin  
rid<=1;
end
18'd18143: begin  
end
18'd18144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd18145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd18146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd18147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd18148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd18149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd18150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd18151: begin  
rid<=0;
end
18'd18201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=86;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10664;
 end   
18'd18202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=86;
   mapp<=63;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10244;
 end   
18'd18203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=56;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5438;
 end   
18'd18204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=7;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7340;
 end   
18'd18205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=78;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=14402;
 end   
18'd18206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=89;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=10714;
 end   
18'd18207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=35;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=8660;
 end   
18'd18208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=65;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=12110;
 end   
18'd18209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd18210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd18211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd18342: begin  
rid<=1;
end
18'd18343: begin  
end
18'd18344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd18345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd18346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd18347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd18348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd18349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd18350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd18351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd18352: begin  
rid<=0;
end
18'd18401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=28;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=840;
 end   
18'd18402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1354;
 end   
18'd18403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd18542: begin  
rid<=1;
end
18'd18543: begin  
end
18'd18544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd18545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd18546: begin  
rid<=0;
end
18'd18601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=35;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2060;
 end   
18'd18602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=10;
   mapp<=66;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6944;
 end   
18'd18603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=99;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6422;
 end   
18'd18604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd18605: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd18606: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd18742: begin  
rid<=1;
end
18'd18743: begin  
end
18'd18744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd18745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd18746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd18747: begin  
rid<=0;
end
18'd18801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=44;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6672;
 end   
18'd18802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=94;
   mapp<=52;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6646;
 end   
18'd18803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=8;
   mapp<=69;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6191;
 end   
18'd18804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=52;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6138;
 end   
18'd18805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=47;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd18806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=32;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd18807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd18808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd18809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd18942: begin  
rid<=1;
end
18'd18943: begin  
end
18'd18944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd18945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd18946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd18947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd18948: begin  
rid<=0;
end
18'd19001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=23;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11218;
 end   
18'd19002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=51;
   mapp<=97;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8555;
 end   
18'd19003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=74;
   mapp<=43;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5971;
 end   
18'd19004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=33;
   mapp<=49;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7893;
 end   
18'd19005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=15;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=9062;
 end   
18'd19006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=41;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5928;
 end   
18'd19007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=89;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4579;
 end   
18'd19008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd19009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd19010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd19011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd19012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd19013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11218;
 end   
18'd19014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11218;
 end   
18'd19142: begin  
rid<=1;
end
18'd19143: begin  
end
18'd19144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd19145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd19146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd19147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd19148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd19149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd19150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd19151: begin  
rid<=0;
end
18'd19201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=78;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18990;
 end   
18'd19202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=31;
   mapp<=90;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19097;
 end   
18'd19203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=44;
   mapp<=97;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18316;
 end   
18'd19204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=40;
   mapp<=19;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=26738;
 end   
18'd19205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=87;
   mapp<=80;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=20690;
 end   
18'd19206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=99;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd19207: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=25;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd19208: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=83;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd19209: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=38;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd19210: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd19211: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd19212: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd19213: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18990;
 end   
18'd19214: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18990;
 end   
18'd19342: begin  
rid<=1;
end
18'd19343: begin  
end
18'd19344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd19345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd19346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd19347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd19348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd19349: begin  
rid<=0;
end
18'd19401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=60;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3120;
 end   
18'd19402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=11;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=670;
 end   
18'd19403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd19542: begin  
rid<=1;
end
18'd19543: begin  
end
18'd19544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd19545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd19546: begin  
rid<=0;
end
18'd19601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=92;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14315;
 end   
18'd19602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=10;
   mapp<=85;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10470;
 end   
18'd19603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=49;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10431;
 end   
18'd19604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=78;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd19605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd19606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd19607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd19608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd19609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd19610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd19742: begin  
rid<=1;
end
18'd19743: begin  
end
18'd19744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd19745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd19746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd19747: begin  
rid<=0;
end
18'd19801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=82;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=31746;
 end   
18'd19802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=78;
   mapp<=73;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=27384;
 end   
18'd19803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=59;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd19804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=18;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd19805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=89;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd19806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=59;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd19807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=49;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd19808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd19809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd19810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd19811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd19812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd19813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=31746;
 end   
18'd19814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=31746;
 end   
18'd19815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=31746;
 end   
18'd19942: begin  
rid<=1;
end
18'd19943: begin  
end
18'd19944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd19945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd19946: begin  
rid<=0;
end
18'd20001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=11;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21680;
 end   
18'd20002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=19;
   mapp<=8;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15336;
 end   
18'd20003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=61;
   mapp<=67;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=22371;
 end   
18'd20004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=56;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd20005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=90;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd20006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=63;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd20007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=83;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd20008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=16;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd20009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=32;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd20010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd20011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd20012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd20013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20020: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21680;
 end   
18'd20142: begin  
rid<=1;
end
18'd20143: begin  
end
18'd20144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd20145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd20146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd20147: begin  
rid<=0;
end
18'd20201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=98;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11102;
 end   
18'd20202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=32;
   mapp<=13;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11620;
 end   
18'd20203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=87;
   mapp<=62;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14388;
 end   
18'd20204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=96;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=12663;
 end   
18'd20205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=60;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6748;
 end   
18'd20206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=15;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=10261;
 end   
18'd20207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=4;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=6752;
 end   
18'd20208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=17884;
 end   
18'd20209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd20210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd20211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd20212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd20213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11102;
 end   
18'd20342: begin  
rid<=1;
end
18'd20343: begin  
end
18'd20344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd20345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd20346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd20347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd20348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd20349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd20350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd20351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd20352: begin  
rid<=0;
end
18'd20401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=41;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4619;
 end   
18'd20402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=82;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd20403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=49;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd20404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd20405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd20406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd20542: begin  
rid<=1;
end
18'd20543: begin  
end
18'd20544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd20545: begin  
rid<=0;
end
18'd20601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=16;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1718;
 end   
18'd20602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=78;
   mapp<=21;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7756;
 end   
18'd20603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=95;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=9028;
 end   
18'd20604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd20605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd20606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd20742: begin  
rid<=1;
end
18'd20743: begin  
end
18'd20744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd20745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd20746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd20747: begin  
rid<=0;
end
18'd20801: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=29;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13215;
 end   
18'd20802: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=81;
   mapp<=77;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16455;
 end   
18'd20803: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=95;
   mapp<=50;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15707;
 end   
18'd20804: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=78;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd20805: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=76;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd20806: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=53;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd20807: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd20808: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd20809: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd20810: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd20942: begin  
rid<=1;
end
18'd20943: begin  
end
18'd20944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd20945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd20946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd20947: begin  
rid<=0;
end
18'd21001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=22;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12494;
 end   
18'd21002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=48;
   mapp<=93;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9810;
 end   
18'd21003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=51;
   mapp<=8;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8339;
 end   
18'd21004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=86;
   mapp<=72;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6361;
 end   
18'd21005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=43;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=8940;
 end   
18'd21006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=29;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9558;
 end   
18'd21007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=14;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=14263;
 end   
18'd21008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=68;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=15125;
 end   
18'd21009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd21010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd21011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd21012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd21013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12494;
 end   
18'd21014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12494;
 end   
18'd21015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12494;
 end   
18'd21142: begin  
rid<=1;
end
18'd21143: begin  
end
18'd21144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd21145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd21146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd21147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd21148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd21149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd21150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd21151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd21152: begin  
rid<=0;
end
18'd21201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=15;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1988;
 end   
18'd21202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=49;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1686;
 end   
18'd21203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1239;
 end   
18'd21204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=16;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3896;
 end   
18'd21205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=74;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5609;
 end   
18'd21206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=91;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=4796;
 end   
18'd21207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=69;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1683;
 end   
18'd21208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=12;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=2504;
 end   
18'd21209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=46;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=5327;
 end   
18'd21210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=93;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=5944;
 end   
18'd21211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd21212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd21213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=1988;
 end   
18'd21342: begin  
rid<=1;
end
18'd21343: begin  
end
18'd21344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd21345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd21346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd21347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd21348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd21349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd21350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd21351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd21352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd21353: begin  
check<=expctdoutput[9]-outcheck;
end
18'd21354: begin  
rid<=0;
end
18'd21401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=83;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21909;
 end   
18'd21402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=94;
   mapp<=36;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21304;
 end   
18'd21403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=80;
   mapp<=51;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24100;
 end   
18'd21404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=97;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd21405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=65;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd21406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd21407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd21408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd21409: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd21410: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd21411: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd21412: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd21542: begin  
rid<=1;
end
18'd21543: begin  
end
18'd21544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd21545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd21546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd21547: begin  
rid<=0;
end
18'd21601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=47;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21797;
 end   
18'd21602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=45;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd21603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=70;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd21604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=75;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd21605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=89;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd21606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=50;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd21607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd21608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd21609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd21610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd21611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd21612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd21742: begin  
rid<=1;
end
18'd21743: begin  
end
18'd21744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd21745: begin  
rid<=0;
end
18'd21801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=14;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=910;
 end   
18'd21802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd21942: begin  
rid<=1;
end
18'd21943: begin  
end
18'd21944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd21945: begin  
rid<=0;
end
18'd22001: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=67;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4256;
 end   
18'd22002: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=22;
   mapp<=96;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8586;
 end   
18'd22003: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd22004: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd22005: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd22142: begin  
rid<=1;
end
18'd22143: begin  
end
18'd22144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd22145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd22146: begin  
rid<=0;
end
18'd22201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=76;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18559;
 end   
18'd22202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=59;
   mapp<=87;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24757;
 end   
18'd22203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=89;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd22204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=22;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd22205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=66;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd22206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=86;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd22207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=55;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd22208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=28;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd22209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=14;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd22210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd22211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd22212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd22213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22218: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22219: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18559;
 end   
18'd22342: begin  
rid<=1;
end
18'd22343: begin  
end
18'd22344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd22345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd22346: begin  
rid<=0;
end
18'd22401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=21;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9454;
 end   
18'd22402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=96;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11408;
 end   
18'd22403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=81;
   mapp<=3;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13197;
 end   
18'd22404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=21;
   mapp<=61;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=17419;
 end   
18'd22405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=55;
   mapp<=31;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=15385;
 end   
18'd22406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=82;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=17895;
 end   
18'd22407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd22408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd22409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd22410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd22411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd22412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd22413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9454;
 end   
18'd22414: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9454;
 end   
18'd22415: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9454;
 end   
18'd22542: begin  
rid<=1;
end
18'd22543: begin  
end
18'd22544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd22545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd22546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd22547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd22548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd22549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd22550: begin  
rid<=0;
end
18'd22601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=35;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=28253;
 end   
18'd22602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=43;
   mapp<=35;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=28031;
 end   
18'd22603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=88;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd22604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=53;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd22605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=32;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd22606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=47;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd22607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=80;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd22608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=26;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd22609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=78;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd22610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd22611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd22612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd22613: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22614: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22615: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22616: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22617: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22618: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22619: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28253;
 end   
18'd22742: begin  
rid<=1;
end
18'd22743: begin  
end
18'd22744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd22745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd22746: begin  
rid<=0;
end
18'd22801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=73;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14447;
 end   
18'd22802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=74;
   mapp<=55;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9487;
 end   
18'd22803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=50;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9453;
 end   
18'd22804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=16;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=9650;
 end   
18'd22805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=73;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=12133;
 end   
18'd22806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd22807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd22808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd22809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd22810: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd22942: begin  
rid<=1;
end
18'd22943: begin  
end
18'd22944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd22945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd22946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd22947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd22948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd22949: begin  
rid<=0;
end
18'd23001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=47;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18604;
 end   
18'd23002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=90;
   mapp<=99;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14125;
 end   
18'd23003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=71;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11423;
 end   
18'd23004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=5;
   mapp<=43;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=18990;
 end   
18'd23005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=72;
   mapp<=65;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=12903;
 end   
18'd23006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=72;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=17327;
 end   
18'd23007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=29;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=15777;
 end   
18'd23008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd23009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd23010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd23011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd23012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd23013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18604;
 end   
18'd23014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18604;
 end   
18'd23015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18604;
 end   
18'd23016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18604;
 end   
18'd23142: begin  
rid<=1;
end
18'd23143: begin  
end
18'd23144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd23145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd23146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd23147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd23148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd23149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd23150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd23151: begin  
rid<=0;
end
18'd23201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=58;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7391;
 end   
18'd23202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=93;
   mapp<=65;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4678;
 end   
18'd23203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=6;
   mapp<=31;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6698;
 end   
18'd23204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=78;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4896;
 end   
18'd23205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=48;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=3591;
 end   
18'd23206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=6;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6831;
 end   
18'd23207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd23208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd23209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd23210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd23211: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd23342: begin  
rid<=1;
end
18'd23343: begin  
end
18'd23344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd23345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd23346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd23347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd23348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd23349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd23350: begin  
rid<=0;
end
18'd23401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=15;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23197;
 end   
18'd23402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=26;
   mapp<=94;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=29271;
 end   
18'd23403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=84;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=28492;
 end   
18'd23404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=68;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd23405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=6;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd23406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=28;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd23407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=97;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd23408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=18;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd23409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=90;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd23410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=99;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd23411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=85;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd23412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd23413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23416: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23417: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23418: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23419: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23420: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23197;
 end   
18'd23542: begin  
rid<=1;
end
18'd23543: begin  
end
18'd23544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd23545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd23546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd23547: begin  
rid<=0;
end
18'd23601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=44;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3422;
 end   
18'd23602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=86;
   mapp<=10;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9842;
 end   
18'd23603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=7;
   mapp<=71;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9953;
 end   
18'd23604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=60;
   mapp<=13;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5727;
 end   
18'd23605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=27;
   mapp<=15;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=13773;
 end   
18'd23606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=85;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9567;
 end   
18'd23607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=18;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=14318;
 end   
18'd23608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd23609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd23610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd23611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd23612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd23613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3422;
 end   
18'd23614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3422;
 end   
18'd23615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3422;
 end   
18'd23616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3422;
 end   
18'd23742: begin  
rid<=1;
end
18'd23743: begin  
end
18'd23744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd23745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd23746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd23747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd23748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd23749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd23750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd23751: begin  
rid<=0;
end
18'd23801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=93;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13387;
 end   
18'd23802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=85;
   mapp<=71;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7805;
 end   
18'd23803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=37;
   mapp<=68;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2997;
 end   
18'd23804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=11;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6122;
 end   
18'd23805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=4;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6123;
 end   
18'd23806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=77;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=9104;
 end   
18'd23807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=6;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6696;
 end   
18'd23808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=68;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6052;
 end   
18'd23809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=22;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd23810: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd23811: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd23812: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd23813: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13387;
 end   
18'd23942: begin  
rid<=1;
end
18'd23943: begin  
end
18'd23944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd23945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd23946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd23947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd23948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd23949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd23950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd23951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd23952: begin  
rid<=0;
end
18'd24001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=93;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17644;
 end   
18'd24002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=84;
   mapp<=38;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21150;
 end   
18'd24003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=87;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=23434;
 end   
18'd24004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=61;
   mapp<=55;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=21651;
 end   
18'd24005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd24006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd24007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd24008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd24009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd24010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd24011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd24142: begin  
rid<=1;
end
18'd24143: begin  
end
18'd24144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd24145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd24146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd24147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd24148: begin  
rid<=0;
end
18'd24201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=82;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=82;
 end   
18'd24202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd24342: begin  
rid<=1;
end
18'd24343: begin  
end
18'd24344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd24345: begin  
rid<=0;
end
18'd24401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=4;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=212;
 end   
18'd24402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=84;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4462;
 end   
18'd24403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd24542: begin  
rid<=1;
end
18'd24543: begin  
end
18'd24544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd24545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd24546: begin  
rid<=0;
end
18'd24601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=11;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17687;
 end   
18'd24602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=13;
   mapp<=64;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17586;
 end   
18'd24603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=68;
   mapp<=81;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18586;
 end   
18'd24604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=51;
   mapp<=72;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=20149;
 end   
18'd24605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=16;
   mapp<=6;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=20725;
 end   
18'd24606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=79;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd24607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=68;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd24608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd24609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd24610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd24611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd24612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd24613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17687;
 end   
18'd24742: begin  
rid<=1;
end
18'd24743: begin  
end
18'd24744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd24745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd24746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd24747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd24748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd24749: begin  
rid<=0;
end
18'd24801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=63;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6740;
 end   
18'd24802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=59;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6144;
 end   
18'd24803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=53;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4613;
 end   
18'd24804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=36;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8723;
 end   
18'd24805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=95;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8310;
 end   
18'd24806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=65;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd24807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd24808: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd24942: begin  
rid<=1;
end
18'd24943: begin  
end
18'd24944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd24945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd24946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd24947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd24948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd24949: begin  
rid<=0;
end
18'd25001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=8;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10521;
 end   
18'd25002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=59;
   mapp<=80;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11432;
 end   
18'd25003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=56;
   mapp<=76;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11172;
 end   
18'd25004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=2;
   mapp<=55;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11517;
 end   
18'd25005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=32;
   mapp<=25;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16310;
 end   
18'd25006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=5;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd25007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=40;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd25008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=75;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd25009: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd25010: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=85;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd25011: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd25012: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd25013: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10521;
 end   
18'd25014: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10521;
 end   
18'd25015: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10521;
 end   
18'd25016: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10521;
 end   
18'd25142: begin  
rid<=1;
end
18'd25143: begin  
end
18'd25144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd25145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd25146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd25147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd25148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd25149: begin  
rid<=0;
end
18'd25201: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=58;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17477;
 end   
18'd25202: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=93;
   mapp<=97;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12782;
 end   
18'd25203: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=40;
   mapp<=2;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11544;
 end   
18'd25204: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=46;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd25205: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=74;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd25206: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd25207: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd25208: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd25209: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd25210: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd25211: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd25212: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd25342: begin  
rid<=1;
end
18'd25343: begin  
end
18'd25344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd25345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd25346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd25347: begin  
rid<=0;
end
18'd25401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=72;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5760;
 end   
18'd25402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd25403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd25404: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd25542: begin  
rid<=1;
end
18'd25543: begin  
end
18'd25544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd25545: begin  
rid<=0;
end
18'd25601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=68;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15576;
 end   
18'd25602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=15;
   mapp<=41;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7865;
 end   
18'd25603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=96;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9145;
 end   
18'd25604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=25;
   mapp<=81;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6021;
 end   
18'd25605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=9;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8749;
 end   
18'd25606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=12;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=12180;
 end   
18'd25607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=13630;
 end   
18'd25608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=55;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd25609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd25610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=43;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd25611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd25612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd25613: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15576;
 end   
18'd25614: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15576;
 end   
18'd25742: begin  
rid<=1;
end
18'd25743: begin  
end
18'd25744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd25745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd25746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd25747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd25748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd25749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd25750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd25751: begin  
rid<=0;
end
18'd25801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=14;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11043;
 end   
18'd25802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=50;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11239;
 end   
18'd25803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=90;
   mapp<=48;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13005;
 end   
18'd25804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=35;
   mapp<=18;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7414;
 end   
18'd25805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=59;
   mapp<=68;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10843;
 end   
18'd25806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=69;
   mapp<=17;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=10627;
 end   
18'd25807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=95;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd25808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=3;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd25809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=40;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd25810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=79;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd25811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=99;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd25812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd25813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11043;
 end   
18'd25814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11043;
 end   
18'd25815: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11043;
 end   
18'd25816: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11043;
 end   
18'd25817: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11043;
 end   
18'd25942: begin  
rid<=1;
end
18'd25943: begin  
end
18'd25944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd25945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd25946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd25947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd25948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd25949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd25950: begin  
rid<=0;
end
18'd26001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=14;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=22580;
 end   
18'd26002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=18;
   mapp<=81;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24011;
 end   
18'd26003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=44;
   mapp<=52;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20207;
 end   
18'd26004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=63;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd26005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=29;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd26006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=52;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd26007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=64;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd26008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=69;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd26009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=70;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd26010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd26011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd26012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd26013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26020: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22580;
 end   
18'd26142: begin  
rid<=1;
end
18'd26143: begin  
end
18'd26144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd26145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd26146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd26147: begin  
rid<=0;
end
18'd26201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=26;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9056;
 end   
18'd26202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=76;
   mapp<=87;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9155;
 end   
18'd26203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=23;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5662;
 end   
18'd26204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=40;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10663;
 end   
18'd26205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=79;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd26206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd26207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd26342: begin  
rid<=1;
end
18'd26343: begin  
end
18'd26344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd26345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd26346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd26347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd26348: begin  
rid<=0;
end
18'd26401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=62;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21765;
 end   
18'd26402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=35;
   mapp<=71;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=27030;
 end   
18'd26403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=87;
   mapp<=45;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=28110;
 end   
18'd26404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=96;
   mapp<=21;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=30991;
 end   
18'd26405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=33;
   mapp<=70;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=30044;
 end   
18'd26406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=88;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd26407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=35;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd26408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd26409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd26410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd26411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd26412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd26413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26417: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26418: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21765;
 end   
18'd26542: begin  
rid<=1;
end
18'd26543: begin  
end
18'd26544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd26545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd26546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd26547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd26548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd26549: begin  
rid<=0;
end
18'd26601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=65;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5912;
 end   
18'd26602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=1;
   mapp<=62;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=410;
 end   
18'd26603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=5;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=904;
 end   
18'd26604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=7;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4814;
 end   
18'd26605: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10348;
 end   
18'd26606: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=69;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=8368;
 end   
18'd26607: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=34;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=7522;
 end   
18'd26608: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=71;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=9994;
 end   
18'd26609: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=57;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=11286;
 end   
18'd26610: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=98;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=11700;
 end   
18'd26611: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=45;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd26612: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd26613: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5912;
 end   
18'd26742: begin  
rid<=1;
end
18'd26743: begin  
end
18'd26744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd26745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd26746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd26747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd26748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd26749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd26750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd26751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd26752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd26753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd26754: begin  
rid<=0;
end
18'd26801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=72;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5508;
 end   
18'd26802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=63;
   mapp<=44;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3636;
 end   
18'd26803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=28;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3900;
 end   
18'd26804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=64;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2506;
 end   
18'd26805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=1;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1090;
 end   
18'd26806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=23;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4884;
 end   
18'd26807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=90;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd26808: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd26809: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd26942: begin  
rid<=1;
end
18'd26943: begin  
end
18'd26944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd26945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd26946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd26947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd26948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd26949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd26950: begin  
rid<=0;
end
18'd27001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=63;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9085;
 end   
18'd27002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=1;
   mapp<=97;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12695;
 end   
18'd27003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=63;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11229;
 end   
18'd27004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=21;
   mapp<=71;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12029;
 end   
18'd27005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=65;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8682;
 end   
18'd27006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=21;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=12647;
 end   
18'd27007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=45;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=13896;
 end   
18'd27008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=10;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd27009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=95;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd27010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=41;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd27011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd27012: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd27013: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9085;
 end   
18'd27014: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9085;
 end   
18'd27142: begin  
rid<=1;
end
18'd27143: begin  
end
18'd27144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd27145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd27146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd27147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd27148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd27149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd27150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd27151: begin  
rid<=0;
end
18'd27201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=54;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2754;
 end   
18'd27202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=820;
 end   
18'd27203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=55;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2990;
 end   
18'd27204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=93;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5052;
 end   
18'd27205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=38;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2092;
 end   
18'd27206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=79;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=4316;
 end   
18'd27207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=82;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4488;
 end   
18'd27208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=8;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=502;
 end   
18'd27209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd27342: begin  
rid<=1;
end
18'd27343: begin  
end
18'd27344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd27345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd27346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd27347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd27348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd27349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd27350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd27351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd27352: begin  
rid<=0;
end
18'd27401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=4;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10110;
 end   
18'd27402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=23;
   mapp<=38;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7762;
 end   
18'd27403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=25;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd27404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=78;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd27405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=24;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd27406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd27407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd27408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd27409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd27410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd27411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd27542: begin  
rid<=1;
end
18'd27543: begin  
end
18'd27544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd27545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd27546: begin  
rid<=0;
end
18'd27601: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=87;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7156;
 end   
18'd27602: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=45;
   mapp<=23;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8708;
 end   
18'd27603: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=5;
   mapp<=94;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9671;
 end   
18'd27604: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=16;
   mapp<=30;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14112;
 end   
18'd27605: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=50;
   mapp<=46;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10809;
 end   
18'd27606: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=89;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=15295;
 end   
18'd27607: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=38;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd27608: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=63;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd27609: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=35;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd27610: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=97;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd27611: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd27612: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd27613: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7156;
 end   
18'd27614: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7156;
 end   
18'd27615: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7156;
 end   
18'd27742: begin  
rid<=1;
end
18'd27743: begin  
end
18'd27744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd27745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd27746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd27747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd27748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd27749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd27750: begin  
rid<=0;
end
18'd27801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=37;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1480;
 end   
18'd27802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=74;
   mapp<=8;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1946;
 end   
18'd27803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=20;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1076;
 end   
18'd27804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=72;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2502;
 end   
18'd27805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=93;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd27806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd27807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd27942: begin  
rid<=1;
end
18'd27943: begin  
end
18'd27944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd27945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd27946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd27947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd27948: begin  
rid<=0;
end
18'd28001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=19;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3647;
 end   
18'd28002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=41;
   mapp<=56;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4008;
 end   
18'd28003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=32;
   mapp<=6;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5978;
 end   
18'd28004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=84;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7325;
 end   
18'd28005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd28006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd28007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd28008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd28009: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd28142: begin  
rid<=1;
end
18'd28143: begin  
end
18'd28144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd28145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd28146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd28147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd28148: begin  
rid<=0;
end
18'd28201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=83;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6557;
 end   
18'd28202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=67;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5303;
 end   
18'd28203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=36;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2864;
 end   
18'd28204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=25;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2005;
 end   
18'd28205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=18;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1462;
 end   
18'd28206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=37;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2973;
 end   
18'd28207: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=28;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2272;
 end   
18'd28208: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=19;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1571;
 end   
18'd28209: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=77;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=6163;
 end   
18'd28210: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd28342: begin  
rid<=1;
end
18'd28343: begin  
end
18'd28344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd28345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd28346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd28347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd28348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd28349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd28350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd28351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd28352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd28353: begin  
rid<=0;
end
18'd28401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=60;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3360;
 end   
18'd28402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=95;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=5710;
 end   
18'd28403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd28542: begin  
rid<=1;
end
18'd28543: begin  
end
18'd28544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd28545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd28546: begin  
rid<=0;
end
18'd28601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=36;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1152;
 end   
18'd28602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=80;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2570;
 end   
18'd28603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=75;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2420;
 end   
18'd28604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=7;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=254;
 end   
18'd28605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=84;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2728;
 end   
18'd28606: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd28742: begin  
rid<=1;
end
18'd28743: begin  
end
18'd28744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd28745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd28746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd28747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd28748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd28749: begin  
rid<=0;
end
18'd28801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=51;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10484;
 end   
18'd28802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=29;
   mapp<=76;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12494;
 end   
18'd28803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=90;
   mapp<=41;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16696;
 end   
18'd28804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=74;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=15893;
 end   
18'd28805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=72;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=17085;
 end   
18'd28806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=91;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=18571;
 end   
18'd28807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=89;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd28808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=87;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd28809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd28810: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd28811: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd28942: begin  
rid<=1;
end
18'd28943: begin  
end
18'd28944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd28945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd28946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd28947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd28948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd28949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd28950: begin  
rid<=0;
end
18'd29001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=39;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20320;
 end   
18'd29002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=68;
   mapp<=53;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15883;
 end   
18'd29003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=98;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12843;
 end   
18'd29004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=83;
   mapp<=81;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14697;
 end   
18'd29005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=39;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd29006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=15;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd29007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd29008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd29009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd29010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd29011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd29012: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd29013: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20320;
 end   
18'd29014: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20320;
 end   
18'd29015: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20320;
 end   
18'd29142: begin  
rid<=1;
end
18'd29143: begin  
end
18'd29144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd29145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd29146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd29147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd29148: begin  
rid<=0;
end
18'd29201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=22;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=572;
 end   
18'd29202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=38;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=998;
 end   
18'd29203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=28;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=748;
 end   
18'd29204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=81;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2136;
 end   
18'd29205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=99;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2614;
 end   
18'd29206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=78;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2078;
 end   
18'd29207: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=91;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2426;
 end   
18'd29208: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=23;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=668;
 end   
18'd29209: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd29342: begin  
rid<=1;
end
18'd29343: begin  
end
18'd29344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd29345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd29346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd29347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd29348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd29349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd29350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd29351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd29352: begin  
rid<=0;
end
18'd29401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=41;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6829;
 end   
18'd29402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=87;
   mapp<=49;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6472;
 end   
18'd29403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=46;
   mapp<=2;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6622;
 end   
18'd29404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=91;
   mapp<=7;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5814;
 end   
18'd29405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=37;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd29406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd29407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd29408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd29409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd29410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd29411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd29412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd29413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6829;
 end   
18'd29542: begin  
rid<=1;
end
18'd29543: begin  
end
18'd29544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd29545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd29546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd29547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd29548: begin  
rid<=0;
end
18'd29601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=95;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20448;
 end   
18'd29602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=66;
   mapp<=26;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17360;
 end   
18'd29603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=60;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24469;
 end   
18'd29604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=38;
   mapp<=77;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=23828;
 end   
18'd29605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=88;
   mapp<=82;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=25515;
 end   
18'd29606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=11;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd29607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=45;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd29608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd29609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd29610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd29611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd29612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd29613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20448;
 end   
18'd29742: begin  
rid<=1;
end
18'd29743: begin  
end
18'd29744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd29745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd29746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd29747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd29748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd29749: begin  
rid<=0;
end
18'd29801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=23;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15896;
 end   
18'd29802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=26;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18229;
 end   
18'd29803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=3;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd29804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=48;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd29805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=51;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd29806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=70;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd29807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=36;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd29808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=58;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd29809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd29810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd29811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd29812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd29813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15896;
 end   
18'd29814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15896;
 end   
18'd29815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15896;
 end   
18'd29816: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15896;
 end   
18'd29817: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15896;
 end   
18'd29942: begin  
rid<=1;
end
18'd29943: begin  
end
18'd29944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd29945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd29946: begin  
rid<=0;
end
18'd30001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=3;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=93;
 end   
18'd30002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=62;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=196;
 end   
18'd30003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=19;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=77;
 end   
18'd30004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=75;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=255;
 end   
18'd30005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=56;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=208;
 end   
18'd30006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=31;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=143;
 end   
18'd30007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=95;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=345;
 end   
18'd30008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=44;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=202;
 end   
18'd30009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=91;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=353;
 end   
18'd30010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd30142: begin  
rid<=1;
end
18'd30143: begin  
end
18'd30144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd30145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd30146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd30147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd30148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd30149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd30150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd30151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd30152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd30153: begin  
rid<=0;
end
18'd30201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=19;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=950;
 end   
18'd30202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=72;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3610;
 end   
18'd30203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=91;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4570;
 end   
18'd30204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=83;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4180;
 end   
18'd30205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=33;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1690;
 end   
18'd30206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=75;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3800;
 end   
18'd30207: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=42;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2160;
 end   
18'd30208: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd30342: begin  
rid<=1;
end
18'd30343: begin  
end
18'd30344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd30345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd30346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd30347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd30348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd30349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd30350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd30351: begin  
rid<=0;
end
18'd30401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=50;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23467;
 end   
18'd30402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=33;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd30403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=22;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd30404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=71;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd30405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=11;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd30406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=90;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd30407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=38;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd30408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=41;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd30409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd30410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd30411: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd30412: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd30413: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23467;
 end   
18'd30414: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23467;
 end   
18'd30415: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23467;
 end   
18'd30416: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23467;
 end   
18'd30542: begin  
rid<=1;
end
18'd30543: begin  
end
18'd30544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd30545: begin  
rid<=0;
end
18'd30601: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=90;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18097;
 end   
18'd30602: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=2;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8891;
 end   
18'd30603: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=68;
   mapp<=79;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13071;
 end   
18'd30604: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=22;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd30605: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=95;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd30606: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=35;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd30607: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=8;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd30608: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd30609: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd30610: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd30611: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd30612: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd30742: begin  
rid<=1;
end
18'd30743: begin  
end
18'd30744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd30745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd30746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd30747: begin  
rid<=0;
end
18'd30801: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=45;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4230;
 end   
18'd30802: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=99;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=4465;
 end   
18'd30803: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=3980;
 end   
18'd30804: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=78;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3540;
 end   
18'd30805: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=42;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1930;
 end   
18'd30806: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=57;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2615;
 end   
18'd30807: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=41;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1905;
 end   
18'd30808: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=47;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=2185;
 end   
18'd30809: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=3185;
 end   
18'd30810: begin  
  clrr<=0;
  maplen<=9;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd30942: begin  
rid<=1;
end
18'd30943: begin  
end
18'd30944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd30945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd30946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd30947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd30948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd30949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd30950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd30951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd30952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd30953: begin  
rid<=0;
end
18'd31001: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=85;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6414;
 end   
18'd31002: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=73;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd31003: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=4;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd31004: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd31005: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd31006: begin  
  clrr<=0;
  maplen<=3;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd31142: begin  
rid<=1;
end
18'd31143: begin  
end
18'd31144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd31145: begin  
rid<=0;
end
18'd31201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=29;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=58;
 end   
18'd31202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=2011;
 end   
18'd31203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1586;
 end   
18'd31204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd31342: begin  
rid<=1;
end
18'd31343: begin  
end
18'd31344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd31345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd31346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd31347: begin  
rid<=0;
end
18'd31401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=18;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11469;
 end   
18'd31402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=65;
   mapp<=30;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14015;
 end   
18'd31403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=63;
   mapp<=44;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12478;
 end   
18'd31404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=52;
   mapp<=44;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11515;
 end   
18'd31405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=73;
   mapp<=49;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=9688;
 end   
18'd31406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=70;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=10343;
 end   
18'd31407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=31;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd31408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=47;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd31409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=11;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd31410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=69;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd31411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd31412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd31413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11469;
 end   
18'd31414: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11469;
 end   
18'd31415: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11469;
 end   
18'd31542: begin  
rid<=1;
end
18'd31543: begin  
end
18'd31544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd31545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd31546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd31547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd31548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd31549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd31550: begin  
rid<=0;
end
18'd31601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=40;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14103;
 end   
18'd31602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=11;
   mapp<=52;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11788;
 end   
18'd31603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=92;
   mapp<=79;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15881;
 end   
18'd31604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=51;
   mapp<=53;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14175;
 end   
18'd31605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=80;
   mapp<=43;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16031;
 end   
18'd31606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=22;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=13428;
 end   
18'd31607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=88;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=11711;
 end   
18'd31608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd31609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd31610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd31611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd31612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd31613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14103;
 end   
18'd31614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14103;
 end   
18'd31615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14103;
 end   
18'd31616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14103;
 end   
18'd31742: begin  
rid<=1;
end
18'd31743: begin  
end
18'd31744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd31745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd31746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd31747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd31748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd31749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd31750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd31751: begin  
rid<=0;
end
18'd31801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=78;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5928;
 end   
18'd31802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=20;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1530;
 end   
18'd31803: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=15;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1160;
 end   
18'd31804: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=48;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3678;
 end   
18'd31805: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=98;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=7488;
 end   
18'd31806: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=79;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6054;
 end   
18'd31807: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=35;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2720;
 end   
18'd31808: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd31942: begin  
rid<=1;
end
18'd31943: begin  
end
18'd31944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd31945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd31946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd31947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd31948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd31949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd31950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd31951: begin  
rid<=0;
end
18'd32001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=73;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4608;
 end   
18'd32002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=41;
   mapp<=2;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2698;
 end   
18'd32003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=62;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5366;
 end   
18'd32004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=20;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4360;
 end   
18'd32005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=70;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6052;
 end   
18'd32006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd32007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd32008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd32142: begin  
rid<=1;
end
18'd32143: begin  
end
18'd32144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd32145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd32146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd32147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd32148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd32149: begin  
rid<=0;
end
18'd32201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=67;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7952;
 end   
18'd32202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=49;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12027;
 end   
18'd32203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=65;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd32204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd32205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd32206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd32207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd32342: begin  
rid<=1;
end
18'd32343: begin  
end
18'd32344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd32345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd32346: begin  
rid<=0;
end
18'd32401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=89;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5993;
 end   
18'd32402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=52;
   mapp<=81;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8275;
 end   
18'd32403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=30;
   mapp<=3;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2687;
 end   
18'd32404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=30;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5086;
 end   
18'd32405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd32406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd32407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd32408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd32409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd32542: begin  
rid<=1;
end
18'd32543: begin  
end
18'd32544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd32545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd32546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd32547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd32548: begin  
rid<=0;
end
18'd32601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=40;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=32114;
 end   
18'd32602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=33;
   mapp<=95;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=34454;
 end   
18'd32603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=37;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd32604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=93;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd32605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=30;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd32606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=74;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd32607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=93;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd32608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=82;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd32609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=3;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd32610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=61;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd32611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd32612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd32613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32619: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32620: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32621: begin  
  clrr<=0;
  maplen<=11;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=32114;
 end   
18'd32742: begin  
rid<=1;
end
18'd32743: begin  
end
18'd32744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd32745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd32746: begin  
rid<=0;
end
18'd32801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=66;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18493;
 end   
18'd32802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=83;
   mapp<=97;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21563;
 end   
18'd32803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=61;
   mapp<=51;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13846;
 end   
18'd32804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=59;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd32805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=45;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd32806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=86;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd32807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd32808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd32809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd32810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd32811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd32812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd32813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18493;
 end   
18'd32814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18493;
 end   
18'd32942: begin  
rid<=1;
end
18'd32943: begin  
end
18'd32944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd32945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd32946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd32947: begin  
rid<=0;
end
18'd33001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=83;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4642;
 end   
18'd33002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=50;
   mapp<=40;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9844;
 end   
18'd33003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=58;
   mapp<=9;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9450;
 end   
18'd33004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=21;
   mapp<=97;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12219;
 end   
18'd33005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=75;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11025;
 end   
18'd33006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd33007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=87;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd33008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd33009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd33010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd33011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd33012: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd33142: begin  
rid<=1;
end
18'd33143: begin  
end
18'd33144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd33145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd33146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd33147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd33148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd33149: begin  
rid<=0;
end
18'd33201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=28;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7409;
 end   
18'd33202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=59;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11064;
 end   
18'd33203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=22;
   mapp<=38;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8802;
 end   
18'd33204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=98;
   mapp<=0;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5206;
 end   
18'd33205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=60;
   mapp<=30;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=7765;
 end   
18'd33206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd33207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd33208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd33209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd33210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd33211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd33212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd33213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7409;
 end   
18'd33214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7409;
 end   
18'd33342: begin  
rid<=1;
end
18'd33343: begin  
end
18'd33344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd33345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd33346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd33347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd33348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd33349: begin  
rid<=0;
end
18'd33401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=46;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23133;
 end   
18'd33402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=38;
   mapp<=14;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19999;
 end   
18'd33403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=70;
   mapp<=67;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=22392;
 end   
18'd33404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=38;
   mapp<=93;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=19914;
 end   
18'd33405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=76;
   mapp<=96;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=23640;
 end   
18'd33406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=55;
   mapp<=61;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=23610;
 end   
18'd33407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=17;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd33408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd33409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=60;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd33410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd33411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=58;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd33412: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd33413: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23133;
 end   
18'd33414: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23133;
 end   
18'd33415: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23133;
 end   
18'd33416: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23133;
 end   
18'd33417: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23133;
 end   
18'd33542: begin  
rid<=1;
end
18'd33543: begin  
end
18'd33544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd33545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd33546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd33547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd33548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd33549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd33550: begin  
rid<=0;
end
18'd33601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=26;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1690;
 end   
18'd33602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=1;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=75;
 end   
18'd33603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=34;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2230;
 end   
18'd33604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=59;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3865;
 end   
18'd33605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd33742: begin  
rid<=1;
end
18'd33743: begin  
end
18'd33744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd33745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd33746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd33747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd33748: begin  
rid<=0;
end
18'd33801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=27;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10987;
 end   
18'd33802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=98;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11608;
 end   
18'd33803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=93;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5765;
 end   
18'd33804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=33;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4547;
 end   
18'd33805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=37;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1333;
 end   
18'd33806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=3;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8951;
 end   
18'd33807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=90;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=3568;
 end   
18'd33808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=11;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=9579;
 end   
18'd33809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=94;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=9282;
 end   
18'd33810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd33811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd33812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd33942: begin  
rid<=1;
end
18'd33943: begin  
end
18'd33944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd33945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd33946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd33947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd33948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd33949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd33950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd33951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd33952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd33953: begin  
rid<=0;
end
18'd34001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=43;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7500;
 end   
18'd34002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=31;
   mapp<=47;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5224;
 end   
18'd34003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=54;
   mapp<=49;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6814;
 end   
18'd34004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=31;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7552;
 end   
18'd34005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=69;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=10624;
 end   
18'd34006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=75;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8959;
 end   
18'd34007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=98;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=7737;
 end   
18'd34008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=49;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=8639;
 end   
18'd34009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=36;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=5939;
 end   
18'd34010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd34011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd34012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd34013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7500;
 end   
18'd34014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7500;
 end   
18'd34142: begin  
rid<=1;
end
18'd34143: begin  
end
18'd34144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd34145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd34146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd34147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd34148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd34149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd34150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd34151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd34152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd34153: begin  
rid<=0;
end
18'd34201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=4;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4762;
 end   
18'd34202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=66;
   mapp<=67;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1334;
 end   
18'd34203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=16;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=6222;
 end   
18'd34204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd34205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd34206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd34342: begin  
rid<=1;
end
18'd34343: begin  
end
18'd34344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd34345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd34346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd34347: begin  
rid<=0;
end
18'd34401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=43;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15391;
 end   
18'd34402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=4;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14175;
 end   
18'd34403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=99;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14102;
 end   
18'd34404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=74;
   mapp<=67;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12154;
 end   
18'd34405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=48;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6164;
 end   
18'd34406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=69;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5262;
 end   
18'd34407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=30;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=9440;
 end   
18'd34408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=11;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=11507;
 end   
18'd34409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd34410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd34411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd34412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd34413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15391;
 end   
18'd34414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15391;
 end   
18'd34415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15391;
 end   
18'd34542: begin  
rid<=1;
end
18'd34543: begin  
end
18'd34544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd34545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd34546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd34547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd34548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd34549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd34550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd34551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd34552: begin  
rid<=0;
end
18'd34601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=58;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3364;
 end   
18'd34602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=5172;
 end   
18'd34603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd34742: begin  
rid<=1;
end
18'd34743: begin  
end
18'd34744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd34745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd34746: begin  
rid<=0;
end
18'd34801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=18;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3406;
 end   
18'd34802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=64;
   mapp<=40;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6018;
 end   
18'd34803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=75;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4585;
 end   
18'd34804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=26;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd34805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd34806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd34942: begin  
rid<=1;
end
18'd34943: begin  
end
18'd34944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd34945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd34946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd34947: begin  
rid<=0;
end
18'd35001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=87;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=30663;
 end   
18'd35002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=83;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=30170;
 end   
18'd35003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=85;
   mapp<=40;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=36571;
 end   
18'd35004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=90;
   mapp<=70;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=33374;
 end   
18'd35005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=50;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd35006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=86;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd35007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=55;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd35008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd35009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd35010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd35011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd35012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd35013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30663;
 end   
18'd35014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30663;
 end   
18'd35015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30663;
 end   
18'd35016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30663;
 end   
18'd35017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30663;
 end   
18'd35142: begin  
rid<=1;
end
18'd35143: begin  
end
18'd35144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd35145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd35146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd35147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd35148: begin  
rid<=0;
end
18'd35201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=28;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3598;
 end   
18'd35202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=46;
   mapp<=77;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5018;
 end   
18'd35203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=62;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2860;
 end   
18'd35204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=24;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3692;
 end   
18'd35205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=65;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5172;
 end   
18'd35206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=72;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3538;
 end   
18'd35207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=32;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4866;
 end   
18'd35208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd35209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd35210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd35342: begin  
rid<=1;
end
18'd35343: begin  
end
18'd35344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd35345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd35346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd35347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd35348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd35349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd35350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd35351: begin  
rid<=0;
end
18'd35401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=25;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2075;
 end   
18'd35402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=65;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5405;
 end   
18'd35403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=60;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5000;
 end   
18'd35404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=45;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3765;
 end   
18'd35405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=78;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6514;
 end   
18'd35406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=21;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=1793;
 end   
18'd35407: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=55;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4625;
 end   
18'd35408: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=20;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1730;
 end   
18'd35409: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=27;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=2321;
 end   
18'd35410: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=73;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=6149;
 end   
18'd35411: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=34;
   mapp<=0;
   pp<=100;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[10]<=2922;
 end   
18'd35412: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd35542: begin  
rid<=1;
end
18'd35543: begin  
end
18'd35544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd35545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd35546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd35547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd35548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd35549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd35550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd35551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd35552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd35553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd35554: begin  
check<=expctdoutput[10]-outcheck;
end
18'd35555: begin  
rid<=0;
end
18'd35601: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=74;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9207;
 end   
18'd35602: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=90;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd35603: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=56;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd35604: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=71;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd35605: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=80;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd35606: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd35607: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd35608: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd35609: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd35610: begin  
  clrr<=0;
  maplen<=5;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd35742: begin  
rid<=1;
end
18'd35743: begin  
end
18'd35744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd35745: begin  
rid<=0;
end
18'd35801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=18;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3301;
 end   
18'd35802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=73;
   mapp<=25;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6296;
 end   
18'd35803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=12;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1929;
 end   
18'd35804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd35805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd35806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd35942: begin  
rid<=1;
end
18'd35943: begin  
end
18'd35944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd35945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd35946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd35947: begin  
rid<=0;
end
18'd36001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=46;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8173;
 end   
18'd36002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=3;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6350;
 end   
18'd36003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=31;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd36004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=15;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd36005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=39;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd36006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=58;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd36007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd36008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd36009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd36010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd36011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd36142: begin  
rid<=1;
end
18'd36143: begin  
end
18'd36144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd36145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd36146: begin  
rid<=0;
end
18'd36201: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=73;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=27122;
 end   
18'd36202: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=80;
   mapp<=99;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24028;
 end   
18'd36203: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=38;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd36204: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=97;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd36205: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=42;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd36206: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=8;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd36207: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd36208: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd36209: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd36210: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd36211: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd36212: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd36213: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27122;
 end   
18'd36342: begin  
rid<=1;
end
18'd36343: begin  
end
18'd36344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd36345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd36346: begin  
rid<=0;
end
18'd36401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=38;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1664;
 end   
18'd36402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=21;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1323;
 end   
18'd36403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=1;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1696;
 end   
18'd36404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=78;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4716;
 end   
18'd36405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=82;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4605;
 end   
18'd36406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=69;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3428;
 end   
18'd36407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=36;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=3066;
 end   
18'd36408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=78;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=3853;
 end   
18'd36409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd36410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd36411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd36542: begin  
rid<=1;
end
18'd36543: begin  
end
18'd36544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd36545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd36546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd36547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd36548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd36549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd36550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd36551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd36552: begin  
rid<=0;
end
18'd36601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=16;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11708;
 end   
18'd36602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=37;
   mapp<=75;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7789;
 end   
18'd36603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=7;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14282;
 end   
18'd36604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=93;
   mapp<=81;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7687;
 end   
18'd36605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=84;
   mapp<=0;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6949;
 end   
18'd36606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=61;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=15778;
 end   
18'd36607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=62;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=17353;
 end   
18'd36608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd36609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd36610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd36611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd36612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd36613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11708;
 end   
18'd36614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11708;
 end   
18'd36615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11708;
 end   
18'd36616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11708;
 end   
18'd36742: begin  
rid<=1;
end
18'd36743: begin  
end
18'd36744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd36745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd36746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd36747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd36748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd36749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd36750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd36751: begin  
rid<=0;
end
18'd36801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=91;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16679;
 end   
18'd36802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=64;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12711;
 end   
18'd36803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=23;
   mapp<=43;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12214;
 end   
18'd36804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=15;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd36805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=72;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd36806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=29;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd36807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=41;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd36808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=15;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd36809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd36810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd36811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd36812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd36813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36816: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36817: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36818: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16679;
 end   
18'd36942: begin  
rid<=1;
end
18'd36943: begin  
end
18'd36944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd36945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd36946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd36947: begin  
rid<=0;
end
18'd37001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=24;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16538;
 end   
18'd37002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=74;
   mapp<=52;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21748;
 end   
18'd37003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=33;
   mapp<=93;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=19697;
 end   
18'd37004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=85;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd37005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=38;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd37006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=70;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd37007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=62;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd37008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd37009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd37010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd37011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd37012: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd37013: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16538;
 end   
18'd37014: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16538;
 end   
18'd37015: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16538;
 end   
18'd37016: begin  
  clrr<=0;
  maplen<=9;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16538;
 end   
18'd37142: begin  
rid<=1;
end
18'd37143: begin  
end
18'd37144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd37145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd37146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd37147: begin  
rid<=0;
end
18'd37201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4011;
 end   
18'd37202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=24;
   mapp<=78;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8467;
 end   
18'd37203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=93;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd37204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd37205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd37206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd37207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd37342: begin  
rid<=1;
end
18'd37343: begin  
end
18'd37344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd37345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd37346: begin  
rid<=0;
end
18'd37401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=90;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17658;
 end   
18'd37402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=34;
   mapp<=67;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18225;
 end   
18'd37403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=91;
   mapp<=7;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18283;
 end   
18'd37404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=21;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd37405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=85;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd37406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=34;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd37407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=90;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd37408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=42;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd37409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd37410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd37411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd37412: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd37413: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17658;
 end   
18'd37414: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17658;
 end   
18'd37542: begin  
rid<=1;
end
18'd37543: begin  
end
18'd37544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd37545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd37546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd37547: begin  
rid<=0;
end
18'd37601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=97;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4638;
 end   
18'd37602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=76;
   mapp<=21;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4168;
 end   
18'd37603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=54;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2633;
 end   
18'd37604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=69;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2088;
 end   
18'd37605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=8;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2983;
 end   
18'd37606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=27;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4121;
 end   
18'd37607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=93;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4746;
 end   
18'd37608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=68;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2728;
 end   
18'd37609: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd37610: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=2;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd37611: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd37612: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd37613: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4638;
 end   
18'd37742: begin  
rid<=1;
end
18'd37743: begin  
end
18'd37744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd37745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd37746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd37747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd37748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd37749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd37750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd37751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd37752: begin  
rid<=0;
end
18'd37801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=78;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16846;
 end   
18'd37802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=14;
   mapp<=18;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15807;
 end   
18'd37803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=87;
   mapp<=90;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15025;
 end   
18'd37804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=39;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd37805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=74;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd37806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=20;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd37807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd37808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd37809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd37810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd37811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd37812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd37813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16846;
 end   
18'd37814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16846;
 end   
18'd37942: begin  
rid<=1;
end
18'd37943: begin  
end
18'd37944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd37945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd37946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd37947: begin  
rid<=0;
end
18'd38001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=2;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1429;
 end   
18'd38002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=21;
   mapp<=41;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2318;
 end   
18'd38003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=4;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd38004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd38005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd38006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd38007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd38142: begin  
rid<=1;
end
18'd38143: begin  
end
18'd38144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd38145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd38146: begin  
rid<=0;
end
18'd38201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=60;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15392;
 end   
18'd38202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=61;
   mapp<=33;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12173;
 end   
18'd38203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=20;
   mapp<=8;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16286;
 end   
18'd38204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=43;
   mapp<=61;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=17879;
 end   
18'd38205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=78;
   mapp<=33;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=17931;
 end   
18'd38206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=87;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd38207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd38208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd38209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd38210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd38211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd38212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd38213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15392;
 end   
18'd38214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15392;
 end   
18'd38215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15392;
 end   
18'd38216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15392;
 end   
18'd38342: begin  
rid<=1;
end
18'd38343: begin  
end
18'd38344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd38345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd38346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd38347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd38348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd38349: begin  
rid<=0;
end
18'd38401: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=61;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9428;
 end   
18'd38402: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=12;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5217;
 end   
18'd38403: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=11;
   mapp<=15;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5920;
 end   
18'd38404: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=59;
   mapp<=56;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11623;
 end   
18'd38405: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=51;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd38406: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=38;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd38407: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=70;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd38408: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd38409: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd38410: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd38411: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd38542: begin  
rid<=1;
end
18'd38543: begin  
end
18'd38544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd38545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd38546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd38547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd38548: begin  
rid<=0;
end
18'd38601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=60;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=30097;
 end   
18'd38602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=93;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23642;
 end   
18'd38603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=72;
   mapp<=51;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18424;
 end   
18'd38604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=2;
   mapp<=1;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=24530;
 end   
18'd38605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=76;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd38606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=43;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd38607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=73;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd38608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=66;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd38609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd38610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd38611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd38612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd38613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38616: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38617: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38618: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38619: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30097;
 end   
18'd38742: begin  
rid<=1;
end
18'd38743: begin  
end
18'd38744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd38745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd38746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd38747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd38748: begin  
rid<=0;
end
18'd38801: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=53;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11546;
 end   
18'd38802: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=92;
   mapp<=32;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23245;
 end   
18'd38803: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=70;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd38804: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=19;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd38805: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=72;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd38806: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=7;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd38807: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=94;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd38808: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=5;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd38809: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd38810: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd38811: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd38812: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd38813: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11546;
 end   
18'd38814: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11546;
 end   
18'd38815: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11546;
 end   
18'd38816: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11546;
 end   
18'd38817: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11546;
 end   
18'd38942: begin  
rid<=1;
end
18'd38943: begin  
end
18'd38944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd38945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd38946: begin  
rid<=0;
end
18'd39001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=71;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4402;
 end   
18'd39002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=9;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=649;
 end   
18'd39003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=7;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=517;
 end   
18'd39004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=38;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=2728;
 end   
18'd39005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=60;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4300;
 end   
18'd39006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5091;
 end   
18'd39007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd39142: begin  
rid<=1;
end
18'd39143: begin  
end
18'd39144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd39145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd39146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd39147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd39148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd39149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd39150: begin  
rid<=0;
end
18'd39201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=70;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16447;
 end   
18'd39202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=39;
   mapp<=23;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20658;
 end   
18'd39203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=66;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18359;
 end   
18'd39204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=22;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd39205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=83;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd39206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=60;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd39207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd39208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd39209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd39210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd39211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd39212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd39213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16447;
 end   
18'd39214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16447;
 end   
18'd39342: begin  
rid<=1;
end
18'd39343: begin  
end
18'd39344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd39345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd39346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd39347: begin  
rid<=0;
end
18'd39401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=88;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=28785;
 end   
18'd39402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=52;
   mapp<=59;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=25002;
 end   
18'd39403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=54;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=26656;
 end   
18'd39404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=66;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd39405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=33;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd39406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=60;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd39407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=19;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd39408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=31;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd39409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=38;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd39410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd39411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=76;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd39412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd39413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39416: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39417: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39418: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39419: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39420: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28785;
 end   
18'd39542: begin  
rid<=1;
end
18'd39543: begin  
end
18'd39544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd39545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd39546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd39547: begin  
rid<=0;
end
18'd39601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=53;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1060;
 end   
18'd39602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=7;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=150;
 end   
18'd39603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=69;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1400;
 end   
18'd39604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=16;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=350;
 end   
18'd39605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=22;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=480;
 end   
18'd39606: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd39742: begin  
rid<=1;
end
18'd39743: begin  
end
18'd39744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd39745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd39746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd39747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd39748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd39749: begin  
rid<=0;
end
18'd39801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=17;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1071;
 end   
18'd39802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=60;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1030;
 end   
18'd39803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=47;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=819;
 end   
18'd39804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=93;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=1611;
 end   
18'd39805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=30;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=550;
 end   
18'd39806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=17;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=339;
 end   
18'd39807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=43;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=791;
 end   
18'd39808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=76;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1362;
 end   
18'd39809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=14;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=318;
 end   
18'd39810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=26;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=532;
 end   
18'd39811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd39942: begin  
rid<=1;
end
18'd39943: begin  
end
18'd39944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd39945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd39946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd39947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd39948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd39949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd39950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd39951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd39952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd39953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd39954: begin  
rid<=0;
end
18'd40001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=66;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21388;
 end   
18'd40002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=93;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17301;
 end   
18'd40003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=64;
   mapp<=64;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12112;
 end   
18'd40004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=75;
   mapp<=54;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6123;
 end   
18'd40005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd40006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=12;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd40007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd40008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd40009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd40010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd40011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd40142: begin  
rid<=1;
end
18'd40143: begin  
end
18'd40144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd40145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd40146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd40147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd40148: begin  
rid<=0;
end
18'd40201: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=72;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5688;
 end   
18'd40202: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=3106;
 end   
18'd40203: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=77;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5564;
 end   
18'd40204: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=89;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6438;
 end   
18'd40205: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=61;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4432;
 end   
18'd40206: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=85;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=6170;
 end   
18'd40207: begin  
  clrr<=0;
  maplen<=6;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd40342: begin  
rid<=1;
end
18'd40343: begin  
end
18'd40344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd40345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd40346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd40347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd40348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd40349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd40350: begin  
rid<=0;
end
18'd40401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=57;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15283;
 end   
18'd40402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=30;
   mapp<=63;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11293;
 end   
18'd40403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=23;
   mapp<=4;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11771;
 end   
18'd40404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=64;
   mapp<=46;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=17754;
 end   
18'd40405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=74;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd40406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=46;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd40407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd40408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd40409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd40410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd40411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd40412: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd40413: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15283;
 end   
18'd40414: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15283;
 end   
18'd40415: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15283;
 end   
18'd40542: begin  
rid<=1;
end
18'd40543: begin  
end
18'd40544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd40545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd40546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd40547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd40548: begin  
rid<=0;
end
18'd40601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=61;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8463;
 end   
18'd40602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=91;
   mapp<=32;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4055;
 end   
18'd40603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd40604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd40605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd40742: begin  
rid<=1;
end
18'd40743: begin  
end
18'd40744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd40745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd40746: begin  
rid<=0;
end
18'd40801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=91;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8918;
 end   
18'd40802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=69;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5461;
 end   
18'd40803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=79;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8935;
 end   
18'd40804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=17;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2869;
 end   
18'd40805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=17;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2672;
 end   
18'd40806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=14;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7977;
 end   
18'd40807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=95;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd40808: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd40809: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd40942: begin  
rid<=1;
end
18'd40943: begin  
end
18'd40944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd40945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd40946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd40947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd40948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd40949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd40950: begin  
rid<=0;
end
18'd41001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=28;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1876;
 end   
18'd41002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=53;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3561;
 end   
18'd41003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=9;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=623;
 end   
18'd41004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=73;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4921;
 end   
18'd41005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=81;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5467;
 end   
18'd41006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=3;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=251;
 end   
18'd41007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=69;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4683;
 end   
18'd41008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=16;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1142;
 end   
18'd41009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd41142: begin  
rid<=1;
end
18'd41143: begin  
end
18'd41144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd41145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd41146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd41147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd41148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd41149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd41150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd41151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd41152: begin  
rid<=0;
end
18'd41201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=57;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5007;
 end   
18'd41202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=81;
   mapp<=2;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2554;
 end   
18'd41203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd41204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd41205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd41342: begin  
rid<=1;
end
18'd41343: begin  
end
18'd41344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd41345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd41346: begin  
rid<=0;
end
18'd41401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=77;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13541;
 end   
18'd41402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=45;
   mapp<=87;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11246;
 end   
18'd41403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=64;
   mapp<=71;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12591;
 end   
18'd41404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=38;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12052;
 end   
18'd41405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd41406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=47;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd41407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd41408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd41409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd41542: begin  
rid<=1;
end
18'd41543: begin  
end
18'd41544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd41545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd41546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd41547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd41548: begin  
rid<=0;
end
18'd41601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=5;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3076;
 end   
18'd41602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=53;
   mapp<=57;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4640;
 end   
18'd41603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=71;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5361;
 end   
18'd41604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=80;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3190;
 end   
18'd41605: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=40;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2190;
 end   
18'd41606: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=30;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd41607: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd41608: begin  
  clrr<=0;
  maplen<=2;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd41742: begin  
rid<=1;
end
18'd41743: begin  
end
18'd41744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd41745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd41746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd41747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd41748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd41749: begin  
rid<=0;
end
18'd41801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=86;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16770;
 end   
18'd41802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=4;
   mapp<=77;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10261;
 end   
18'd41803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=89;
   mapp<=98;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14729;
 end   
18'd41804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=31;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14832;
 end   
18'd41805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=44;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11756;
 end   
18'd41806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=88;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=10504;
 end   
18'd41807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=10;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4208;
 end   
18'd41808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=18;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=8935;
 end   
18'd41809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=19;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=8979;
 end   
18'd41810: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd41811: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=27;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd41812: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd41813: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16770;
 end   
18'd41814: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16770;
 end   
18'd41942: begin  
rid<=1;
end
18'd41943: begin  
end
18'd41944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd41945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd41946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd41947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd41948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd41949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd41950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd41951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd41952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd41953: begin  
rid<=0;
end
18'd42001: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1536;
 end   
18'd42002: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=96;
   mapp<=16;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8442;
 end   
18'd42003: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=53;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5135;
 end   
18'd42004: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=58;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd42005: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd42006: begin  
  clrr<=0;
  maplen<=2;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd42142: begin  
rid<=1;
end
18'd42143: begin  
end
18'd42144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd42145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd42146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd42147: begin  
rid<=0;
end
18'd42201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=46;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18979;
 end   
18'd42202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=29;
   mapp<=49;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20787;
 end   
18'd42203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=71;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd42204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=28;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd42205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=59;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd42206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=41;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd42207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=21;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd42208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=88;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd42209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd42210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd42211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd42212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd42213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18979;
 end   
18'd42214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18979;
 end   
18'd42215: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18979;
 end   
18'd42216: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18979;
 end   
18'd42217: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18979;
 end   
18'd42342: begin  
rid<=1;
end
18'd42343: begin  
end
18'd42344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd42345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd42346: begin  
rid<=0;
end
18'd42401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=87;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=35635;
 end   
18'd42402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=38;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd42403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=69;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd42404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=83;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd42405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=40;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd42406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=95;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd42407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=66;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd42408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=33;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd42409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=9;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd42410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=57;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd42411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=17;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd42412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd42413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42417: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42418: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42419: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42420: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42421: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42422: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=35635;
 end   
18'd42542: begin  
rid<=1;
end
18'd42543: begin  
end
18'd42544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd42545: begin  
rid<=0;
end
18'd42601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=74;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=37417;
 end   
18'd42602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=12;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=32010;
 end   
18'd42603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=97;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd42604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=51;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd42605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=95;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd42606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=17;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd42607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=92;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd42608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=92;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd42609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=37;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd42610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=30;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd42611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd42612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd42613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42616: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42617: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42618: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42619: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42620: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42621: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=37417;
 end   
18'd42742: begin  
rid<=1;
end
18'd42743: begin  
end
18'd42744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd42745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd42746: begin  
rid<=0;
end
18'd42801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=20;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19300;
 end   
18'd42802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=93;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd42803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=92;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd42804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=62;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd42805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=14;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd42806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=27;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd42807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=7;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd42808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=94;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd42809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd42810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd42811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd42812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd42813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19300;
 end   
18'd42814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19300;
 end   
18'd42815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19300;
 end   
18'd42816: begin  
  clrr<=0;
  maplen<=8;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19300;
 end   
18'd42942: begin  
rid<=1;
end
18'd42943: begin  
end
18'd42944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd42945: begin  
rid<=0;
end
18'd43001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=95;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12355;
 end   
18'd43002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=62;
   mapp<=13;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6743;
 end   
18'd43003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=81;
   mapp<=93;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5622;
 end   
18'd43004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=46;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd43005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=9;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd43006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=48;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd43007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=68;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd43008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd43009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd43010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd43011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd43012: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd43142: begin  
rid<=1;
end
18'd43143: begin  
end
18'd43144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd43145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd43146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd43147: begin  
rid<=0;
end
18'd43201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=62;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8533;
 end   
18'd43202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=27;
   mapp<=35;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7622;
 end   
18'd43203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=77;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd43204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=17;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd43205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=40;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd43206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=42;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd43207: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd43208: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd43209: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd43210: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd43211: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd43342: begin  
rid<=1;
end
18'd43343: begin  
end
18'd43344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd43345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd43346: begin  
rid<=0;
end
18'd43401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=22;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18983;
 end   
18'd43402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=27;
   mapp<=76;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17818;
 end   
18'd43403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=29;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd43404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=11;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd43405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=11;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd43406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=54;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd43407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=80;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd43408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=53;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd43409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=93;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd43410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=21;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd43411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd43412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd43413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43416: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43417: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43418: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43419: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18983;
 end   
18'd43542: begin  
rid<=1;
end
18'd43543: begin  
end
18'd43544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd43545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd43546: begin  
rid<=0;
end
18'd43601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=31;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17431;
 end   
18'd43602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=40;
   mapp<=0;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17837;
 end   
18'd43603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=34;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd43604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=40;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd43605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=86;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd43606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=34;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd43607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=48;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd43608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=39;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd43609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd43610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd43611: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd43612: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd43613: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17431;
 end   
18'd43614: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17431;
 end   
18'd43615: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17431;
 end   
18'd43742: begin  
rid<=1;
end
18'd43743: begin  
end
18'd43744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd43745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd43746: begin  
rid<=0;
end
18'd43801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=62;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=744;
 end   
18'd43802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=52;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=634;
 end   
18'd43803: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=31;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=392;
 end   
18'd43804: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=87;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1074;
 end   
18'd43805: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd43942: begin  
rid<=1;
end
18'd43943: begin  
end
18'd43944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd43945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd43946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd43947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd43948: begin  
rid<=0;
end
18'd44001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=56;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2688;
 end   
18'd44002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=70;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3370;
 end   
18'd44003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=50;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2420;
 end   
18'd44004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=82;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3966;
 end   
18'd44005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=1;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=88;
 end   
18'd44006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=93;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4514;
 end   
18'd44007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=99;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4812;
 end   
18'd44008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=32;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1606;
 end   
18'd44009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=44;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=2192;
 end   
18'd44010: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd44142: begin  
rid<=1;
end
18'd44143: begin  
end
18'd44144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd44145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd44146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd44147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd44148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd44149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd44150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd44151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd44152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd44153: begin  
rid<=0;
end
18'd44201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=66;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2190;
 end   
18'd44202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=38;
   mapp<=50;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=810;
 end   
18'd44203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=1;
   mapp<=26;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2292;
 end   
18'd44204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=23;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3338;
 end   
18'd44205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=43;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4342;
 end   
18'd44206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=41;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6684;
 end   
18'd44207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=80;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=5598;
 end   
18'd44208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=95;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2884;
 end   
18'd44209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd44210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd44211: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd44212: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd44213: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2190;
 end   
18'd44342: begin  
rid<=1;
end
18'd44343: begin  
end
18'd44344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd44345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd44346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd44347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd44348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd44349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd44350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd44351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd44352: begin  
rid<=0;
end
18'd44401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=15;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=435;
 end   
18'd44402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=88;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1330;
 end   
18'd44403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=830;
 end   
18'd44404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=13;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=225;
 end   
18'd44405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=79;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1225;
 end   
18'd44406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=1085;
 end   
18'd44407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=66;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1050;
 end   
18'd44408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=79;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1255;
 end   
18'd44409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=77;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=1235;
 end   
18'd44410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=37;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=645;
 end   
18'd44411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=2;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=130;
 end   
18'd44412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd44542: begin  
rid<=1;
end
18'd44543: begin  
end
18'd44544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd44545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd44546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd44547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd44548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd44549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd44550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd44551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd44552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd44553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd44554: begin  
check<=expctdoutput[10]-outcheck;
end
18'd44555: begin  
rid<=0;
end
18'd44601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=97;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18774;
 end   
18'd44602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=8;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16967;
 end   
18'd44603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=8;
   mapp<=23;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10786;
 end   
18'd44604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=11;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd44605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=93;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd44606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=65;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd44607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd44608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=2;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd44609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd44610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd44611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd44612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd44613: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18774;
 end   
18'd44614: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18774;
 end   
18'd44742: begin  
rid<=1;
end
18'd44743: begin  
end
18'd44744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd44745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd44746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd44747: begin  
rid<=0;
end
18'd44801: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=40;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2405;
 end   
18'd44802: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=33;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2355;
 end   
18'd44803: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=65;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=3379;
 end   
18'd44804: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=23;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3227;
 end   
18'd44805: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=69;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=3295;
 end   
18'd44806: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=15;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2399;
 end   
18'd44807: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=53;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2345;
 end   
18'd44808: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=5;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=3042;
 end   
18'd44809: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=84;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=6014;
 end   
18'd44810: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=78;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=4695;
 end   
18'd44811: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd44812: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd44813: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2405;
 end   
18'd44942: begin  
rid<=1;
end
18'd44943: begin  
end
18'd44944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd44945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd44946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd44947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd44948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd44949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd44950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd44951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd44952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd44953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd44954: begin  
rid<=0;
end
18'd45001: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=85;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12965;
 end   
18'd45002: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=48;
   mapp<=94;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11944;
 end   
18'd45003: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=81;
   mapp<=33;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10384;
 end   
18'd45004: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=32;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7800;
 end   
18'd45005: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=56;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd45006: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=10;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd45007: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd45008: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd45009: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd45142: begin  
rid<=1;
end
18'd45143: begin  
end
18'd45144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd45145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd45146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd45147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd45148: begin  
rid<=0;
end
18'd45201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=27;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8177;
 end   
18'd45202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=37;
   mapp<=6;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11410;
 end   
18'd45203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=43;
   mapp<=35;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12367;
 end   
18'd45204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=68;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd45205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=33;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd45206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=95;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd45207: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd45208: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd45209: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd45210: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd45211: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd45212: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd45342: begin  
rid<=1;
end
18'd45343: begin  
end
18'd45344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd45345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd45346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd45347: begin  
rid<=0;
end
18'd45401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=12;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7479;
 end   
18'd45402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=93;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4120;
 end   
18'd45403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd45404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd45405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd45542: begin  
rid<=1;
end
18'd45543: begin  
end
18'd45544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd45545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd45546: begin  
rid<=0;
end
18'd45601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=6;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6600;
 end   
18'd45602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=91;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7886;
 end   
18'd45603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=43;
   mapp<=26;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7288;
 end   
18'd45604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd45605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=27;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd45606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd45607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd45608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd45742: begin  
rid<=1;
end
18'd45743: begin  
end
18'd45744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd45745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd45746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd45747: begin  
rid<=0;
end
18'd45801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=67;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20780;
 end   
18'd45802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=27;
   mapp<=93;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16443;
 end   
18'd45803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=5;
   mapp<=35;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16358;
 end   
18'd45804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=46;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd45805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=86;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd45806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=89;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd45807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=40;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd45808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd45809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd45810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd45811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd45812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd45813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20780;
 end   
18'd45814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20780;
 end   
18'd45942: begin  
rid<=1;
end
18'd45943: begin  
end
18'd45944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd45945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd45946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd45947: begin  
rid<=0;
end
18'd46001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=42;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4198;
 end   
18'd46002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=0;
   mapp<=56;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2680;
 end   
18'd46003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=11;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd46004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=25;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd46005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=43;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd46006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd46007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd46008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd46009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd46142: begin  
rid<=1;
end
18'd46143: begin  
end
18'd46144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd46145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd46146: begin  
rid<=0;
end
18'd46201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=68;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1394;
 end   
18'd46202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=41;
   mapp<=4;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1353;
 end   
18'd46203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=35;
   mapp<=6;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1087;
 end   
18'd46204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=98;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1678;
 end   
18'd46205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=25;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=605;
 end   
18'd46206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd46207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=23;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd46208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd46209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd46210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd46342: begin  
rid<=1;
end
18'd46343: begin  
end
18'd46344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd46345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd46346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd46347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd46348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd46349: begin  
rid<=0;
end
18'd46401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=46;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2622;
 end   
18'd46402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=96;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=4426;
 end   
18'd46403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=39;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1814;
 end   
18'd46404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=86;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3986;
 end   
18'd46405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=94;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4364;
 end   
18'd46406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd46542: begin  
rid<=1;
end
18'd46543: begin  
end
18'd46544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd46545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd46546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd46547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd46548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd46549: begin  
rid<=0;
end
18'd46601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=90;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18327;
 end   
18'd46602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=73;
   mapp<=80;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16372;
 end   
18'd46603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=27;
   mapp<=55;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16779;
 end   
18'd46604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=13;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd46605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=54;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd46606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=96;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd46607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=72;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd46608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd46609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd46610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd46611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd46612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd46613: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18327;
 end   
18'd46614: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18327;
 end   
18'd46742: begin  
rid<=1;
end
18'd46743: begin  
end
18'd46744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd46745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd46746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd46747: begin  
rid<=0;
end
18'd46801: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=95;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9842;
 end   
18'd46802: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=3;
   mapp<=25;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7838;
 end   
18'd46803: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=94;
   mapp<=13;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10788;
 end   
18'd46804: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=93;
   mapp<=24;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10365;
 end   
18'd46805: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=67;
   mapp<=29;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8902;
 end   
18'd46806: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7788;
 end   
18'd46807: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=40;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=5994;
 end   
18'd46808: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=79;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd46809: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=41;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd46810: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=25;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd46811: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=34;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd46812: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd46813: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9842;
 end   
18'd46814: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9842;
 end   
18'd46815: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9842;
 end   
18'd46816: begin  
  clrr<=0;
  maplen<=5;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9842;
 end   
18'd46942: begin  
rid<=1;
end
18'd46943: begin  
end
18'd46944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd46945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd46946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd46947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd46948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd46949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd46950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd46951: begin  
rid<=0;
end
18'd47001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=11;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20185;
 end   
18'd47002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=25;
   mapp<=21;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21487;
 end   
18'd47003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=28;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd47004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=78;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd47005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=48;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd47006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=50;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd47007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=92;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd47008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=44;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd47009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=54;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd47010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=23;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd47011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=53;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd47012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd47013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47018: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47019: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47020: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47021: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20185;
 end   
18'd47142: begin  
rid<=1;
end
18'd47143: begin  
end
18'd47144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd47145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd47146: begin  
rid<=0;
end
18'd47201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=4;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5503;
 end   
18'd47202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=38;
   mapp<=26;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8850;
 end   
18'd47203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=71;
   mapp<=61;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5827;
 end   
18'd47204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=86;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10155;
 end   
18'd47205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=5;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6260;
 end   
18'd47206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=99;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7768;
 end   
18'd47207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=56;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=7451;
 end   
18'd47208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=28;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6211;
 end   
18'd47209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=5647;
 end   
18'd47210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=51;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd47211: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=19;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd47212: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd47213: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5503;
 end   
18'd47214: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5503;
 end   
18'd47342: begin  
rid<=1;
end
18'd47343: begin  
end
18'd47344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd47345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd47346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd47347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd47348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd47349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd47350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd47351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd47352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd47353: begin  
rid<=0;
end
18'd47401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=12;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18358;
 end   
18'd47402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=67;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18255;
 end   
18'd47403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=99;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd47404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=44;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd47405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=97;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd47406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=1;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd47407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd47408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd47409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd47410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd47411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd47542: begin  
rid<=1;
end
18'd47543: begin  
end
18'd47544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd47545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd47546: begin  
rid<=0;
end
18'd47601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=44;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16531;
 end   
18'd47602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=18;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13763;
 end   
18'd47603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=25;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd47604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=19;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd47605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=84;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd47606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=74;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd47607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd47608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd47609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd47610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd47611: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd47612: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd47613: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16531;
 end   
18'd47742: begin  
rid<=1;
end
18'd47743: begin  
end
18'd47744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd47745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd47746: begin  
rid<=0;
end
18'd47801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=14;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13288;
 end   
18'd47802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=63;
   mapp<=14;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11329;
 end   
18'd47803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=51;
   mapp<=95;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18068;
 end   
18'd47804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=19;
   mapp<=3;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10869;
 end   
18'd47805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=90;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd47806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=17;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd47807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=83;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd47808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd47809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=84;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd47810: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd47811: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd47812: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd47813: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13288;
 end   
18'd47814: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13288;
 end   
18'd47815: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13288;
 end   
18'd47816: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13288;
 end   
18'd47817: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13288;
 end   
18'd47942: begin  
rid<=1;
end
18'd47943: begin  
end
18'd47944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd47945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd47946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd47947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd47948: begin  
rid<=0;
end
18'd48001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=37;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1776;
 end   
18'd48002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=97;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4666;
 end   
18'd48003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=24;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1172;
 end   
18'd48004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=68;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3294;
 end   
18'd48005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=27;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1336;
 end   
18'd48006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=48;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2354;
 end   
18'd48007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=93;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4524;
 end   
18'd48008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=82;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=4006;
 end   
18'd48009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd48142: begin  
rid<=1;
end
18'd48143: begin  
end
18'd48144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd48145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd48146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd48147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd48148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd48149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd48150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd48151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd48152: begin  
rid<=0;
end
18'd48201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=77;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7161;
 end   
18'd48202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=14;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1312;
 end   
18'd48203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=4;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=392;
 end   
18'd48204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=84;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7842;
 end   
18'd48205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=43;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4039;
 end   
18'd48206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd48342: begin  
rid<=1;
end
18'd48343: begin  
end
18'd48344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd48345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd48346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd48347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd48348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd48349: begin  
rid<=0;
end
18'd48401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=92;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8556;
 end   
18'd48402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=98;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9124;
 end   
18'd48403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=90;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8390;
 end   
18'd48404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=99;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9237;
 end   
18'd48405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=90;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8410;
 end   
18'd48406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd48542: begin  
rid<=1;
end
18'd48543: begin  
end
18'd48544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd48545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd48546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd48547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd48548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd48549: begin  
rid<=0;
end
18'd48601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=14;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6088;
 end   
18'd48602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=73;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd48603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd48604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd48742: begin  
rid<=1;
end
18'd48743: begin  
end
18'd48744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd48745: begin  
rid<=0;
end
18'd48801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=38;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2833;
 end   
18'd48802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=11;
   mapp<=33;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2441;
 end   
18'd48803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd48804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd48805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd48942: begin  
rid<=1;
end
18'd48943: begin  
end
18'd48944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd48945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd48946: begin  
rid<=0;
end
18'd49001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=68;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13687;
 end   
18'd49002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=21;
   mapp<=88;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13595;
 end   
18'd49003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=58;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd49004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=57;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd49005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=47;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd49006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=82;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd49007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=38;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd49008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=22;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd49009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd49010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd49011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd49012: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd49013: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13687;
 end   
18'd49014: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13687;
 end   
18'd49015: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13687;
 end   
18'd49142: begin  
rid<=1;
end
18'd49143: begin  
end
18'd49144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd49145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd49146: begin  
rid<=0;
end
18'd49201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=45;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6097;
 end   
18'd49202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=51;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3371;
 end   
18'd49203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=23;
   mapp<=56;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4560;
 end   
18'd49204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd49205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd49206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd49207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd49208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd49342: begin  
rid<=1;
end
18'd49343: begin  
end
18'd49344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd49345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd49346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd49347: begin  
rid<=0;
end
18'd49401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=41;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3731;
 end   
18'd49402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=6;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=256;
 end   
18'd49403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=10;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=430;
 end   
18'd49404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=13;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=563;
 end   
18'd49405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=51;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2131;
 end   
18'd49406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=80;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3330;
 end   
18'd49407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=44;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1864;
 end   
18'd49408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=43;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1833;
 end   
18'd49409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd49542: begin  
rid<=1;
end
18'd49543: begin  
end
18'd49544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd49545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd49546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd49547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd49548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd49549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd49550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd49551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd49552: begin  
rid<=0;
end
18'd49601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=27;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6259;
 end   
18'd49602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=24;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd49603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=4;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd49604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=56;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd49605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd49606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd49607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd49608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd49742: begin  
rid<=1;
end
18'd49743: begin  
end
18'd49744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd49745: begin  
rid<=0;
end
18'd49801: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=98;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5548;
 end   
18'd49802: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=79;
   mapp<=2;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7000;
 end   
18'd49803: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=13820;
 end   
18'd49804: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd49805: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd49806: begin  
  clrr<=0;
  maplen<=4;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd49942: begin  
rid<=1;
end
18'd49943: begin  
end
18'd49944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd49945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd49946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd49947: begin  
rid<=0;
end
18'd50001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=96;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12116;
 end   
18'd50002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=50;
   mapp<=90;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15805;
 end   
18'd50003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=12;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd50004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=22;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd50005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=29;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd50006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd50007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd50008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd50009: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd50010: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd50011: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd50142: begin  
rid<=1;
end
18'd50143: begin  
end
18'd50144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd50145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd50146: begin  
rid<=0;
end
18'd50201: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=51;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20825;
 end   
18'd50202: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=97;
   mapp<=53;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24357;
 end   
18'd50203: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=51;
   mapp<=76;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20122;
 end   
18'd50204: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=1;
   mapp<=70;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16262;
 end   
18'd50205: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=35;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd50206: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=93;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd50207: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=72;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd50208: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd50209: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd50210: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd50211: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd50212: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd50213: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20825;
 end   
18'd50214: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20825;
 end   
18'd50215: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20825;
 end   
18'd50342: begin  
rid<=1;
end
18'd50343: begin  
end
18'd50344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd50345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd50346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd50347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd50348: begin  
rid<=0;
end
18'd50401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=2;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15305;
 end   
18'd50402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=58;
   mapp<=38;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14826;
 end   
18'd50403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=88;
   mapp<=96;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9758;
 end   
18'd50404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=21;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd50405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=86;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd50406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd50407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd50408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd50409: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd50410: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd50411: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd50412: begin  
  clrr<=0;
  maplen<=7;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd50542: begin  
rid<=1;
end
18'd50543: begin  
end
18'd50544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd50545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd50546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd50547: begin  
rid<=0;
end
18'd50601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=62;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1736;
 end   
18'd50602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=4908;
 end   
18'd50603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=47;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2934;
 end   
18'd50604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=49;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3068;
 end   
18'd50605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=80;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5000;
 end   
18'd50606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=45;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2840;
 end   
18'd50607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=28;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1796;
 end   
18'd50608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd50742: begin  
rid<=1;
end
18'd50743: begin  
end
18'd50744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd50745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd50746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd50747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd50748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd50749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd50750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd50751: begin  
rid<=0;
end
18'd50801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=56;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4312;
 end   
18'd50802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=91;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=5106;
 end   
18'd50803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=47;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2652;
 end   
18'd50804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=85;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4790;
 end   
18'd50805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=31;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1776;
 end   
18'd50806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=6;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=386;
 end   
18'd50807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=84;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4764;
 end   
18'd50808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=54;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=3094;
 end   
18'd50809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=3944;
 end   
18'd50810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=9;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=594;
 end   
18'd50811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd50942: begin  
rid<=1;
end
18'd50943: begin  
end
18'd50944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd50945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd50946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd50947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd50948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd50949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd50950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd50951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd50952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd50953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd50954: begin  
rid<=0;
end
18'd51001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=35;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13088;
 end   
18'd51002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=90;
   mapp<=16;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10517;
 end   
18'd51003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=77;
   mapp<=60;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14451;
 end   
18'd51004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=49;
   mapp<=97;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16991;
 end   
18'd51005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=5;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd51006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=86;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd51007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd51008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd51009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd51010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd51011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd51142: begin  
rid<=1;
end
18'd51143: begin  
end
18'd51144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd51145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd51146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd51147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd51148: begin  
rid<=0;
end
18'd51201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=88;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=22183;
 end   
18'd51202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=15;
   mapp<=30;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21006;
 end   
18'd51203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=8;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd51204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=10;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd51205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=40;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd51206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=99;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd51207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=97;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd51208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=7;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd51209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=54;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd51210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=4;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd51211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd51212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd51213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51215: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51216: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51217: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51218: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51219: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22183;
 end   
18'd51342: begin  
rid<=1;
end
18'd51343: begin  
end
18'd51344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd51345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd51346: begin  
rid<=0;
end
18'd51401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6967;
 end   
18'd51402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=64;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1838;
 end   
18'd51403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=83;
   mapp<=13;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7594;
 end   
18'd51404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=12;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=12167;
 end   
18'd51405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=82;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=9585;
 end   
18'd51406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=83;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5721;
 end   
18'd51407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=51;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4987;
 end   
18'd51408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=29;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=5177;
 end   
18'd51409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd51410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd51411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd51412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd51413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6967;
 end   
18'd51542: begin  
rid<=1;
end
18'd51543: begin  
end
18'd51544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd51545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd51546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd51547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd51548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd51549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd51550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd51551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd51552: begin  
rid<=0;
end
18'd51601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=56;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10703;
 end   
18'd51602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=92;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8978;
 end   
18'd51603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=40;
   mapp<=8;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8739;
 end   
18'd51604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=87;
   mapp<=41;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14058;
 end   
18'd51605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=32;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=17209;
 end   
18'd51606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=37;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=13897;
 end   
18'd51607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=84;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=19915;
 end   
18'd51608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=99;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=15687;
 end   
18'd51609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd51610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd51611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd51612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd51613: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10703;
 end   
18'd51614: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10703;
 end   
18'd51615: begin  
  clrr<=0;
  maplen<=11;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10703;
 end   
18'd51742: begin  
rid<=1;
end
18'd51743: begin  
end
18'd51744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd51745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd51746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd51747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd51748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd51749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd51750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd51751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd51752: begin  
rid<=0;
end
18'd51801: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=33;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18241;
 end   
18'd51802: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=78;
   mapp<=35;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17865;
 end   
18'd51803: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=86;
   mapp<=63;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18525;
 end   
18'd51804: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=24;
   mapp<=15;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=21620;
 end   
18'd51805: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=34;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd51806: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=75;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd51807: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd51808: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd51809: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd51810: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd51811: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd51812: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd51813: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18241;
 end   
18'd51814: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18241;
 end   
18'd51815: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18241;
 end   
18'd51942: begin  
rid<=1;
end
18'd51943: begin  
end
18'd51944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd51945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd51946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd51947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd51948: begin  
rid<=0;
end
18'd52001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=55;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4620;
 end   
18'd52002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=24;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1330;
 end   
18'd52003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=92;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5080;
 end   
18'd52004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=4;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=250;
 end   
18'd52005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=22;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1250;
 end   
18'd52006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd52142: begin  
rid<=1;
end
18'd52143: begin  
end
18'd52144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd52145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd52146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd52147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd52148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd52149: begin  
rid<=0;
end
18'd52201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=97;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7081;
 end   
18'd52202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=8158;
 end   
18'd52203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=60;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5840;
 end   
18'd52204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=22;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=2164;
 end   
18'd52205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=53;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5181;
 end   
18'd52206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd52342: begin  
rid<=1;
end
18'd52343: begin  
end
18'd52344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd52345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd52346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd52347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd52348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd52349: begin  
rid<=0;
end
18'd52401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=90;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15571;
 end   
18'd52402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=98;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13054;
 end   
18'd52403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=85;
   mapp<=6;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20346;
 end   
18'd52404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=47;
   mapp<=31;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=28339;
 end   
18'd52405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=84;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd52406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=92;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd52407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd52408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd52409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd52410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd52411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd52412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd52413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15571;
 end   
18'd52414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15571;
 end   
18'd52415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15571;
 end   
18'd52542: begin  
rid<=1;
end
18'd52543: begin  
end
18'd52544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd52545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd52546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd52547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd52548: begin  
rid<=0;
end
18'd52601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=28;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7350;
 end   
18'd52602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=95;
   mapp<=28;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8069;
 end   
18'd52603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=42;
   mapp<=38;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6408;
 end   
18'd52604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=37;
   mapp<=42;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7005;
 end   
18'd52605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=6;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=8166;
 end   
18'd52606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=67;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=8963;
 end   
18'd52607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=53;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=7701;
 end   
18'd52608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=93;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd52609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=5;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd52610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=46;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd52611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd52612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd52613: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7350;
 end   
18'd52614: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7350;
 end   
18'd52742: begin  
rid<=1;
end
18'd52743: begin  
end
18'd52744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd52745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd52746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd52747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd52748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd52749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd52750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd52751: begin  
rid<=0;
end
18'd52801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=39;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2496;
 end   
18'd52802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=6;
   mapp<=65;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=919;
 end   
18'd52803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=9;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6486;
 end   
18'd52804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=92;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11433;
 end   
18'd52805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=99;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10261;
 end   
18'd52806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=75;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6440;
 end   
18'd52807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=5969;
 end   
18'd52808: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=61;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6419;
 end   
18'd52809: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=47;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=3788;
 end   
18'd52810: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd52811: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd52812: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd52942: begin  
rid<=1;
end
18'd52943: begin  
end
18'd52944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd52945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd52946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd52947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd52948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd52949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd52950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd52951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd52952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd52953: begin  
rid<=0;
end
18'd53001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=44;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21869;
 end   
18'd53002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=36;
   mapp<=96;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23211;
 end   
18'd53003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=37;
   mapp<=9;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20539;
 end   
18'd53004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=16;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd53005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=93;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd53006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=49;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd53007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=71;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd53008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=44;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd53009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=77;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd53010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd53011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd53012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd53013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53020: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21869;
 end   
18'd53142: begin  
rid<=1;
end
18'd53143: begin  
end
18'd53144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd53145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd53146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd53147: begin  
rid<=0;
end
18'd53201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=18;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7550;
 end   
18'd53202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=68;
   mapp<=85;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7365;
 end   
18'd53203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=6;
   mapp<=25;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3225;
 end   
18'd53204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=29;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4345;
 end   
18'd53205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=8;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4870;
 end   
18'd53206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=41;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6765;
 end   
18'd53207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=25;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=7370;
 end   
18'd53208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=10510;
 end   
18'd53209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=80;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd53210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd53211: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd53212: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd53213: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7550;
 end   
18'd53342: begin  
rid<=1;
end
18'd53343: begin  
end
18'd53344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd53345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd53346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd53347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd53348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd53349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd53350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd53351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd53352: begin  
rid<=0;
end
18'd53401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=28;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1316;
 end   
18'd53402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=36;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1702;
 end   
18'd53403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=4;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=208;
 end   
18'd53404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=30;
 end   
18'd53405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=23;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1121;
 end   
18'd53406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=64;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3058;
 end   
18'd53407: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=11;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=577;
 end   
18'd53408: begin  
  clrr<=0;
  maplen<=1;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd53542: begin  
rid<=1;
end
18'd53543: begin  
end
18'd53544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd53545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd53546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd53547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd53548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd53549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd53550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd53551: begin  
rid<=0;
end
18'd53601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=41;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8944;
 end   
18'd53602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=70;
   mapp<=83;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4421;
 end   
18'd53603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=45;
   mapp<=66;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6506;
 end   
18'd53604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=6;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11054;
 end   
18'd53605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=88;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5502;
 end   
18'd53606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=56;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=5211;
 end   
18'd53607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=7;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=9328;
 end   
18'd53608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd53609: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=57;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd53610: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd53611: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd53612: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd53742: begin  
rid<=1;
end
18'd53743: begin  
end
18'd53744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd53745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd53746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd53747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd53748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd53749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd53750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd53751: begin  
rid<=0;
end
18'd53801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=90;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19965;
 end   
18'd53802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=67;
   mapp<=55;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18873;
 end   
18'd53803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=7;
   mapp<=91;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18611;
 end   
18'd53804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=34;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd53805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=46;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd53806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=62;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd53807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=2;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd53808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=39;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd53809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=26;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd53810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=95;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd53811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd53812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd53813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53816: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53817: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53818: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19965;
 end   
18'd53942: begin  
rid<=1;
end
18'd53943: begin  
end
18'd53944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd53945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd53946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd53947: begin  
rid<=0;
end
18'd54001: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=76;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21687;
 end   
18'd54002: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=64;
   mapp<=86;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21291;
 end   
18'd54003: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=57;
   mapp<=79;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18671;
 end   
18'd54004: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=70;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd54005: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=38;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd54006: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=12;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd54007: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=44;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd54008: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=61;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd54009: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=80;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd54010: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd54011: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd54012: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd54013: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54014: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54015: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54016: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54017: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54018: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21687;
 end   
18'd54142: begin  
rid<=1;
end
18'd54143: begin  
end
18'd54144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd54145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd54146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd54147: begin  
rid<=0;
end
18'd54201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=7;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17037;
 end   
18'd54202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=84;
   mapp<=47;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19690;
 end   
18'd54203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=47;
   mapp<=39;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=18741;
 end   
18'd54204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=77;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd54205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=75;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd54206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=13;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd54207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=9;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd54208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=71;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd54209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=42;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd54210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=39;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd54211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=36;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd54212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd54213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54215: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54216: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54217: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54218: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54219: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54220: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17037;
 end   
18'd54342: begin  
rid<=1;
end
18'd54343: begin  
end
18'd54344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd54345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd54346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd54347: begin  
rid<=0;
end
18'd54401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=98;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13625;
 end   
18'd54402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=2;
   mapp<=29;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9940;
 end   
18'd54403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=5;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd54404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=38;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd54405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=32;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd54406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=65;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd54407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=16;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd54408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=81;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd54409: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd54410: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd54411: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd54412: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd54413: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13625;
 end   
18'd54414: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13625;
 end   
18'd54415: begin  
  clrr<=0;
  maplen<=7;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13625;
 end   
18'd54542: begin  
rid<=1;
end
18'd54543: begin  
end
18'd54544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd54545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd54546: begin  
rid<=0;
end
18'd54601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=40;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4918;
 end   
18'd54602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=16;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd54603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=88;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd54604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=19;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd54605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd54606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd54607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd54608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd54742: begin  
rid<=1;
end
18'd54743: begin  
end
18'd54744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd54745: begin  
rid<=0;
end
18'd54801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=71;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8422;
 end   
18'd54802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=83;
   mapp<=51;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8171;
 end   
18'd54803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=64;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd54804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd54805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd54942: begin  
rid<=1;
end
18'd54943: begin  
end
18'd54944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd54945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd54946: begin  
rid<=0;
end
18'd55001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=59;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4956;
 end   
18'd55002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=1;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=94;
 end   
18'd55003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=74;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6236;
 end   
18'd55004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=33;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2802;
 end   
18'd55005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=59;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4996;
 end   
18'd55006: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=14;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=1226;
 end   
18'd55007: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=49;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4176;
 end   
18'd55008: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=95;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=8050;
 end   
18'd55009: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=22;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1928;
 end   
18'd55010: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=41;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=3534;
 end   
18'd55011: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd55142: begin  
rid<=1;
end
18'd55143: begin  
end
18'd55144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd55145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd55146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd55147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd55148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd55149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd55150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd55151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd55152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd55153: begin  
check<=expctdoutput[9]-outcheck;
end
18'd55154: begin  
rid<=0;
end
18'd55201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=65;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3380;
 end   
18'd55202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=91;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4742;
 end   
18'd55203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=38;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1996;
 end   
18'd55204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=10;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=550;
 end   
18'd55205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=3524;
 end   
18'd55206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=55;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2910;
 end   
18'd55207: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4584;
 end   
18'd55208: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=24;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1318;
 end   
18'd55209: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=22;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1224;
 end   
18'd55210: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=39;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=2118;
 end   
18'd55211: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=41;
   mapp<=0;
   pp<=100;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[10]<=2232;
 end   
18'd55212: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd55342: begin  
rid<=1;
end
18'd55343: begin  
end
18'd55344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd55345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd55346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd55347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd55348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd55349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd55350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd55351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd55352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd55353: begin  
check<=expctdoutput[9]-outcheck;
end
18'd55354: begin  
check<=expctdoutput[10]-outcheck;
end
18'd55355: begin  
rid<=0;
end
18'd55401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=74;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14365;
 end   
18'd55402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=76;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12475;
 end   
18'd55403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=37;
   mapp<=41;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9667;
 end   
18'd55404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=33;
   mapp<=72;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8101;
 end   
18'd55405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=41;
   mapp<=68;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11344;
 end   
18'd55406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=45;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd55407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd55408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd55409: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=74;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd55410: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd55411: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd55412: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd55413: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14365;
 end   
18'd55414: begin  
  clrr<=0;
  maplen<=5;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14365;
 end   
18'd55542: begin  
rid<=1;
end
18'd55543: begin  
end
18'd55544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd55545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd55546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd55547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd55548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd55549: begin  
rid<=0;
end
18'd55601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=81;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8232;
 end   
18'd55602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=44;
   mapp<=24;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5678;
 end   
18'd55603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=40;
   mapp<=66;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9412;
 end   
18'd55604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=34;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9254;
 end   
18'd55605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=96;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=9022;
 end   
18'd55606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=76;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=5284;
 end   
18'd55607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=27;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2880;
 end   
18'd55608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=5;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6788;
 end   
18'd55609: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=18;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=5978;
 end   
18'd55610: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=91;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd55611: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=41;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd55612: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd55613: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8232;
 end   
18'd55614: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8232;
 end   
18'd55742: begin  
rid<=1;
end
18'd55743: begin  
end
18'd55744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd55745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd55746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd55747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd55748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd55749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd55750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd55751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd55752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd55753: begin  
rid<=0;
end
18'd55801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1003;
 end   
18'd55802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=17;
   mapp<=59;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2161;
 end   
18'd55803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=16;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3693;
 end   
18'd55804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=43;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4499;
 end   
18'd55805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=24;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5520;
 end   
18'd55806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=64;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4889;
 end   
18'd55807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=5;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=3778;
 end   
18'd55808: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=57;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=4235;
 end   
18'd55809: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=2;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=4116;
 end   
18'd55810: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=66;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=9201;
 end   
18'd55811: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=75;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd55812: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd55813: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=1003;
 end   
18'd55942: begin  
rid<=1;
end
18'd55943: begin  
end
18'd55944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd55945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd55946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd55947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd55948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd55949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd55950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd55951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd55952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd55953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd55954: begin  
rid<=0;
end
18'd56001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=52;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6003;
 end   
18'd56002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=1;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3932;
 end   
18'd56003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=26;
   mapp<=45;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8699;
 end   
18'd56004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=53;
   mapp<=3;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10966;
 end   
18'd56005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=84;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=12035;
 end   
18'd56006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=49;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7074;
 end   
18'd56007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6885;
 end   
18'd56008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=5;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=3966;
 end   
18'd56009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=46;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd56010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=25;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd56011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=70;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd56012: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd56013: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6003;
 end   
18'd56014: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6003;
 end   
18'd56015: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6003;
 end   
18'd56142: begin  
rid<=1;
end
18'd56143: begin  
end
18'd56144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd56145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd56146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd56147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd56148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd56149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd56150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd56151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd56152: begin  
rid<=0;
end
18'd56201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=96;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16742;
 end   
18'd56202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=10;
   mapp<=23;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8432;
 end   
18'd56203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=76;
   mapp<=32;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15844;
 end   
18'd56204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=92;
   mapp<=56;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=17936;
 end   
18'd56205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=12712;
 end   
18'd56206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=90;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=15069;
 end   
18'd56207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=95;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=12531;
 end   
18'd56208: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=52;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=8552;
 end   
18'd56209: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd56210: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd56211: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=36;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd56212: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd56213: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16742;
 end   
18'd56214: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16742;
 end   
18'd56215: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16742;
 end   
18'd56342: begin  
rid<=1;
end
18'd56343: begin  
end
18'd56344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd56345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd56346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd56347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd56348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd56349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd56350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd56351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd56352: begin  
rid<=0;
end
18'd56401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=50;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6782;
 end   
18'd56402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=82;
   mapp<=29;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8296;
 end   
18'd56403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=6;
   mapp<=34;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4424;
 end   
18'd56404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8550;
 end   
18'd56405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=84;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10284;
 end   
18'd56406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=90;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=10891;
 end   
18'd56407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=17;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6110;
 end   
18'd56408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=82;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=9416;
 end   
18'd56409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd56410: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd56411: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd56412: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd56413: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6782;
 end   
18'd56542: begin  
rid<=1;
end
18'd56543: begin  
end
18'd56544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd56545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd56546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd56547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd56548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd56549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd56550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd56551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd56552: begin  
rid<=0;
end
18'd56601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=95;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=28486;
 end   
18'd56602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=80;
   mapp<=10;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24847;
 end   
18'd56603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=38;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd56604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=67;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd56605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=20;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd56606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=45;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd56607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=83;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd56608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=65;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd56609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=96;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd56610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=33;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd56611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd56612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd56613: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56614: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56615: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56616: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56617: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56618: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56619: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28486;
 end   
18'd56742: begin  
rid<=1;
end
18'd56743: begin  
end
18'd56744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd56745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd56746: begin  
rid<=0;
end
18'd56801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=13;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10710;
 end   
18'd56802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=39;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9968;
 end   
18'd56803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=52;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd56804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=45;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd56805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=61;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd56806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=51;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd56807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd56808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd56809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd56810: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd56811: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd56812: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd56813: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=10710;
 end   
18'd56942: begin  
rid<=1;
end
18'd56943: begin  
end
18'd56944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd56945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd56946: begin  
rid<=0;
end
18'd57001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=11;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=143;
 end   
18'd57002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=7;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=87;
 end   
18'd57003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=614;
 end   
18'd57004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=76;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=866;
 end   
18'd57005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=17;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=227;
 end   
18'd57006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd57142: begin  
rid<=1;
end
18'd57143: begin  
end
18'd57144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd57145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd57146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd57147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd57148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd57149: begin  
rid<=0;
end
18'd57201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=64;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=27501;
 end   
18'd57202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=62;
   mapp<=31;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=29957;
 end   
18'd57203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=10;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd57204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=46;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd57205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=65;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd57206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=80;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd57207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=65;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd57208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=46;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd57209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=40;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd57210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=97;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd57211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd57212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd57213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57215: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57216: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57217: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57218: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57219: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27501;
 end   
18'd57342: begin  
rid<=1;
end
18'd57343: begin  
end
18'd57344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd57345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd57346: begin  
rid<=0;
end
18'd57401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=70;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7840;
 end   
18'd57402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=15;
   mapp<=84;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1420;
 end   
18'd57403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=524;
 end   
18'd57404: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=6;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1098;
 end   
18'd57405: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=6;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=772;
 end   
18'd57406: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=2;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=8302;
 end   
18'd57407: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=96;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=11856;
 end   
18'd57408: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=33;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=4096;
 end   
18'd57409: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=11;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=6742;
 end   
18'd57410: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=7648;
 end   
18'd57411: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd57412: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd57413: begin  
  clrr<=0;
  maplen<=2;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7840;
 end   
18'd57542: begin  
rid<=1;
end
18'd57543: begin  
end
18'd57544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd57545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd57546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd57547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd57548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd57549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd57550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd57551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd57552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd57553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd57554: begin  
rid<=0;
end
18'd57601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=19;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4818;
 end   
18'd57602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=79;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8500;
 end   
18'd57603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd57604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd57605: begin  
  clrr<=0;
  maplen<=2;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd57742: begin  
rid<=1;
end
18'd57743: begin  
end
18'd57744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd57745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd57746: begin  
rid<=0;
end
18'd57801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=99;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11723;
 end   
18'd57802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=20;
   mapp<=97;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10833;
 end   
18'd57803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=20;
   mapp<=9;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3371;
 end   
18'd57804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=52;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7758;
 end   
18'd57805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=71;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=8669;
 end   
18'd57806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=58;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=7412;
 end   
18'd57807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=22;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=5358;
 end   
18'd57808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=59;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=9831;
 end   
18'd57809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd57810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd57811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd57812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd57813: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11723;
 end   
18'd57942: begin  
rid<=1;
end
18'd57943: begin  
end
18'd57944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd57945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd57946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd57947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd57948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd57949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd57950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd57951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd57952: begin  
rid<=0;
end
18'd58001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=99;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1188;
 end   
18'd58002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1495;
 end   
18'd58003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=53;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5267;
 end   
18'd58004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=85;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8445;
 end   
18'd58005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=41;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4099;
 end   
18'd58006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd58142: begin  
rid<=1;
end
18'd58143: begin  
end
18'd58144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd58145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd58146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd58147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd58148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd58149: begin  
rid<=0;
end
18'd58201: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=6;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16381;
 end   
18'd58202: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=49;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd58203: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=75;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd58204: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=26;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd58205: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=24;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd58206: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=7;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd58207: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=74;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd58208: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd58209: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd58210: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd58211: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd58212: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd58213: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16381;
 end   
18'd58214: begin  
  clrr<=0;
  maplen<=7;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16381;
 end   
18'd58342: begin  
rid<=1;
end
18'd58343: begin  
end
18'd58344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd58345: begin  
rid<=0;
end
18'd58401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=14;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8357;
 end   
18'd58402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=49;
   mapp<=45;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8402;
 end   
18'd58403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=68;
   mapp<=81;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5425;
 end   
18'd58404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=38;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9626;
 end   
18'd58405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=7;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4871;
 end   
18'd58406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=93;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4913;
 end   
18'd58407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=4;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=8326;
 end   
18'd58408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=5;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6042;
 end   
18'd58409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=97;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd58410: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=17;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd58411: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd58412: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd58413: begin  
  clrr<=0;
  maplen<=3;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8357;
 end   
18'd58542: begin  
rid<=1;
end
18'd58543: begin  
end
18'd58544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd58545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd58546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd58547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd58548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd58549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd58550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd58551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd58552: begin  
rid<=0;
end
18'd58601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=33;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14708;
 end   
18'd58602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=54;
   mapp<=33;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16366;
 end   
18'd58603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=30;
   mapp<=97;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16673;
 end   
18'd58604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=52;
   mapp<=79;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=22503;
 end   
18'd58605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=4;
   mapp<=36;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=22789;
 end   
18'd58606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=79;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd58607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd58608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=70;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd58609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=54;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd58610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=72;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd58611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd58612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd58613: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14708;
 end   
18'd58614: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14708;
 end   
18'd58615: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14708;
 end   
18'd58616: begin  
  clrr<=0;
  maplen<=6;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14708;
 end   
18'd58742: begin  
rid<=1;
end
18'd58743: begin  
end
18'd58744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd58745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd58746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd58747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd58748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd58749: begin  
rid<=0;
end
18'd58801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=31;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7345;
 end   
18'd58802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=80;
   mapp<=86;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7660;
 end   
18'd58803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=75;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6305;
 end   
18'd58804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=60;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2134;
 end   
18'd58805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=14;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd58806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd58807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd58942: begin  
rid<=1;
end
18'd58943: begin  
end
18'd58944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd58945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd58946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd58947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd58948: begin  
rid<=0;
end
18'd59001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=31;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=10454;
 end   
18'd59002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=61;
   mapp<=38;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10424;
 end   
18'd59003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=19;
   mapp<=81;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7654;
 end   
18'd59004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=81;
   mapp<=47;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10061;
 end   
18'd59005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd59006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=18;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd59007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd59008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd59009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd59010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd59011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd59142: begin  
rid<=1;
end
18'd59143: begin  
end
18'd59144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd59145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd59146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd59147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd59148: begin  
rid<=0;
end
18'd59201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=2;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1950;
 end   
18'd59202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=28;
   mapp<=63;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3545;
 end   
18'd59203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=21;
   mapp<=2;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7800;
 end   
18'd59204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=98;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10137;
 end   
18'd59205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=47;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6271;
 end   
18'd59206: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=45;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3712;
 end   
18'd59207: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=6;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd59208: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=22;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd59209: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd59210: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd59211: begin  
  clrr<=0;
  maplen<=3;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd59342: begin  
rid<=1;
end
18'd59343: begin  
end
18'd59344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd59345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd59346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd59347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd59348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd59349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd59350: begin  
rid<=0;
end
18'd59401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=37;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=24033;
 end   
18'd59402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=53;
   mapp<=44;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21784;
 end   
18'd59403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=68;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd59404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=30;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd59405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=55;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd59406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=66;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd59407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=58;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd59408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=12;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd59409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=56;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd59410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd59411: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd59412: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd59413: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24033;
 end   
18'd59414: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24033;
 end   
18'd59415: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24033;
 end   
18'd59416: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24033;
 end   
18'd59417: begin  
  clrr<=0;
  maplen<=8;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24033;
 end   
18'd59542: begin  
rid<=1;
end
18'd59543: begin  
end
18'd59544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd59545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd59546: begin  
rid<=0;
end
18'd59601: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=50;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7800;
 end   
18'd59602: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=75;
   mapp<=76;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4260;
 end   
18'd59603: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=6;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=470;
 end   
18'd59604: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=2;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6430;
 end   
18'd59605: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=84;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5965;
 end   
18'd59606: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=23;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=6450;
 end   
18'd59607: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=70;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4460;
 end   
18'd59608: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd59609: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd59610: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd59742: begin  
rid<=1;
end
18'd59743: begin  
end
18'd59744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd59745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd59746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd59747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd59748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd59749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd59750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd59751: begin  
rid<=0;
end
18'd59801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=92;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=27986;
 end   
18'd59802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=48;
   mapp<=88;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=22309;
 end   
18'd59803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=84;
   mapp<=20;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=23015;
 end   
18'd59804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=45;
   mapp<=1;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=23840;
 end   
18'd59805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=87;
   mapp<=83;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=26534;
 end   
18'd59806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=62;
   mapp<=98;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=18404;
 end   
18'd59807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=43;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd59808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=58;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd59809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd59810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=71;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd59811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd59812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd59813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27986;
 end   
18'd59814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27986;
 end   
18'd59815: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27986;
 end   
18'd59816: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27986;
 end   
18'd59817: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27986;
 end   
18'd59942: begin  
rid<=1;
end
18'd59943: begin  
end
18'd59944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd59945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd59946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd59947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd59948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd59949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd59950: begin  
rid<=0;
end
18'd60001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=46;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=25978;
 end   
18'd60002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=69;
   mapp<=83;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20325;
 end   
18'd60003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=75;
   mapp<=88;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=23081;
 end   
18'd60004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=17;
   mapp<=15;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=18107;
 end   
18'd60005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=87;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd60006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=20;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd60007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=30;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd60008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=42;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd60009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd60010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd60011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd60012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd60013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60017: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60018: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60019: begin  
  clrr<=0;
  maplen<=11;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25978;
 end   
18'd60142: begin  
rid<=1;
end
18'd60143: begin  
end
18'd60144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd60145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd60146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd60147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd60148: begin  
rid<=0;
end
18'd60201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=13;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=27867;
 end   
18'd60202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=35;
   mapp<=80;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=28564;
 end   
18'd60203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=35;
   mapp<=73;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=22819;
 end   
18'd60204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=83;
   mapp<=77;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=20143;
 end   
18'd60205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=86;
   mapp<=86;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=20248;
 end   
18'd60206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=96;
   mapp<=81;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=23537;
 end   
18'd60207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd60208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd60209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd60210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd60211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd60212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd60213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27867;
 end   
18'd60214: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27867;
 end   
18'd60215: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27867;
 end   
18'd60216: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27867;
 end   
18'd60217: begin  
  clrr<=0;
  maplen<=11;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=27867;
 end   
18'd60342: begin  
rid<=1;
end
18'd60343: begin  
end
18'd60344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd60345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd60346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd60347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd60348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd60349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd60350: begin  
rid<=0;
end
18'd60401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=60;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4842;
 end   
18'd60402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=82;
   mapp<=21;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5030;
 end   
18'd60403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=36;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3740;
 end   
18'd60404: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=88;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5005;
 end   
18'd60405: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=19;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1784;
 end   
18'd60406: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=36;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3854;
 end   
18'd60407: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=92;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd60408: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd60409: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd60542: begin  
rid<=1;
end
18'd60543: begin  
end
18'd60544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd60545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd60546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd60547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd60548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd60549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd60550: begin  
rid<=0;
end
18'd60601: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=21;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12839;
 end   
18'd60602: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=2;
   mapp<=96;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11750;
 end   
18'd60603: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=45;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd60604: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=2;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd60605: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=64;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd60606: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=39;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd60607: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=72;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd60608: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd60609: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd60610: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd60611: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd60612: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd60613: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12839;
 end   
18'd60742: begin  
rid<=1;
end
18'd60743: begin  
end
18'd60744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd60745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd60746: begin  
rid<=0;
end
18'd60801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=80;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12261;
 end   
18'd60802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=98;
   mapp<=54;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10424;
 end   
18'd60803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=91;
   mapp<=59;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5670;
 end   
18'd60804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=60;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7139;
 end   
18'd60805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=10;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd60806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=91;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd60807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd60808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd60809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd60942: begin  
rid<=1;
end
18'd60943: begin  
end
18'd60944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd60945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd60946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd60947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd60948: begin  
rid<=0;
end
18'd61001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=72;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5400;
 end   
18'd61002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=36;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=2602;
 end   
18'd61003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=99;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=7148;
 end   
18'd61004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=75;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5430;
 end   
18'd61005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=90;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6520;
 end   
18'd61006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=76;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5522;
 end   
18'd61007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=56;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4092;
 end   
18'd61008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd61142: begin  
rid<=1;
end
18'd61143: begin  
end
18'd61144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd61145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd61146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd61147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd61148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd61149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd61150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd61151: begin  
rid<=0;
end
18'd61201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=42;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4239;
 end   
18'd61202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=95;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7365;
 end   
18'd61203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=66;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5282;
 end   
18'd61204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=56;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=5072;
 end   
18'd61205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=86;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd61206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd61207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd61342: begin  
rid<=1;
end
18'd61343: begin  
end
18'd61344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd61345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd61346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd61347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd61348: begin  
rid<=0;
end
18'd61401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=64;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1664;
 end   
18'd61402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=85;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2220;
 end   
18'd61403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=65;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1710;
 end   
18'd61404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=8;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=238;
 end   
18'd61405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd61542: begin  
rid<=1;
end
18'd61543: begin  
end
18'd61544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd61545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd61546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd61547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd61548: begin  
rid<=0;
end
18'd61601: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=12;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2976;
 end   
18'd61602: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=52;
   mapp<=54;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2790;
 end   
18'd61603: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=38;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=876;
 end   
18'd61604: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=6;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1464;
 end   
18'd61605: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=25;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2010;
 end   
18'd61606: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=30;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=3116;
 end   
18'd61607: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=49;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=5012;
 end   
18'd61608: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=79;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd61609: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd61610: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd61742: begin  
rid<=1;
end
18'd61743: begin  
end
18'd61744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd61745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd61746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd61747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd61748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd61749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd61750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd61751: begin  
rid<=0;
end
18'd61801: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=81;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14027;
 end   
18'd61802: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=70;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16756;
 end   
18'd61803: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=47;
   mapp<=21;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20772;
 end   
18'd61804: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=53;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd61805: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=8;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd61806: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=8;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd61807: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=15;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd61808: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=29;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd61809: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=66;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd61810: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd61811: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=73;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd61812: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd61813: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61814: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61815: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61816: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61817: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61818: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61819: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61820: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14027;
 end   
18'd61942: begin  
rid<=1;
end
18'd61943: begin  
end
18'd61944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd61945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd61946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd61947: begin  
rid<=0;
end
18'd62001: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=31;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2201;
 end   
18'd62002: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=41;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1281;
 end   
18'd62003: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=59;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1849;
 end   
18'd62004: begin  
  clrr<=0;
  maplen<=3;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd62142: begin  
rid<=1;
end
18'd62143: begin  
end
18'd62144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd62145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd62146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd62147: begin  
rid<=0;
end
18'd62201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=27;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19102;
 end   
18'd62202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=13;
   mapp<=88;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19708;
 end   
18'd62203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=23;
   mapp<=70;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15734;
 end   
18'd62204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=71;
   mapp<=68;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16542;
 end   
18'd62205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=27;
   mapp<=99;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=14734;
 end   
18'd62206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=73;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd62207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=61;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd62208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd62209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd62210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd62211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd62212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd62213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62214: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62215: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62216: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62217: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62218: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19102;
 end   
18'd62342: begin  
rid<=1;
end
18'd62343: begin  
end
18'd62344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd62345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd62346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd62347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd62348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd62349: begin  
rid<=0;
end
18'd62401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=95;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1321;
 end   
18'd62402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=13;
   mapp<=87;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8496;
 end   
18'd62403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=17;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2454;
 end   
18'd62404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=63;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6704;
 end   
18'd62405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=53;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5413;
 end   
18'd62406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=26;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3755;
 end   
18'd62407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd62408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd62409: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd62542: begin  
rid<=1;
end
18'd62543: begin  
end
18'd62544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd62545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd62546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd62547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd62548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd62549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd62550: begin  
rid<=0;
end
18'd62601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=93;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12152;
 end   
18'd62602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=85;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10780;
 end   
18'd62603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=65;
   mapp<=96;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13248;
 end   
18'd62604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=33;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8434;
 end   
18'd62605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=23;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=11734;
 end   
18'd62606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=52;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=12836;
 end   
18'd62607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=79;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=10712;
 end   
18'd62608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd62609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd62610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd62611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd62612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd62742: begin  
rid<=1;
end
18'd62743: begin  
end
18'd62744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd62745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd62746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd62747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd62748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd62749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd62750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd62751: begin  
rid<=0;
end
18'd62801: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=90;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=630;
 end   
18'd62802: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=6400;
 end   
18'd62803: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=87;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=7850;
 end   
18'd62804: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=99;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8940;
 end   
18'd62805: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=19;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1750;
 end   
18'd62806: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=96;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8690;
 end   
18'd62807: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=15;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=1410;
 end   
18'd62808: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=52;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=4750;
 end   
18'd62809: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=92;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=8360;
 end   
18'd62810: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=53;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=4860;
 end   
18'd62811: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=57;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=5230;
 end   
18'd62812: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd62942: begin  
rid<=1;
end
18'd62943: begin  
end
18'd62944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd62945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd62946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd62947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd62948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd62949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd62950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd62951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd62952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd62953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd62954: begin  
check<=expctdoutput[10]-outcheck;
end
18'd62955: begin  
rid<=0;
end
18'd63001: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=9;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=774;
 end   
18'd63002: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=65;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5600;
 end   
18'd63003: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=86;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7416;
 end   
18'd63004: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=19;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1664;
 end   
18'd63005: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd63142: begin  
rid<=1;
end
18'd63143: begin  
end
18'd63144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd63145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd63146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd63147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd63148: begin  
rid<=0;
end
18'd63201: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=78;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13823;
 end   
18'd63202: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=74;
   mapp<=28;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16335;
 end   
18'd63203: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=95;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd63204: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=43;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd63205: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=74;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd63206: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=16;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd63207: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd63208: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd63209: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd63210: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd63211: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd63212: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd63213: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13823;
 end   
18'd63342: begin  
rid<=1;
end
18'd63343: begin  
end
18'd63344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd63345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd63346: begin  
rid<=0;
end
18'd63401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=22;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19632;
 end   
18'd63402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=83;
   mapp<=22;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23677;
 end   
18'd63403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=31;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd63404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=3;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd63405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=32;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd63406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd63407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=90;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd63408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=80;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd63409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=8;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd63410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd63411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd63412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd63413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63414: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63415: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63416: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63417: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63418: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63419: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19632;
 end   
18'd63542: begin  
rid<=1;
end
18'd63543: begin  
end
18'd63544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd63545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd63546: begin  
rid<=0;
end
18'd63601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=13;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16724;
 end   
18'd63602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=32;
   mapp<=18;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18451;
 end   
18'd63603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=92;
   mapp<=57;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=19975;
 end   
18'd63604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=82;
   mapp<=61;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=19850;
 end   
18'd63605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=67;
   mapp<=20;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=21126;
 end   
18'd63606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=20;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd63607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=58;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd63608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=74;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd63609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=87;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd63610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=94;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd63611: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=83;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd63612: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd63613: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63614: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63615: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63616: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63617: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63618: begin  
  clrr<=0;
  maplen<=7;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16724;
 end   
18'd63742: begin  
rid<=1;
end
18'd63743: begin  
end
18'd63744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd63745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd63746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd63747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd63748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd63749: begin  
rid<=0;
end
18'd63801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=25;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8550;
 end   
18'd63802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=55;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9708;
 end   
18'd63803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=63;
   mapp<=90;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12264;
 end   
18'd63804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=67;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=7990;
 end   
18'd63805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=92;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4464;
 end   
18'd63806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=31;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd63807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=19;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd63808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd63809: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd63810: begin  
  clrr<=0;
  maplen<=3;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd63942: begin  
rid<=1;
end
18'd63943: begin  
end
18'd63944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd63945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd63946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd63947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd63948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd63949: begin  
rid<=0;
end
18'd64001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=59;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17572;
 end   
18'd64002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=18;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19457;
 end   
18'd64003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=20;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd64004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=35;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd64005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=14;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd64006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=56;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd64007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=47;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd64008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=56;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd64009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=34;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd64010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=60;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd64011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=51;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd64012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd64013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64018: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64019: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64020: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64021: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17572;
 end   
18'd64142: begin  
rid<=1;
end
18'd64143: begin  
end
18'd64144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd64145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd64146: begin  
rid<=0;
end
18'd64201: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=89;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19454;
 end   
18'd64202: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=72;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14851;
 end   
18'd64203: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=19;
   mapp<=24;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10959;
 end   
18'd64204: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=1;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd64205: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=2;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd64206: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=44;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd64207: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=23;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd64208: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=39;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd64209: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd64210: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd64211: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd64212: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd64213: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19454;
 end   
18'd64214: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19454;
 end   
18'd64342: begin  
rid<=1;
end
18'd64343: begin  
end
18'd64344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd64345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd64346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd64347: begin  
rid<=0;
end
18'd64401: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=14;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2512;
 end   
18'd64402: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=15;
   mapp<=86;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2642;
 end   
18'd64403: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=44;
   mapp<=16;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3685;
 end   
18'd64404: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=27;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=2455;
 end   
18'd64405: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=69;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5707;
 end   
18'd64406: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd64407: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd64408: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd64409: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd64410: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd64542: begin  
rid<=1;
end
18'd64543: begin  
end
18'd64544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd64545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd64546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd64547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd64548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd64549: begin  
rid<=0;
end
18'd64601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=52;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9698;
 end   
18'd64602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=46;
   mapp<=76;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7280;
 end   
18'd64603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=37;
   mapp<=58;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9150;
 end   
18'd64604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=15;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8816;
 end   
18'd64605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=88;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=13224;
 end   
18'd64606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=16;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=12742;
 end   
18'd64607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=88;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=17448;
 end   
18'd64608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd64609: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=74;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd64610: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd64611: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd64612: begin  
  clrr<=0;
  maplen<=3;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd64742: begin  
rid<=1;
end
18'd64743: begin  
end
18'd64744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd64745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd64746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd64747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd64748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd64749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd64750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd64751: begin  
rid<=0;
end
18'd64801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=42;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15362;
 end   
18'd64802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=84;
   mapp<=56;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16322;
 end   
18'd64803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=72;
   mapp<=62;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15190;
 end   
18'd64804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=49;
   mapp<=16;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=13297;
 end   
18'd64805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=96;
   mapp<=24;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=14252;
 end   
18'd64806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=26;
   mapp<=29;
   pp<=50;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=9691;
 end   
18'd64807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd64808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=2;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd64809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=75;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd64810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd64811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=65;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd64812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd64813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15362;
 end   
18'd64814: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15362;
 end   
18'd64815: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15362;
 end   
18'd64816: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15362;
 end   
18'd64817: begin  
  clrr<=0;
  maplen<=6;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15362;
 end   
18'd64942: begin  
rid<=1;
end
18'd64943: begin  
end
18'd64944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd64945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd64946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd64947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd64948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd64949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd64950: begin  
rid<=0;
end
18'd65001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=17;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12193;
 end   
18'd65002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=93;
   mapp<=17;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12713;
 end   
18'd65003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=73;
   mapp<=44;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17794;
 end   
18'd65004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=60;
   mapp<=54;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14289;
 end   
18'd65005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=75;
   mapp<=43;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=13125;
 end   
18'd65006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=24;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=15006;
 end   
18'd65007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=99;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=8277;
 end   
18'd65008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd65009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=21;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd65010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd65011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd65012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd65013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12193;
 end   
18'd65014: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12193;
 end   
18'd65015: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12193;
 end   
18'd65016: begin  
  clrr<=0;
  maplen<=11;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12193;
 end   
18'd65142: begin  
rid<=1;
end
18'd65143: begin  
end
18'd65144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd65145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd65146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd65147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd65148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd65149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd65150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd65151: begin  
rid<=0;
end
18'd65201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=93;
   mapp<=1;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=269;
 end   
18'd65202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=8;
   mapp<=22;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2120;
 end   
18'd65203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=8;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1524;
 end   
18'd65204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=95;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=9073;
 end   
18'd65205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=26;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2618;
 end   
18'd65206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=20;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2638;
 end   
18'd65207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=91;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=9227;
 end   
18'd65208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=88;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=8486;
 end   
18'd65209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=29;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=3353;
 end   
18'd65210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=72;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=7402;
 end   
18'd65211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd65212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd65213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=269;
 end   
18'd65342: begin  
rid<=1;
end
18'd65343: begin  
end
18'd65344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd65345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd65346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd65347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd65348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd65349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd65350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd65351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd65352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd65353: begin  
check<=expctdoutput[9]-outcheck;
end
18'd65354: begin  
rid<=0;
end
18'd65401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=37;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2812;
 end   
18'd65402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=16;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1226;
 end   
18'd65403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=3;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=248;
 end   
18'd65404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=90;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6870;
 end   
18'd65405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=12;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=952;
 end   
18'd65406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=89;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=6814;
 end   
18'd65407: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=53;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4088;
 end   
18'd65408: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=79;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=6074;
 end   
18'd65409: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=99;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=7604;
 end   
18'd65410: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=22;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=1762;
 end   
18'd65411: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd65542: begin  
rid<=1;
end
18'd65543: begin  
end
18'd65544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd65545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd65546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd65547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd65548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd65549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd65550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd65551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd65552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd65553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd65554: begin  
rid<=0;
end
18'd65601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=54;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3726;
 end   
18'd65602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=29;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2011;
 end   
18'd65603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=34;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2366;
 end   
18'd65604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=38;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2652;
 end   
18'd65605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd65742: begin  
rid<=1;
end
18'd65743: begin  
end
18'd65744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd65745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd65746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd65747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd65748: begin  
rid<=0;
end
18'd65801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=95;
   mapp<=63;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8671;
 end   
18'd65802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=79;
   mapp<=34;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8928;
 end   
18'd65803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=72;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=10652;
 end   
18'd65804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=48;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8777;
 end   
18'd65805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=53;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5312;
 end   
18'd65806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=3;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=888;
 end   
18'd65807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=7;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2147;
 end   
18'd65808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=18;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=4387;
 end   
18'd65809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=33;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=6138;
 end   
18'd65810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd65811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd65812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd65942: begin  
rid<=1;
end
18'd65943: begin  
end
18'd65944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd65945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd65946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd65947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd65948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd65949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd65950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd65951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd65952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd65953: begin  
rid<=0;
end
18'd66001: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=7;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=413;
 end   
18'd66002: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=61;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=437;
 end   
18'd66003: begin  
  clrr<=0;
  maplen<=2;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd66142: begin  
rid<=1;
end
18'd66143: begin  
end
18'd66144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd66145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd66146: begin  
rid<=0;
end
18'd66201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=32;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=17410;
 end   
18'd66202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=56;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18730;
 end   
18'd66203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=58;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd66204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=49;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd66205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=20;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd66206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=96;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd66207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=24;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd66208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=20;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd66209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=26;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd66210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd66211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd66212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd66213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66218: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66219: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=17410;
 end   
18'd66342: begin  
rid<=1;
end
18'd66343: begin  
end
18'd66344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd66345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd66346: begin  
rid<=0;
end
18'd66401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=4;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16021;
 end   
18'd66402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=77;
   mapp<=74;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15773;
 end   
18'd66403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=53;
   mapp<=91;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11477;
 end   
18'd66404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=42;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd66405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=4;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd66406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=23;
   mapp<=64;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd66407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=52;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd66408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=25;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd66409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd66410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd66411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd66412: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd66413: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16021;
 end   
18'd66414: begin  
  clrr<=0;
  maplen<=6;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16021;
 end   
18'd66542: begin  
rid<=1;
end
18'd66543: begin  
end
18'd66544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd66545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd66546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd66547: begin  
rid<=0;
end
18'd66601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=49;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1176;
 end   
18'd66602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=35;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=850;
 end   
18'd66603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd66742: begin  
rid<=1;
end
18'd66743: begin  
end
18'd66744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd66745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd66746: begin  
rid<=0;
end
18'd66801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=79;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6714;
 end   
18'd66802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=2;
   mapp<=55;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11186;
 end   
18'd66803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=83;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd66804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=92;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd66805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=32;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd66806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd66807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd66808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd66809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd66810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd66811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd66942: begin  
rid<=1;
end
18'd66943: begin  
end
18'd66944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd66945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd66946: begin  
rid<=0;
end
18'd67001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=71;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21380;
 end   
18'd67002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=78;
   mapp<=47;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17720;
 end   
18'd67003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=40;
   mapp<=5;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=19779;
 end   
18'd67004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=56;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd67005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=48;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd67006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=44;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd67007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=45;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd67008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=25;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd67009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd67010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd67011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd67012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd67013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67017: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67018: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21380;
 end   
18'd67142: begin  
rid<=1;
end
18'd67143: begin  
end
18'd67144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd67145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd67146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd67147: begin  
rid<=0;
end
18'd67201: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=79;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8704;
 end   
18'd67202: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=93;
   mapp<=80;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7725;
 end   
18'd67203: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=15;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=7157;
 end   
18'd67204: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=64;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7504;
 end   
18'd67205: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=26;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=8790;
 end   
18'd67206: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd67207: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd67208: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd67342: begin  
rid<=1;
end
18'd67343: begin  
end
18'd67344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd67345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd67346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd67347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd67348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd67349: begin  
rid<=0;
end
18'd67401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=8;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3646;
 end   
18'd67402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=96;
   mapp<=33;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4060;
 end   
18'd67403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=38;
   mapp<=5;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9628;
 end   
18'd67404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=87;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5242;
 end   
18'd67405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=32;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6414;
 end   
18'd67406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=38;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9026;
 end   
18'd67407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=65;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=7408;
 end   
18'd67408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=64;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=6072;
 end   
18'd67409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=18;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=10944;
 end   
18'd67410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd67411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd67412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd67413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3646;
 end   
18'd67414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=3646;
 end   
18'd67542: begin  
rid<=1;
end
18'd67543: begin  
end
18'd67544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd67545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd67546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd67547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd67548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd67549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd67550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd67551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd67552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd67553: begin  
rid<=0;
end
18'd67601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=43;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1935;
 end   
18'd67602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=59;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=2547;
 end   
18'd67603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2987;
 end   
18'd67604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=44;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=1922;
 end   
18'd67605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=62;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2706;
 end   
18'd67606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3017;
 end   
18'd67607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=49;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2167;
 end   
18'd67608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=18;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=844;
 end   
18'd67609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=67;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=2961;
 end   
18'd67610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=58;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=2584;
 end   
18'd67611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd67742: begin  
rid<=1;
end
18'd67743: begin  
end
18'd67744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd67745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd67746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd67747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd67748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd67749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd67750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd67751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd67752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd67753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd67754: begin  
rid<=0;
end
18'd67801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=68;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9872;
 end   
18'd67802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=23;
   mapp<=86;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8936;
 end   
18'd67803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=47;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd67804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=96;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd67805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=66;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd67806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=30;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd67807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=65;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd67808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd67809: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd67810: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd67811: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd67812: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd67813: begin  
  clrr<=0;
  maplen<=6;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9872;
 end   
18'd67942: begin  
rid<=1;
end
18'd67943: begin  
end
18'd67944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd67945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd67946: begin  
rid<=0;
end
18'd68001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=24;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2452;
 end   
18'd68002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=28;
   mapp<=73;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4170;
 end   
18'd68003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=3988;
 end   
18'd68004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=68;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4378;
 end   
18'd68005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=97;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4580;
 end   
18'd68006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd68007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd68008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd68142: begin  
rid<=1;
end
18'd68143: begin  
end
18'd68144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd68145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd68146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd68147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd68148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd68149: begin  
rid<=0;
end
18'd68201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=52;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9047;
 end   
18'd68202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=69;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd68203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=62;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd68204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=70;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd68205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd68206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd68207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd68208: begin  
  clrr<=0;
  maplen<=4;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd68342: begin  
rid<=1;
end
18'd68343: begin  
end
18'd68344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd68345: begin  
rid<=0;
end
18'd68401: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=67;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18832;
 end   
18'd68402: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=54;
   mapp<=11;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16645;
 end   
18'd68403: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=87;
   mapp<=64;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=22862;
 end   
18'd68404: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=17;
   mapp<=50;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14418;
 end   
18'd68405: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=65;
   mapp<=60;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd68406: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=42;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd68407: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd68408: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=73;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd68409: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=15;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd68410: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd68411: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd68412: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd68413: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18832;
 end   
18'd68414: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18832;
 end   
18'd68415: begin  
  clrr<=0;
  maplen<=6;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18832;
 end   
18'd68542: begin  
rid<=1;
end
18'd68543: begin  
end
18'd68544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd68545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd68546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd68547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd68548: begin  
rid<=0;
end
18'd68601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=30;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6701;
 end   
18'd68602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=9;
   mapp<=69;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5368;
 end   
18'd68603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=40;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6623;
 end   
18'd68604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=21;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd68605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=19;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd68606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd68607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd68608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd68742: begin  
rid<=1;
end
18'd68743: begin  
end
18'd68744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd68745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd68746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd68747: begin  
rid<=0;
end
18'd68801: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=99;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2376;
 end   
18'd68802: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=36;
   mapp<=11;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3043;
 end   
18'd68803: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=8714;
 end   
18'd68804: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=93;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=12261;
 end   
18'd68805: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=84;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=10408;
 end   
18'd68806: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd68807: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd68808: begin  
  clrr<=0;
  maplen<=6;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd68942: begin  
rid<=1;
end
18'd68943: begin  
end
18'd68944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd68945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd68946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd68947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd68948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd68949: begin  
rid<=0;
end
18'd69001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=17;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=20369;
 end   
18'd69002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=13;
   mapp<=5;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20573;
 end   
18'd69003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=53;
   mapp<=65;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=29554;
 end   
18'd69004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=17;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd69005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=77;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd69006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=60;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd69007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=5;
   mapp<=92;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd69008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=53;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd69009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=91;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd69010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=62;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd69011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=76;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd69012: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd69013: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69014: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69015: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69016: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69017: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69018: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69019: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69020: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=20369;
 end   
18'd69142: begin  
rid<=1;
end
18'd69143: begin  
end
18'd69144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd69145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd69146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd69147: begin  
rid<=0;
end
18'd69201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=45;
   mapp<=34;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6665;
 end   
18'd69202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=52;
   mapp<=16;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9253;
 end   
18'd69203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=47;
   mapp<=50;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9096;
 end   
18'd69204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=21;
   mapp<=93;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=9407;
 end   
18'd69205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=61;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11906;
 end   
18'd69206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=44;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=13695;
 end   
18'd69207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd69208: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd69209: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=85;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd69210: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd69211: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd69212: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd69213: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=6665;
 end   
18'd69342: begin  
rid<=1;
end
18'd69343: begin  
end
18'd69344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd69345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd69346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd69347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd69348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd69349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd69350: begin  
rid<=0;
end
18'd69401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=98;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6942;
 end   
18'd69402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=92;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11642;
 end   
18'd69403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=9912;
 end   
18'd69404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=50;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=7874;
 end   
18'd69405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=32;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=12284;
 end   
18'd69406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=99;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=11592;
 end   
18'd69407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=20;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=5240;
 end   
18'd69408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd69409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd69410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd69542: begin  
rid<=1;
end
18'd69543: begin  
end
18'd69544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd69545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd69546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd69547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd69548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd69549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd69550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd69551: begin  
rid<=0;
end
18'd69601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=3;
   filterp<=16;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=464;
 end   
18'd69602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=3;
   filterp<=59;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1721;
 end   
18'd69603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=3;
   filterp<=58;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1702;
 end   
18'd69604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd69742: begin  
rid<=1;
end
18'd69743: begin  
end
18'd69744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd69745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd69746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd69747: begin  
rid<=0;
end
18'd69801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=95;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12129;
 end   
18'd69802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=86;
   mapp<=57;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13842;
 end   
18'd69803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=3;
   mapp<=70;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17062;
 end   
18'd69804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=52;
   mapp<=71;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=14631;
 end   
18'd69805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=42;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=11453;
 end   
18'd69806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd69807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd69808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd69809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd69810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd69811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd69812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd69942: begin  
rid<=1;
end
18'd69943: begin  
end
18'd69944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd69945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd69946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd69947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd69948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd69949: begin  
rid<=0;
end
18'd70001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=41;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4549;
 end   
18'd70002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=38;
   mapp<=28;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4122;
 end   
18'd70003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=78;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=5498;
 end   
18'd70004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=60;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=2528;
 end   
18'd70005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=1;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1943;
 end   
18'd70006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=49;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=4491;
 end   
18'd70007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=64;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=5914;
 end   
18'd70008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=85;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=4543;
 end   
18'd70009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=26;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=3312;
 end   
18'd70010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=57;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=3833;
 end   
18'd70011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd70012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd70013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=4549;
 end   
18'd70142: begin  
rid<=1;
end
18'd70143: begin  
end
18'd70144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd70145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd70146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd70147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd70148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd70149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd70150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd70151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd70152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd70153: begin  
check<=expctdoutput[9]-outcheck;
end
18'd70154: begin  
rid<=0;
end
18'd70201: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=23;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12074;
 end   
18'd70202: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=99;
   mapp<=93;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11144;
 end   
18'd70203: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=31;
   mapp<=68;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9896;
 end   
18'd70204: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=73;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5453;
 end   
18'd70205: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=35;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4712;
 end   
18'd70206: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=9;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=12272;
 end   
18'd70207: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=96;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=12178;
 end   
18'd70208: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=81;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=9181;
 end   
18'd70209: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=61;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=7948;
 end   
18'd70210: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd70211: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd70212: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd70213: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12074;
 end   
18'd70214: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12074;
 end   
18'd70342: begin  
rid<=1;
end
18'd70343: begin  
end
18'd70344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd70345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd70346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd70347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd70348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd70349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd70350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd70351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd70352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd70353: begin  
rid<=0;
end
18'd70401: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=40;
   mapp<=6;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5691;
 end   
18'd70402: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=69;
   mapp<=50;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9230;
 end   
18'd70403: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=23;
   mapp<=87;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10387;
 end   
18'd70404: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=88;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=11129;
 end   
18'd70405: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=67;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=4592;
 end   
18'd70406: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=83;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=5594;
 end   
18'd70407: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=3482;
 end   
18'd70408: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=58;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=4024;
 end   
18'd70409: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=6;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=7497;
 end   
18'd70410: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=38;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd70411: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=63;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd70412: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd70413: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5691;
 end   
18'd70414: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=5691;
 end   
18'd70542: begin  
rid<=1;
end
18'd70543: begin  
end
18'd70544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd70545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd70546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd70547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd70548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd70549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd70550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd70551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd70552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd70553: begin  
rid<=0;
end
18'd70601: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=88;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26006;
 end   
18'd70602: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=19;
   mapp<=85;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=32472;
 end   
18'd70603: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=46;
   mapp<=23;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=27795;
 end   
18'd70604: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=90;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd70605: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=75;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd70606: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=69;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd70607: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=19;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd70608: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=41;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd70609: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd70610: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd70611: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd70612: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd70613: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70614: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70615: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70616: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70617: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70618: begin  
  clrr<=0;
  maplen<=10;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26006;
 end   
18'd70742: begin  
rid<=1;
end
18'd70743: begin  
end
18'd70744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd70745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd70746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd70747: begin  
rid<=0;
end
18'd70801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18386;
 end   
18'd70802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=32;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23451;
 end   
18'd70803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=75;
   mapp<=58;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=25060;
 end   
18'd70804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=36;
   mapp<=94;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=26438;
 end   
18'd70805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=38;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd70806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=58;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd70807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=80;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd70808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=85;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd70809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=13;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd70810: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=84;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd70811: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd70812: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd70813: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18386;
 end   
18'd70814: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18386;
 end   
18'd70815: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18386;
 end   
18'd70816: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18386;
 end   
18'd70817: begin  
  clrr<=0;
  maplen<=7;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18386;
 end   
18'd70942: begin  
rid<=1;
end
18'd70943: begin  
end
18'd70944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd70945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd70946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd70947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd70948: begin  
rid<=0;
end
18'd71001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=48;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14272;
 end   
18'd71002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=77;
   mapp<=26;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=13047;
 end   
18'd71003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=99;
   mapp<=70;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16621;
 end   
18'd71004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=35;
   mapp<=36;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16640;
 end   
18'd71005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd71006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd71007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd71008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd71009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd71010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd71011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd71142: begin  
rid<=1;
end
18'd71143: begin  
end
18'd71144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd71145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd71146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd71147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd71148: begin  
rid<=0;
end
18'd71201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=67;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21782;
 end   
18'd71202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=31;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=20038;
 end   
18'd71203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=28;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd71204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=16;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd71205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=34;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd71206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=99;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd71207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=57;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd71208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=40;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd71209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=81;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd71210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=23;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd71211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=41;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd71212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd71213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71218: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71219: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71220: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71221: begin  
  clrr<=0;
  maplen<=10;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21782;
 end   
18'd71342: begin  
rid<=1;
end
18'd71343: begin  
end
18'd71344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd71345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd71346: begin  
rid<=0;
end
18'd71401: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=63;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8961;
 end   
18'd71402: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=45;
   mapp<=99;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6790;
 end   
18'd71403: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=26;
   mapp<=75;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11150;
 end   
18'd71404: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=1;
   mapp<=99;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=17481;
 end   
18'd71405: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=24;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=19333;
 end   
18'd71406: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=83;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=17099;
 end   
18'd71407: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=89;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd71408: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=35;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd71409: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=24;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd71410: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd71411: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd71412: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd71413: begin  
  clrr<=0;
  maplen<=4;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=8961;
 end   
18'd71542: begin  
rid<=1;
end
18'd71543: begin  
end
18'd71544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd71545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd71546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd71547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd71548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd71549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd71550: begin  
rid<=0;
end
18'd71601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=68;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11301;
 end   
18'd71602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=70;
   mapp<=83;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10800;
 end   
18'd71603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=43;
   mapp<=17;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9852;
 end   
18'd71604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=92;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=10958;
 end   
18'd71605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=52;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=8395;
 end   
18'd71606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=24;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8512;
 end   
18'd71607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=73;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=10189;
 end   
18'd71608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd71609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd71610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd71611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd71612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd71742: begin  
rid<=1;
end
18'd71743: begin  
end
18'd71744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd71745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd71746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd71747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd71748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd71749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd71750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd71751: begin  
rid<=0;
end
18'd71801: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=28;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=19700;
 end   
18'd71802: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=90;
   mapp<=14;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=19664;
 end   
18'd71803: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=99;
   mapp<=80;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15702;
 end   
18'd71804: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=80;
   mapp<=58;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=10660;
 end   
18'd71805: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=70;
   mapp<=58;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=10186;
 end   
18'd71806: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=24;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9081;
 end   
18'd71807: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=8;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd71808: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd71809: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd71810: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=17;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd71811: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd71812: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd71813: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19700;
 end   
18'd71814: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19700;
 end   
18'd71815: begin  
  clrr<=0;
  maplen<=10;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=19700;
 end   
18'd71942: begin  
rid<=1;
end
18'd71943: begin  
end
18'd71944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd71945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd71946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd71947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd71948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd71949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd71950: begin  
rid<=0;
end
18'd72001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=36;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11124;
 end   
18'd72002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=66;
   mapp<=64;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14992;
 end   
18'd72003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=92;
   mapp<=75;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15808;
 end   
18'd72004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=84;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=9478;
 end   
18'd72005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=82;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4270;
 end   
18'd72006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=11;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=7098;
 end   
18'd72007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=6;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=8812;
 end   
18'd72008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=68;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=7814;
 end   
18'd72009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd72010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd72011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd72012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd72013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11124;
 end   
18'd72142: begin  
rid<=1;
end
18'd72143: begin  
end
18'd72144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd72145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd72146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd72147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd72148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd72149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd72150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd72151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd72152: begin  
rid<=0;
end
18'd72201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=10;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14981;
 end   
18'd72202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=57;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17030;
 end   
18'd72203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=66;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd72204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=50;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd72205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=70;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd72206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=45;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd72207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=25;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd72208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd72209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd72210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd72211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd72212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd72213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14981;
 end   
18'd72214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14981;
 end   
18'd72215: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14981;
 end   
18'd72342: begin  
rid<=1;
end
18'd72343: begin  
end
18'd72344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd72345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd72346: begin  
rid<=0;
end
18'd72401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=1;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=74;
 end   
18'd72402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=53;
 end   
18'd72403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=29;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=49;
 end   
18'd72404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=36;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=66;
 end   
18'd72405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=63;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=103;
 end   
18'd72406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=16;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=66;
 end   
18'd72407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=58;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=118;
 end   
18'd72408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=34;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=104;
 end   
18'd72409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd72542: begin  
rid<=1;
end
18'd72543: begin  
end
18'd72544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd72545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd72546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd72547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd72548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd72549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd72550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd72551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd72552: begin  
rid<=0;
end
18'd72601: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=24;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=14185;
 end   
18'd72602: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=74;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11558;
 end   
18'd72603: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=75;
   mapp<=82;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12083;
 end   
18'd72604: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=37;
   mapp<=39;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12393;
 end   
18'd72605: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=76;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd72606: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd72607: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=24;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd72608: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=64;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd72609: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd72610: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd72611: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd72612: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd72613: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=14185;
 end   
18'd72742: begin  
rid<=1;
end
18'd72743: begin  
end
18'd72744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd72745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd72746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd72747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd72748: begin  
rid<=0;
end
18'd72801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=29;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=725;
 end   
18'd72802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd72942: begin  
rid<=1;
end
18'd72943: begin  
end
18'd72944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd72945: begin  
rid<=0;
end
18'd73001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=90;
   mapp<=94;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8460;
 end   
18'd73002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=44;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=3970;
 end   
18'd73003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=6;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=560;
 end   
18'd73004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=75;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6780;
 end   
18'd73005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6430;
 end   
18'd73006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd73142: begin  
rid<=1;
end
18'd73143: begin  
end
18'd73144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd73145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd73146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd73147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd73148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd73149: begin  
rid<=0;
end
18'd73201: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=56;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8180;
 end   
18'd73202: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=20;
   mapp<=95;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6714;
 end   
18'd73203: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=32;
   mapp<=58;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4848;
 end   
18'd73204: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=7;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3690;
 end   
18'd73205: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=45;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5256;
 end   
18'd73206: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd73207: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd73208: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd73209: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd73210: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd73342: begin  
rid<=1;
end
18'd73343: begin  
end
18'd73344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd73345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd73346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd73347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd73348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd73349: begin  
rid<=0;
end
18'd73401: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=94;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=23565;
 end   
18'd73402: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=90;
   mapp<=53;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24759;
 end   
18'd73403: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=48;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd73404: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=54;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd73405: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=17;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd73406: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=92;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd73407: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=30;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd73408: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=18;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd73409: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=48;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd73410: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd73411: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd73412: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd73413: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73414: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73415: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73416: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73417: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73418: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73419: begin  
  clrr<=0;
  maplen<=10;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=23565;
 end   
18'd73542: begin  
rid<=1;
end
18'd73543: begin  
end
18'd73544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd73545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd73546: begin  
rid<=0;
end
18'd73601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=35;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2870;
 end   
18'd73602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1515;
 end   
18'd73603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=39;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1385;
 end   
18'd73604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=1;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=65;
 end   
18'd73605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=93;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=3295;
 end   
18'd73606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=27;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=995;
 end   
18'd73607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=69;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2475;
 end   
18'd73608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=93;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=3325;
 end   
18'd73609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=33;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=1235;
 end   
18'd73610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=31;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=1175;
 end   
18'd73611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=92;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=3320;
 end   
18'd73612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd73742: begin  
rid<=1;
end
18'd73743: begin  
end
18'd73744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd73745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd73746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd73747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd73748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd73749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd73750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd73751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd73752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd73753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd73754: begin  
check<=expctdoutput[10]-outcheck;
end
18'd73755: begin  
rid<=0;
end
18'd73801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=21;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2992;
 end   
18'd73802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=82;
   mapp<=16;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5348;
 end   
18'd73803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=61;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2695;
 end   
18'd73804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=17;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=961;
 end   
18'd73805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=7;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=1827;
 end   
18'd73806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=20;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=4160;
 end   
18'd73807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=45;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=6417;
 end   
18'd73808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd73809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd73810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd73942: begin  
rid<=1;
end
18'd73943: begin  
end
18'd73944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd73945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd73946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd73947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd73948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd73949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd73950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd73951: begin  
rid<=0;
end
18'd74001: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=81;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12061;
 end   
18'd74002: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=67;
   mapp<=70;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6685;
 end   
18'd74003: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=15;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=7600;
 end   
18'd74004: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=95;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=10606;
 end   
18'd74005: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=43;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=7744;
 end   
18'd74006: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=63;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=9910;
 end   
18'd74007: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=71;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=11975;
 end   
18'd74008: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=92;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=9867;
 end   
18'd74009: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=35;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=4054;
 end   
18'd74010: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=17;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=2271;
 end   
18'd74011: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd74012: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd74013: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12061;
 end   
18'd74142: begin  
rid<=1;
end
18'd74143: begin  
end
18'd74144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd74145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd74146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd74147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd74148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd74149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd74150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd74151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd74152: begin  
check<=expctdoutput[8]-outcheck;
end
18'd74153: begin  
check<=expctdoutput[9]-outcheck;
end
18'd74154: begin  
rid<=0;
end
18'd74201: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=29;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1310;
 end   
18'd74202: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=24;
   mapp<=28;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1542;
 end   
18'd74203: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd74204: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd74205: begin  
  clrr<=0;
  maplen<=3;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd74342: begin  
rid<=1;
end
18'd74343: begin  
end
18'd74344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd74345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd74346: begin  
rid<=0;
end
18'd74401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=94;
   mapp<=51;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4794;
 end   
18'd74402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=41;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2101;
 end   
18'd74403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=64;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3284;
 end   
18'd74404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=83;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4263;
 end   
18'd74405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=20;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1060;
 end   
18'd74406: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=44;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2294;
 end   
18'd74407: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=88;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=4548;
 end   
18'd74408: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=77;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=3997;
 end   
18'd74409: begin  
  clrr<=0;
  maplen<=1;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd74542: begin  
rid<=1;
end
18'd74543: begin  
end
18'd74544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd74545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd74546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd74547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd74548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd74549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd74550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd74551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd74552: begin  
rid<=0;
end
18'd74601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=95;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=21846;
 end   
18'd74602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=1;
   mapp<=2;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16087;
 end   
18'd74603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=5;
   mapp<=53;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13738;
 end   
18'd74604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=58;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd74605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=23;
   mapp<=58;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd74606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=87;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd74607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=41;
   mapp<=90;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd74608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=26;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd74609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=30;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd74610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=9;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd74611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=20;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd74612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd74613: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74614: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74615: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74616: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74617: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74618: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74619: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74620: begin  
  clrr<=0;
  maplen<=9;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=21846;
 end   
18'd74742: begin  
rid<=1;
end
18'd74743: begin  
end
18'd74744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd74745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd74746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd74747: begin  
rid<=0;
end
18'd74801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=74;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2294;
 end   
18'd74802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=2;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=72;
 end   
18'd74803: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=20;
 end   
18'd74804: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=71;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2231;
 end   
18'd74805: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd74942: begin  
rid<=1;
end
18'd74943: begin  
end
18'd74944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd74945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd74946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd74947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd74948: begin  
rid<=0;
end
18'd75001: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=88;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13450;
 end   
18'd75002: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=55;
   mapp<=94;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18231;
 end   
18'd75003: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=60;
   mapp<=22;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=13475;
 end   
18'd75004: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=45;
   mapp<=36;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=16074;
 end   
18'd75005: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=23;
   mapp<=90;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=17607;
 end   
18'd75006: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=42;
   mapp<=15;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd75007: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd75008: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd75009: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd75010: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd75011: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd75012: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd75013: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13450;
 end   
18'd75014: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13450;
 end   
18'd75015: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13450;
 end   
18'd75016: begin  
  clrr<=0;
  maplen<=10;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13450;
 end   
18'd75142: begin  
rid<=1;
end
18'd75143: begin  
end
18'd75144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd75145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd75146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd75147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd75148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd75149: begin  
rid<=0;
end
18'd75201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=79;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=24360;
 end   
18'd75202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=7;
   mapp<=47;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23872;
 end   
18'd75203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=13;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd75204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=60;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd75205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=47;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd75206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=46;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd75207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=71;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd75208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd75209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd75210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd75211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd75212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd75213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24360;
 end   
18'd75214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24360;
 end   
18'd75215: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=24360;
 end   
18'd75342: begin  
rid<=1;
end
18'd75343: begin  
end
18'd75344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd75345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd75346: begin  
rid<=0;
end
18'd75401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=51;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7866;
 end   
18'd75402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=90;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7765;
 end   
18'd75403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=39;
   mapp<=36;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=8537;
 end   
18'd75404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=53;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=10575;
 end   
18'd75405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=49;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=11356;
 end   
18'd75406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=88;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=7583;
 end   
18'd75407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd75408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd75409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd75410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd75411: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd75542: begin  
rid<=1;
end
18'd75543: begin  
end
18'd75544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd75545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd75546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd75547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd75548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd75549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd75550: begin  
rid<=0;
end
18'd75601: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=3;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12425;
 end   
18'd75602: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=81;
   mapp<=24;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15913;
 end   
18'd75603: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=77;
   mapp<=78;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16689;
 end   
18'd75604: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=50;
   mapp<=85;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=18382;
 end   
18'd75605: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=48;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=14012;
 end   
18'd75606: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=70;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd75607: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=94;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd75608: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=16;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd75609: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd75610: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd75611: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd75612: begin  
  clrr<=0;
  maplen<=4;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd75742: begin  
rid<=1;
end
18'd75743: begin  
end
18'd75744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd75745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd75746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd75747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd75748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd75749: begin  
rid<=0;
end
18'd75801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=52;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4418;
 end   
18'd75802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=62;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7505;
 end   
18'd75803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=21;
   mapp<=72;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3839;
 end   
18'd75804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd75805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=28;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd75806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd75807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd75808: begin  
  clrr<=0;
  maplen<=3;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd75942: begin  
rid<=1;
end
18'd75943: begin  
end
18'd75944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd75945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd75946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd75947: begin  
rid<=0;
end
18'd76001: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=35;
   mapp<=59;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15586;
 end   
18'd76002: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=40;
   mapp<=82;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18358;
 end   
18'd76003: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=66;
   mapp<=89;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16052;
 end   
18'd76004: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=32;
   mapp<=86;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12263;
 end   
18'd76005: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=85;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd76006: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=22;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd76007: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=3;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd76008: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=61;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd76009: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd76010: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd76011: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd76012: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd76013: begin  
  clrr<=0;
  maplen<=5;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15586;
 end   
18'd76142: begin  
rid<=1;
end
18'd76143: begin  
end
18'd76144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd76145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd76146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd76147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd76148: begin  
rid<=0;
end
18'd76201: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=65;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9610;
 end   
18'd76202: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=45;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd76203: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=20;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd76204: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=10;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd76205: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=28;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd76206: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=70;
   mapp<=13;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd76207: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd76208: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd76209: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd76210: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd76211: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd76212: begin  
  clrr<=0;
  maplen<=6;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd76342: begin  
rid<=1;
end
18'd76343: begin  
end
18'd76344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd76345: begin  
rid<=0;
end
18'd76401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=61;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26180;
 end   
18'd76402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=95;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd76403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=51;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd76404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=66;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd76405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=83;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd76406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=10;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd76407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=58;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd76408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=72;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd76409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=95;
   mapp<=44;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd76410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=6;
   mapp<=30;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd76411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=14;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd76412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd76413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76417: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76418: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76419: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76420: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76421: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76422: begin  
  clrr<=0;
  maplen<=11;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26180;
 end   
18'd76542: begin  
rid<=1;
end
18'd76543: begin  
end
18'd76544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd76545: begin  
rid<=0;
end
18'd76601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=87;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=435;
 end   
18'd76602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1054;
 end   
18'd76603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=21;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=1847;
 end   
18'd76604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=41;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=3597;
 end   
18'd76605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=75;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6565;
 end   
18'd76606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=90;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=7880;
 end   
18'd76607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=25;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2235;
 end   
18'd76608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=11;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1027;
 end   
18'd76609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=67;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=5909;
 end   
18'd76610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=82;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=7224;
 end   
18'd76611: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=83;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=7321;
 end   
18'd76612: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd76742: begin  
rid<=1;
end
18'd76743: begin  
end
18'd76744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd76745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd76746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd76747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd76748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd76749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd76750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd76751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd76752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd76753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd76754: begin  
check<=expctdoutput[10]-outcheck;
end
18'd76755: begin  
rid<=0;
end
18'd76801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=5;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=395;
 end   
18'd76802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=350;
 end   
18'd76803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=74;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=390;
 end   
18'd76804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=84;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=450;
 end   
18'd76805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=29;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=185;
 end   
18'd76806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=35;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=225;
 end   
18'd76807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=60;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=360;
 end   
18'd76808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd76942: begin  
rid<=1;
end
18'd76943: begin  
end
18'd76944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd76945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd76946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd76947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd76948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd76949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd76950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd76951: begin  
rid<=0;
end
18'd77001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=23;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=552;
 end   
18'd77002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=50;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=1160;
 end   
18'd77003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=16;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=388;
 end   
18'd77004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=60;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=1410;
 end   
18'd77005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=1;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=63;
 end   
18'd77006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=59;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=1407;
 end   
18'd77007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=9;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=267;
 end   
18'd77008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd77142: begin  
rid<=1;
end
18'd77143: begin  
end
18'd77144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd77145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd77146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd77147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd77148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd77149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd77150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd77151: begin  
rid<=0;
end
18'd77201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=40;
   mapp<=25;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3688;
 end   
18'd77202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=48;
   mapp<=56;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4290;
 end   
18'd77203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=55;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1787;
 end   
18'd77204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=7;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2949;
 end   
18'd77205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=49;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6361;
 end   
18'd77206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=91;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=5685;
 end   
18'd77207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=60;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6152;
 end   
18'd77208: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=82;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd77209: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd77210: begin  
  clrr<=0;
  maplen<=2;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd77342: begin  
rid<=1;
end
18'd77343: begin  
end
18'd77344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd77345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd77346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd77347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd77348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd77349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd77350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd77351: begin  
rid<=0;
end
18'd77401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=7;
   mapp<=70;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2490;
 end   
18'd77402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=25;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1207;
 end   
18'd77403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=1;
   mapp<=25;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=679;
 end   
18'd77404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=19;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=389;
 end   
18'd77405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=9;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=159;
 end   
18'd77406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=1;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=856;
 end   
18'd77407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=31;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd77408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=24;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd77409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd77410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd77411: begin  
  clrr<=0;
  maplen<=8;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd77542: begin  
rid<=1;
end
18'd77543: begin  
end
18'd77544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd77545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd77546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd77547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd77548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd77549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd77550: begin  
rid<=0;
end
18'd77601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=64;
   mapp<=88;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5632;
 end   
18'd77602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=63;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5554;
 end   
18'd77603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=24;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2132;
 end   
18'd77604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=34;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3022;
 end   
18'd77605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=70;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6200;
 end   
18'd77606: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=51;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=4538;
 end   
18'd77607: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=97;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=8596;
 end   
18'd77608: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=24;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2182;
 end   
18'd77609: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=11;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1048;
 end   
18'd77610: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=67;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=5986;
 end   
18'd77611: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd77742: begin  
rid<=1;
end
18'd77743: begin  
end
18'd77744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd77745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd77746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd77747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd77748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd77749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd77750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd77751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd77752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd77753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd77754: begin  
rid<=0;
end
18'd77801: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=27;
   mapp<=79;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11735;
 end   
18'd77802: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=60;
   mapp<=55;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=12536;
 end   
18'd77803: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=39;
   mapp<=28;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12231;
 end   
18'd77804: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=66;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd77805: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=37;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd77806: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=48;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd77807: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=48;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd77808: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd77809: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd77810: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd77811: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd77812: begin  
  clrr<=0;
  maplen<=5;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd77942: begin  
rid<=1;
end
18'd77943: begin  
end
18'd77944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd77945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd77946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd77947: begin  
rid<=0;
end
18'd78001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=62;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=18342;
 end   
18'd78002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=54;
   mapp<=21;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17421;
 end   
18'd78003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=76;
   mapp<=33;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17361;
 end   
18'd78004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=54;
   mapp<=75;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd78005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=58;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd78006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=21;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd78007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=84;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd78008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd78009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=66;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd78010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd78011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd78012: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd78013: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18342;
 end   
18'd78014: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18342;
 end   
18'd78015: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18342;
 end   
18'd78016: begin  
  clrr<=0;
  maplen<=7;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=18342;
 end   
18'd78142: begin  
rid<=1;
end
18'd78143: begin  
end
18'd78144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd78145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd78146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd78147: begin  
rid<=0;
end
18'd78201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=37;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3801;
 end   
18'd78202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=29;
   mapp<=29;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd78203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd78204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd78342: begin  
rid<=1;
end
18'd78343: begin  
end
18'd78344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd78345: begin  
rid<=0;
end
18'd78401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=66;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=28295;
 end   
18'd78402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=72;
   mapp<=1;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=29034;
 end   
18'd78403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=93;
   mapp<=84;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd78404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=58;
   mapp<=20;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd78405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=79;
   mapp<=87;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd78406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=83;
   mapp<=36;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd78407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=87;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd78408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=23;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd78409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=97;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd78410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=96;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd78411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd78412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd78413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78416: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78417: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78418: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78419: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=28295;
 end   
18'd78542: begin  
rid<=1;
end
18'd78543: begin  
end
18'd78544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd78545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd78546: begin  
rid<=0;
end
18'd78601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=24;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2103;
 end   
18'd78602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=33;
   mapp<=20;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4693;
 end   
18'd78603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=57;
   mapp<=3;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=3608;
 end   
18'd78604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=72;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4242;
 end   
18'd78605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=20;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4597;
 end   
18'd78606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd78607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=53;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd78608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd78609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd78610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd78742: begin  
rid<=1;
end
18'd78743: begin  
end
18'd78744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd78745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd78746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd78747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd78748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd78749: begin  
rid<=0;
end
18'd78801: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=66;
   mapp<=80;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11310;
 end   
18'd78802: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=90;
   mapp<=67;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11766;
 end   
18'd78803: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=68;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7202;
 end   
18'd78804: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=26;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3986;
 end   
18'd78805: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=28;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd78806: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd78807: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd78942: begin  
rid<=1;
end
18'd78943: begin  
end
18'd78944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd78945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd78946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd78947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd78948: begin  
rid<=0;
end
18'd79001: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=27;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13244;
 end   
18'd79002: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=82;
   mapp<=49;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14266;
 end   
18'd79003: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=93;
   mapp<=33;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12991;
 end   
18'd79004: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=87;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd79005: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=63;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd79006: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=61;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd79007: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=65;
   mapp<=27;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd79008: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=99;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd79009: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=51;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd79010: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd79011: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd79012: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd79013: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79014: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79015: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79016: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79017: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79018: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13244;
 end   
18'd79142: begin  
rid<=1;
end
18'd79143: begin  
end
18'd79144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd79145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd79146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd79147: begin  
rid<=0;
end
18'd79201: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=64;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7872;
 end   
18'd79202: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=57;
   mapp<=58;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6871;
 end   
18'd79203: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=72;
   mapp<=38;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6658;
 end   
18'd79204: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=21;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd79205: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=22;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd79206: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=56;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd79207: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd79208: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd79209: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd79210: begin  
  clrr<=0;
  maplen<=4;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd79342: begin  
rid<=1;
end
18'd79343: begin  
end
18'd79344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd79345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd79346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd79347: begin  
rid<=0;
end
18'd79401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=81;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26859;
 end   
18'd79402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=51;
   mapp<=43;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21058;
 end   
18'd79403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=60;
   mapp<=34;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=24986;
 end   
18'd79404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=98;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd79405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=71;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd79406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=42;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd79407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=94;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd79408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=84;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd79409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=35;
   mapp<=11;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd79410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd79411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd79412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd79413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79415: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79416: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79417: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79418: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79419: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79420: begin  
  clrr<=0;
  maplen<=11;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26859;
 end   
18'd79542: begin  
rid<=1;
end
18'd79543: begin  
end
18'd79544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd79545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd79546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd79547: begin  
rid<=0;
end
18'd79601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=23;
   mapp<=55;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1265;
 end   
18'd79602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2760;
 end   
18'd79603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=88;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=4860;
 end   
18'd79604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=39;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=2175;
 end   
18'd79605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=10;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=590;
 end   
18'd79606: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=17;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=985;
 end   
18'd79607: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=32;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=1820;
 end   
18'd79608: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=48;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2710;
 end   
18'd79609: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=10;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=630;
 end   
18'd79610: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=95;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=5315;
 end   
18'd79611: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=19;
   mapp<=0;
   pp<=100;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[10]<=1145;
 end   
18'd79612: begin  
  clrr<=0;
  maplen<=1;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd79742: begin  
rid<=1;
end
18'd79743: begin  
end
18'd79744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd79745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd79746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd79747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd79748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd79749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd79750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd79751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd79752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd79753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd79754: begin  
check<=expctdoutput[10]-outcheck;
end
18'd79755: begin  
rid<=0;
end
18'd79801: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=34;
   mapp<=71;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=16436;
 end   
18'd79802: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=84;
   mapp<=51;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=17095;
 end   
18'd79803: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=77;
   mapp<=95;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=17033;
 end   
18'd79804: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=12;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd79805: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=41;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd79806: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=4;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd79807: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=96;
   mapp<=0;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd79808: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=62;
   mapp<=7;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd79809: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=37;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd79810: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=51;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd79811: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd79812: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd79813: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79814: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79815: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79816: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79817: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79818: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=16436;
 end   
18'd79942: begin  
rid<=1;
end
18'd79943: begin  
end
18'd79944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd79945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd79946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd79947: begin  
rid<=0;
end
18'd80001: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=45;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3989;
 end   
18'd80002: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=28;
   mapp<=38;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5402;
 end   
18'd80003: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=94;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7118;
 end   
18'd80004: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=26;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=4684;
 end   
18'd80005: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=78;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd80006: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd80007: begin  
  clrr<=0;
  maplen<=2;
  fillen<=5;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd80142: begin  
rid<=1;
end
18'd80143: begin  
end
18'd80144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd80145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd80146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd80147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd80148: begin  
rid<=0;
end
18'd80201: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=99;
   mapp<=5;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7793;
 end   
18'd80202: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=27;
   mapp<=49;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=8856;
 end   
18'd80203: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=92;
   mapp<=57;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=9063;
 end   
18'd80204: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=53;
   mapp<=12;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=8197;
 end   
18'd80205: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=95;
   mapp<=1;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=7056;
 end   
18'd80206: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=42;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7303;
 end   
18'd80207: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=67;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd80208: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=49;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd80209: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=76;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd80210: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=55;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd80211: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd80212: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd80213: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7793;
 end   
18'd80214: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7793;
 end   
18'd80215: begin  
  clrr<=0;
  maplen<=5;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7793;
 end   
18'd80342: begin  
rid<=1;
end
18'd80343: begin  
end
18'd80344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd80345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd80346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd80347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd80348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd80349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd80350: begin  
rid<=0;
end
18'd80401: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=47;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1236;
 end   
18'd80402: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=73;
   mapp<=15;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=1204;
 end   
18'd80403: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=65;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=950;
 end   
18'd80404: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=49;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=732;
 end   
18'd80405: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=37;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1186;
 end   
18'd80406: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=69;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=722;
 end   
18'd80407: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=31;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd80408: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd80409: begin  
  clrr<=0;
  maplen<=2;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd80542: begin  
rid<=1;
end
18'd80543: begin  
end
18'd80544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd80545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd80546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd80547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd80548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd80549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd80550: begin  
rid<=0;
end
18'd80601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=29;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=25639;
 end   
18'd80602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=31;
   mapp<=52;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=25677;
 end   
18'd80603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=78;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd80604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=59;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd80605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=52;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd80606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=89;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd80607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd80608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd80609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd80610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd80611: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd80612: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd80613: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=25639;
 end   
18'd80742: begin  
rid<=1;
end
18'd80743: begin  
end
18'd80744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd80745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd80746: begin  
rid<=0;
end
18'd80801: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=71;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=7858;
 end   
18'd80802: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=47;
   mapp<=72;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6996;
 end   
18'd80803: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=3;
   mapp<=8;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2630;
 end   
18'd80804: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=11;
   mapp<=56;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6496;
 end   
18'd80805: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=74;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=5740;
 end   
18'd80806: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=19;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7164;
 end   
18'd80807: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=7;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6518;
 end   
18'd80808: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=5;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd80809: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=99;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd80810: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=88;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd80811: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd80812: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd80813: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7858;
 end   
18'd80814: begin  
  clrr<=0;
  maplen<=4;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=7858;
 end   
18'd80942: begin  
rid<=1;
end
18'd80943: begin  
end
18'd80944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd80945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd80946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd80947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd80948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd80949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd80950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd80951: begin  
rid<=0;
end
18'd81001: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=99;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=12514;
 end   
18'd81002: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=54;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=18727;
 end   
18'd81003: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=67;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd81004: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=12;
   mapp<=76;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd81005: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=14;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd81006: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=29;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd81007: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=67;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd81008: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd81009: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd81010: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd81011: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd81012: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd81013: begin  
  clrr<=0;
  maplen<=7;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=12514;
 end   
18'd81142: begin  
rid<=1;
end
18'd81143: begin  
end
18'd81144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd81145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd81146: begin  
rid<=0;
end
18'd81201: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=74;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=30473;
 end   
18'd81202: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=36;
   mapp<=12;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=24922;
 end   
18'd81203: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=12;
   mapp<=31;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=15240;
 end   
18'd81204: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=87;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd81205: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=57;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd81206: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=3;
   mapp<=47;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd81207: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=91;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd81208: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=82;
   mapp<=89;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd81209: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=29;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd81210: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=27;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd81211: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd81212: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd81213: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81214: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81215: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81216: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81217: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81218: begin  
  clrr<=0;
  maplen<=8;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30473;
 end   
18'd81342: begin  
rid<=1;
end
18'd81343: begin  
end
18'd81344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd81345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd81346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd81347: begin  
rid<=0;
end
18'd81401: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=76;
   mapp<=96;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=26690;
 end   
18'd81402: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=24;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=21220;
 end   
18'd81403: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=81;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd81404: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=95;
   mapp<=97;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd81405: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=23;
   mapp<=54;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd81406: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=32;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd81407: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=43;
   mapp<=2;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd81408: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=45;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd81409: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd81410: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd81411: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd81412: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd81413: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26690;
 end   
18'd81414: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26690;
 end   
18'd81415: begin  
  clrr<=0;
  maplen<=8;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=26690;
 end   
18'd81542: begin  
rid<=1;
end
18'd81543: begin  
end
18'd81544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd81545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd81546: begin  
rid<=0;
end
18'd81601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=50;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8613;
 end   
18'd81602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=32;
   mapp<=89;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10099;
 end   
18'd81603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=45;
   mapp<=37;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6613;
 end   
18'd81604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=9655;
 end   
18'd81605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=35;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=6748;
 end   
18'd81606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=79;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=8068;
 end   
18'd81607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=54;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=8879;
 end   
18'd81608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd81609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd81610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd81611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd81612: begin  
  clrr<=0;
  maplen<=9;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd81742: begin  
rid<=1;
end
18'd81743: begin  
end
18'd81744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd81745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd81746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd81747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd81748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd81749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd81750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd81751: begin  
rid<=0;
end
18'd81801: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=77;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4299;
 end   
18'd81802: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=5;
   mapp<=90;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2165;
 end   
18'd81803: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=19;
   mapp<=4;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd81804: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd81805: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd81806: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd81807: begin  
  clrr<=0;
  maplen<=3;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd81942: begin  
rid<=1;
end
18'd81943: begin  
end
18'd81944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd81945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd81946: begin  
rid<=0;
end
18'd82001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=84;
   mapp<=22;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15194;
 end   
18'd82002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=51;
   mapp<=68;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11099;
 end   
18'd82003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=84;
   mapp<=85;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=12245;
 end   
18'd82004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=37;
   mapp<=74;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=15423;
 end   
18'd82005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=15;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=18783;
 end   
18'd82006: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=89;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=18172;
 end   
18'd82007: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=81;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=15589;
 end   
18'd82008: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=74;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=13364;
 end   
18'd82009: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=59;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd82010: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=50;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd82011: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=46;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd82012: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd82013: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15194;
 end   
18'd82014: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15194;
 end   
18'd82015: begin  
  clrr<=0;
  maplen<=4;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=15194;
 end   
18'd82142: begin  
rid<=1;
end
18'd82143: begin  
end
18'd82144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd82145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd82146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd82147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd82148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd82149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd82150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd82151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd82152: begin  
rid<=0;
end
18'd82201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=21;
   mapp<=33;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=693;
 end   
18'd82202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=61;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2023;
 end   
18'd82203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=18;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=614;
 end   
18'd82204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=46;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1548;
 end   
18'd82205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd82342: begin  
rid<=1;
end
18'd82343: begin  
end
18'd82344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd82345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd82346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd82347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd82348: begin  
rid<=0;
end
18'd82401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=60;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3660;
 end   
18'd82402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=46;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=2770;
 end   
18'd82403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=58;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=3500;
 end   
18'd82404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=94;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5670;
 end   
18'd82405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=71;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=4300;
 end   
18'd82406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=45;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2750;
 end   
18'd82407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=2;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=180;
 end   
18'd82408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=46;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=2830;
 end   
18'd82409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=20;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=1280;
 end   
18'd82410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=54;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=3330;
 end   
18'd82411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=53;
   pp<=100;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[10]<=3280;
 end   
18'd82412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd82542: begin  
rid<=1;
end
18'd82543: begin  
end
18'd82544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd82545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd82546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd82547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd82548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd82549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd82550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd82551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd82552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd82553: begin  
check<=expctdoutput[9]-outcheck;
end
18'd82554: begin  
check<=expctdoutput[10]-outcheck;
end
18'd82555: begin  
rid<=0;
end
18'd82601: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=16;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=560;
 end   
18'd82602: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=13;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=465;
 end   
18'd82603: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=35;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1245;
 end   
18'd82604: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=92;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3250;
 end   
18'd82605: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=670;
 end   
18'd82606: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=65;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=2325;
 end   
18'd82607: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=70;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=2510;
 end   
18'd82608: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=36;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=1330;
 end   
18'd82609: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=25;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=955;
 end   
18'd82610: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=46;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=1700;
 end   
18'd82611: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd82742: begin  
rid<=1;
end
18'd82743: begin  
end
18'd82744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd82745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd82746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd82747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd82748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd82749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd82750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd82751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd82752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd82753: begin  
check<=expctdoutput[9]-outcheck;
end
18'd82754: begin  
rid<=0;
end
18'd82801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=15;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=1230;
 end   
18'd82802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=5;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=420;
 end   
18'd82803: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=26;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=2152;
 end   
18'd82804: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=1;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=112;
 end   
18'd82805: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=73;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=6026;
 end   
18'd82806: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=6;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=542;
 end   
18'd82807: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=80;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=6620;
 end   
18'd82808: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=93;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=7696;
 end   
18'd82809: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=90;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=7460;
 end   
18'd82810: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=91;
   mapp<=0;
   pp<=90;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[9]<=7552;
 end   
18'd82811: begin  
  clrr<=0;
  maplen<=1;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd82942: begin  
rid<=1;
end
18'd82943: begin  
end
18'd82944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd82945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd82946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd82947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd82948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd82949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd82950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd82951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd82952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd82953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd82954: begin  
rid<=0;
end
18'd83001: begin  
  clrr<=0;
  maplen<=4;
  fillen<=1;
   filterp<=85;
   mapp<=57;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4845;
 end   
18'd83002: begin  
  clrr<=0;
  maplen<=4;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=10;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[1]<=10;
 end   
18'd83003: begin  
  clrr<=0;
  maplen<=4;
  fillen<=1;
   filterp<=0;
   mapp<=49;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=4185;
 end   
18'd83004: begin  
  clrr<=0;
  maplen<=4;
  fillen<=1;
   filterp<=0;
   mapp<=22;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=1900;
 end   
18'd83005: begin  
  clrr<=0;
  maplen<=4;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd83142: begin  
rid<=1;
end
18'd83143: begin  
end
18'd83144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd83145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd83146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd83147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd83148: begin  
rid<=0;
end
18'd83201: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=92;
   mapp<=68;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=22206;
 end   
18'd83202: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=74;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=23572;
 end   
18'd83203: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=43;
   mapp<=52;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd83204: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=19;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd83205: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=81;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd83206: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=70;
   mapp<=38;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd83207: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=91;
   mapp<=62;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd83208: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=45;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd83209: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd83210: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd83211: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd83212: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd83213: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22206;
 end   
18'd83214: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22206;
 end   
18'd83215: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22206;
 end   
18'd83216: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22206;
 end   
18'd83217: begin  
  clrr<=0;
  maplen<=9;
  fillen<=8;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=22206;
 end   
18'd83342: begin  
rid<=1;
end
18'd83343: begin  
end
18'd83344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd83345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd83346: begin  
rid<=0;
end
18'd83401: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=16;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=30319;
 end   
18'd83402: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=8;
   mapp<=79;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=32082;
 end   
18'd83403: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=88;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[2]<=20;
 end   
18'd83404: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=99;
   mapp<=82;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd83405: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=25;
   mapp<=86;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd83406: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=96;
   mapp<=19;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd83407: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=69;
   mapp<=50;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd83408: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=31;
   mapp<=93;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd83409: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=14;
   mapp<=85;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd83410: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=2;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd83411: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd83412: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd83413: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83414: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83415: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83416: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83417: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83418: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83419: begin  
  clrr<=0;
  maplen<=9;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=30319;
 end   
18'd83542: begin  
rid<=1;
end
18'd83543: begin  
end
18'd83544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd83545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd83546: begin  
rid<=0;
end
18'd83601: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=67;
   mapp<=98;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11340;
 end   
18'd83602: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=62;
   mapp<=77;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=11245;
 end   
18'd83603: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=98;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=9748;
 end   
18'd83604: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=51;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=8903;
 end   
18'd83605: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=88;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=9842;
 end   
18'd83606: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=63;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=7557;
 end   
18'd83607: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=53;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=3921;
 end   
18'd83608: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=5;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=2947;
 end   
18'd83609: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=41;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd83610: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd83611: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd83742: begin  
rid<=1;
end
18'd83743: begin  
end
18'd83744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd83745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd83746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd83747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd83748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd83749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd83750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd83751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd83752: begin  
rid<=0;
end
18'd83801: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=18;
   mapp<=95;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=2340;
 end   
18'd83802: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=35;
   mapp<=18;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=2854;
 end   
18'd83803: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=72;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=4606;
 end   
18'd83804: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=94;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=4172;
 end   
18'd83805: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=70;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2630;
 end   
18'd83806: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=38;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=1469;
 end   
18'd83807: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=21;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2013;
 end   
18'd83808: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=45;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=1685;
 end   
18'd83809: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=23;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=1999;
 end   
18'd83810: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=43;
   pp<=90;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[9]<=3139;
 end   
18'd83811: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=65;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd83812: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd83813: begin  
  clrr<=0;
  maplen<=11;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=2340;
 end   
18'd83942: begin  
rid<=1;
end
18'd83943: begin  
end
18'd83944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd83945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd83946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd83947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd83948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd83949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd83950: begin  
check<=expctdoutput[6]-outcheck;
end
18'd83951: begin  
check<=expctdoutput[7]-outcheck;
end
18'd83952: begin  
check<=expctdoutput[8]-outcheck;
end
18'd83953: begin  
check<=expctdoutput[9]-outcheck;
end
18'd83954: begin  
rid<=0;
end
18'd84001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=18;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=8682;
 end   
18'd84002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=75;
   mapp<=92;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=5716;
 end   
18'd84003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=54;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=2792;
 end   
18'd84004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=24;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=2787;
 end   
18'd84005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=31;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5548;
 end   
18'd84006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=66;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=3413;
 end   
18'd84007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=29;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=2232;
 end   
18'd84008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=22;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=4666;
 end   
18'd84009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=56;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd84010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd84011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd84142: begin  
rid<=1;
end
18'd84143: begin  
end
18'd84144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd84145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd84146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd84147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd84148: begin  
check<=expctdoutput[4]-outcheck;
end
18'd84149: begin  
check<=expctdoutput[5]-outcheck;
end
18'd84150: begin  
check<=expctdoutput[6]-outcheck;
end
18'd84151: begin  
check<=expctdoutput[7]-outcheck;
end
18'd84152: begin  
rid<=0;
end
18'd84201: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=38;
   mapp<=61;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=11068;
 end   
18'd84202: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=75;
   mapp<=32;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=10988;
 end   
18'd84203: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=44;
   mapp<=28;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=11957;
 end   
18'd84204: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=25;
   mapp<=22;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=15169;
 end   
18'd84205: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=39;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd84206: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=21;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd84207: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=40;
   mapp<=26;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd84208: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=48;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd84209: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=78;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd84210: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd84211: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd84212: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd84213: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11068;
 end   
18'd84214: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11068;
 end   
18'd84215: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11068;
 end   
18'd84216: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11068;
 end   
18'd84217: begin  
  clrr<=0;
  maplen<=10;
  fillen<=7;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=11068;
 end   
18'd84342: begin  
rid<=1;
end
18'd84343: begin  
end
18'd84344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd84345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd84346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd84347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd84348: begin  
rid<=0;
end
18'd84401: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=76;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9157;
 end   
18'd84402: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=40;
   mapp<=48;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6711;
 end   
18'd84403: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=23;
   mapp<=47;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=5793;
 end   
18'd84404: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=51;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=5359;
 end   
18'd84405: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=7;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=2842;
 end   
18'd84406: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=51;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=5637;
 end   
18'd84407: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=10;
   pp<=60;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[6]<=4871;
 end   
18'd84408: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=57;
   pp<=70;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[7]<=7689;
 end   
18'd84409: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=77;
   pp<=80;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[8]<=6361;
 end   
18'd84410: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=9;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd84411: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=3;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd84412: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd84413: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9157;
 end   
18'd84414: begin  
  clrr<=0;
  maplen<=11;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9157;
 end   
18'd84542: begin  
rid<=1;
end
18'd84543: begin  
end
18'd84544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd84545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd84546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd84547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd84548: begin  
check<=expctdoutput[4]-outcheck;
end
18'd84549: begin  
check<=expctdoutput[5]-outcheck;
end
18'd84550: begin  
check<=expctdoutput[6]-outcheck;
end
18'd84551: begin  
check<=expctdoutput[7]-outcheck;
end
18'd84552: begin  
check<=expctdoutput[8]-outcheck;
end
18'd84553: begin  
rid<=0;
end
18'd84601: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=99;
   mapp<=69;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=9669;
 end   
18'd84602: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=48;
   mapp<=6;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=9707;
 end   
18'd84603: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=30;
   mapp<=85;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=7458;
 end   
18'd84604: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=73;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6775;
 end   
18'd84605: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=58;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=11278;
 end   
18'd84606: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=16;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=7863;
 end   
18'd84607: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=84;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=8929;
 end   
18'd84608: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=73;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=5633;
 end   
18'd84609: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=31;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=9298;
 end   
18'd84610: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=4;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd84611: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=83;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd84612: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd84613: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9669;
 end   
18'd84614: begin  
  clrr<=0;
  maplen<=3;
  fillen<=11;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=9669;
 end   
18'd84742: begin  
rid<=1;
end
18'd84743: begin  
end
18'd84744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd84745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd84746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd84747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd84748: begin  
check<=expctdoutput[4]-outcheck;
end
18'd84749: begin  
check<=expctdoutput[5]-outcheck;
end
18'd84750: begin  
check<=expctdoutput[6]-outcheck;
end
18'd84751: begin  
check<=expctdoutput[7]-outcheck;
end
18'd84752: begin  
check<=expctdoutput[8]-outcheck;
end
18'd84753: begin  
rid<=0;
end
18'd84801: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=9;
   mapp<=10;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5049;
 end   
18'd84802: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=57;
   mapp<=87;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4441;
 end   
18'd84803: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=64;
   pp<=20;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[2]<=4472;
 end   
18'd84804: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=68;
   pp<=30;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[3]<=6000;
 end   
18'd84805: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=94;
   pp<=40;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[4]<=5389;
 end   
18'd84806: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=79;
   pp<=50;
   gm<=1;
   gf<=0;
   gp<=1;
 expctdoutput[5]<=2072;
 end   
18'd84807: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=23;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd84808: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd84809: begin  
  clrr<=0;
  maplen<=7;
  fillen<=2;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd84942: begin  
rid<=1;
end
18'd84943: begin  
end
18'd84944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd84945: begin  
check<=expctdoutput[1]-outcheck;
end
18'd84946: begin  
check<=expctdoutput[2]-outcheck;
end
18'd84947: begin  
check<=expctdoutput[3]-outcheck;
end
18'd84948: begin  
check<=expctdoutput[4]-outcheck;
end
18'd84949: begin  
check<=expctdoutput[5]-outcheck;
end
18'd84950: begin  
rid<=0;
end
18'd85001: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=17;
   mapp<=77;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6488;
 end   
18'd85002: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=9;
   mapp<=23;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=4598;
 end   
18'd85003: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=43;
   mapp<=72;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6284;
 end   
18'd85004: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=67;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd85005: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd85006: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=49;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd85007: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd85008: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd85009: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd85010: begin  
  clrr<=0;
  maplen<=6;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd85142: begin  
rid<=1;
end
18'd85143: begin  
end
18'd85144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd85145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd85146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd85147: begin  
rid<=0;
end
18'd85201: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=69;
   mapp<=91;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=6279;
 end   
18'd85202: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=38;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3468;
 end   
18'd85203: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=4;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=384;
 end   
18'd85204: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=76;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=6946;
 end   
18'd85205: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=12;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=1132;
 end   
18'd85206: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=91;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=8331;
 end   
18'd85207: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=93;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=8523;
 end   
18'd85208: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=9;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=889;
 end   
18'd85209: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=20;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1900;
 end   
18'd85210: begin  
  clrr<=0;
  maplen<=1;
  fillen<=9;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd85342: begin  
rid<=1;
end
18'd85343: begin  
end
18'd85344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd85345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd85346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd85347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd85348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd85349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd85350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd85351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd85352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd85353: begin  
rid<=0;
end
18'd85401: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=89;
   mapp<=28;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4970;
 end   
18'd85402: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=94;
   mapp<=0;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=7320;
 end   
18'd85403: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=42;
   mapp<=59;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=10899;
 end   
18'd85404: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=42;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[3]<=30;
 end   
18'd85405: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=40;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd85406: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd85407: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd85408: begin  
  clrr<=0;
  maplen<=5;
  fillen<=3;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd85542: begin  
rid<=1;
end
18'd85543: begin  
end
18'd85544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd85545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd85546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd85547: begin  
rid<=0;
end
18'd85601: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=45;
   mapp<=46;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13833;
 end   
18'd85602: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=88;
   mapp<=64;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=15098;
 end   
18'd85603: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=49;
   mapp<=86;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=14027;
 end   
18'd85604: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=27;
   mapp<=71;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=12241;
 end   
18'd85605: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd85606: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=66;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd85607: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=74;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd85608: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd85609: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd85610: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd85611: begin  
  clrr<=0;
  maplen<=7;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd85742: begin  
rid<=1;
end
18'd85743: begin  
end
18'd85744: begin  
check<=expctdoutput[0]-outcheck;
end
18'd85745: begin  
check<=expctdoutput[1]-outcheck;
end
18'd85746: begin  
check<=expctdoutput[2]-outcheck;
end
18'd85747: begin  
check<=expctdoutput[3]-outcheck;
end
18'd85748: begin  
rid<=0;
end
18'd85801: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=46;
   mapp<=81;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=3726;
 end   
18'd85802: begin  
  clrr<=0;
  maplen<=1;
  fillen<=1;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[1]<=10;
 end   
18'd85942: begin  
rid<=1;
end
18'd85943: begin  
end
18'd85944: begin  
check<=expctdoutput[0]-outcheck;
end
18'd85945: begin  
rid<=0;
end
18'd86001: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=68;
   mapp<=14;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=13596;
 end   
18'd86002: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=89;
   mapp<=50;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=16788;
 end   
18'd86003: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=83;
   mapp<=32;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=23039;
 end   
18'd86004: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=9;
   mapp<=73;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=21031;
 end   
18'd86005: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=87;
   mapp<=43;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd86006: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=95;
   mapp<=12;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd86007: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=32;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd86008: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=83;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd86009: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd86010: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd86011: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd86012: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd86013: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13596;
 end   
18'd86014: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13596;
 end   
18'd86015: begin  
  clrr<=0;
  maplen<=9;
  fillen<=6;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[0]<=13596;
 end   
18'd86142: begin  
rid<=1;
end
18'd86143: begin  
end
18'd86144: begin  
check<=expctdoutput[0]-outcheck;
end
18'd86145: begin  
check<=expctdoutput[1]-outcheck;
end
18'd86146: begin  
check<=expctdoutput[2]-outcheck;
end
18'd86147: begin  
check<=expctdoutput[3]-outcheck;
end
18'd86148: begin  
rid<=0;
end
18'd86201: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=48;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=4637;
 end   
18'd86202: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=79;
   mapp<=35;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=3336;
 end   
18'd86203: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=7;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=1343;
 end   
18'd86204: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=30;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=3090;
 end   
18'd86205: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=54;
   mapp<=0;
   pp<=40;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=2181;
 end   
18'd86206: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=1;
   mapp<=0;
   pp<=50;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[5]<=1489;
 end   
18'd86207: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=40;
   mapp<=0;
   pp<=60;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[6]<=3125;
 end   
18'd86208: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=43;
   mapp<=0;
   pp<=70;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[7]<=2377;
 end   
18'd86209: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=18;
   mapp<=0;
   pp<=80;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[8]<=1202;
 end   
18'd86210: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=12;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=1;
   gp<=0;
 expctdoutput[9]<=90;
 end   
18'd86211: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[10]<=100;
 end   
18'd86212: begin  
  clrr<=0;
  maplen<=2;
  fillen<=10;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[11]<=110;
 end   
18'd86342: begin  
rid<=1;
end
18'd86343: begin  
end
18'd86344: begin  
check<=expctdoutput[0]-outcheck;
end
18'd86345: begin  
check<=expctdoutput[1]-outcheck;
end
18'd86346: begin  
check<=expctdoutput[2]-outcheck;
end
18'd86347: begin  
check<=expctdoutput[3]-outcheck;
end
18'd86348: begin  
check<=expctdoutput[4]-outcheck;
end
18'd86349: begin  
check<=expctdoutput[5]-outcheck;
end
18'd86350: begin  
check<=expctdoutput[6]-outcheck;
end
18'd86351: begin  
check<=expctdoutput[7]-outcheck;
end
18'd86352: begin  
check<=expctdoutput[8]-outcheck;
end
18'd86353: begin  
rid<=0;
end
18'd86401: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=83;
   mapp<=72;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=5976;
 end   
18'd86402: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=85;
   mapp<=0;
   pp<=10;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=6130;
 end   
18'd86403: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=86;
   mapp<=0;
   pp<=20;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=6212;
 end   
18'd86404: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=20;
   mapp<=0;
   pp<=30;
   gm<=0;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=1470;
 end   
18'd86405: begin  
  clrr<=0;
  maplen<=1;
  fillen<=4;
   filterp<=0;
   mapp<=0;
   pp<=0;
   gm<=0;
   gf<=0;
   gp<=0;
 expctdoutput[4]<=40;
 end   
18'd86542: begin  
rid<=1;
end
18'd86543: begin  
end
18'd86544: begin  
check<=expctdoutput[0]-outcheck;
end
18'd86545: begin  
check<=expctdoutput[1]-outcheck;
end
18'd86546: begin  
check<=expctdoutput[2]-outcheck;
end
18'd86547: begin  
check<=expctdoutput[3]-outcheck;
end
18'd86548: begin  
rid<=0;
end
18'd86601: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=6;
   mapp<=39;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[0]<=15374;
 end   
18'd86602: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=21;
   mapp<=6;
   pp<=10;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[1]<=14814;
 end   
18'd86603: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=75;
   mapp<=76;
   pp<=20;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[2]<=16027;
 end   
18'd86604: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=20;
   mapp<=24;
   pp<=30;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[3]<=19119;
 end   
18'd86605: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=92;
   mapp<=52;
   pp<=40;
   gm<=1;
   gf<=1;
   gp<=1;
 expctdoutput[4]<=16205;
 end   
18'd86606: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=65;
   mapp<=37;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[5]<=50;
 end   
18'd86607: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=47;
   mapp<=35;
   pp<=0;
   gm<=1;
   gf<=1;
   gp<=0;
 expctdoutput[6]<=60;
 end   
18'd86608: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=99;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[7]<=70;
 end   
18'd86609: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=16;
   pp<=0;
   gm<=1;
   gf<=0;
   gp<=0;
 expctdoutput[8]<=80;
 end   
18'd86610: begin  
  clrr<=0;
  maplen<=11;
  fillen<=7;
   filterp<=0;
   mapp<=90;
