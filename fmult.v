// this is the special multiplyr module
module mult_controller(
input [16:0] x0,x1,
input [16:0] w0,w1,
output sll1,sll2,
 output [3:0] out1,out2,
 output [7:0] out3,out4
);
 
 wire [7:0] x,y; //x0,w0
wire [7:0] u,z; //x1,w1
wire [3:0] x2,u2;


assign sll1 = (w0==0)||((y!=0)&&(x[7:4]==0));
assign sll2 = (w1==0)||((z!=0)&&(u[7:4]==0));

assign x2 = (x[7:4]==0)? x[3:0]:(x[7:4]+x[3]);  
assign u2 = (u[7:4]==0)? u[3:0]:(u[7:5]+u[3]);  


mux_8_2 mux1(.a(x0),.b(w0),.sel((w0[7:4]==0)),.c(x));
mux_8_2 mux2(.a(x0),.b(w0),.sel((w0[7:4]!=0)),.c(y));
mux_8_2 mux3(.a(x1),.b(w1),.sel((w1[7:4]==0)),.c(u));
mux_8_2 mux4(.a(x1),.b(w1),.sel((w1[7:4]!=0)),.c(z));

mux_2_8_special special(.x0(x2),.x1(u2),.w0(y),.w1(z),.selector({w0==0,w1==0}),
.x0full(x0),.x1full(x1),.w0full(w0),.w1full(w1),
.x0outt(out1),.x1outt(out2),
.w0outt(out3),.w1outt(out4));





endmodule 

module mux_2_8_special(
input [3:0] x0,x1,
input [7:0] w0,w1,
input [1:0]selector,
input [7:0] x0full,x1full,w0full,w1full,
output  [3:0] x0outt,x1outt,
output [7:0] w0outt,w1outt
);


reg [3:0] x0out,x1out;
reg [7:0] w0out,w1out;

assign x0outt = x0out;
assign x1outt = x1out;

assign w0outt = w0out;
assign w1outt = w1out;

always@(x0 or x1 or w0 or w1) begin
	case (selector)
		2'b00: begin
			x0out<=x0;
			x1out<=x1;
			w0out<=w0;
			w1out<=w1;
		end
		2'b10: begin
			x0out<=x1full[7:4]; //if w0 is 0, then multiply x1w1in full
			x1out<=x1full[3:0];
			w0out<=w1full[7:4];
			w1out<=w1full[3:0];
		end
		2'b01: begin
			x0out<=x0full[7:4]; //if w1 is 0, then multiply x0w0in full
			x1out<=x0full[3:0];
			w0out<=w0full[7:4];
			w1out<=w0full[3:0]; //remmember - x0, and x1 can't be 0 without w0 or w1 respectivl being 0 as well
		end
		2'b11: begin
			x0out<=0;
			x1out<=0;
			w0out<=0;
			w1out<=0;
		end
	endcase
end
endmodule


module mult( input [3:0] a,
 input [7:0] b,

output [11:0] c
);
assign c=a*b;

endmodule


module mux_8_2(
input [8:0] a,b,
input sel,
output [8:0] c
);

assign c= sel? b:a;

endmodule


module mux_16_2(
input [15:0] a,b,
input sel,
output [15:0] c
);

assign c= sel? b:a;

endmodule


module sll_4(
input [11:0]in,

output [15:0] out
);

assign out[15:4] = in;
assign out[3:0] =0;

endmodule


module fmult(
input [7:0] x0,x1,w0,w1,

output [31:0] c

);


wire [3:0]xx0,xx1;
wire [7:0]ww0,ww1;
wire [11:0] x11,x22;
wire [15:0] x1sll,x2sll;

mult_controller cont(.x0(x0),.x1(x1),
 .w0(w0),.w1(w1),
.sll1(sll1),.sll2(sll2),
 .out1(xx0),.out2(xx1),
 .out3(ww0),.out4(ww1)
);

mult ma(.a(xx0),.b(ww0),.c(x11));
mult mb(.a(xx1),.b(ww1),.c(x22));

sll_4 sa(.in(x11),.out(x1sll));
sll_4 sb(.in(x22),.out(x2sll));

mux_16_2 uxa(.a(x11),.b(x1sll),.sel(sll1),.c(c[15:0]));
mux_16_2 uxb(.a(x22),.b(x2sll),.sel(sll2),.c(c[31:16]));





endmodule