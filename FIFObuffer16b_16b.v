

module FIFObuffer16b_16b( Clk, 

                   dataIn, 

                   RD, 

                   WR, 

                   EN, 

                   dataOut, 

                   Rst,

                   EMPTY, 

                   FULL 

                   ); 

input  Clk, 

       RD, 

       WR, 

       EN, 

       Rst;

output  EMPTY, 

        FULL;

parameter STORAGE = 4 ; 

input   [15:0]    dataIn;

output reg [15:0] dataOut; // internal registers 

reg [3:0]  Count = 0; 

reg [1:0] FIFO [0:STORAGE-1]; 

reg [3:0]  readCounter = 0, 

           writeCounter = 0; 
reg empty=1;
assign EMPTY=empty;
//assign EMPTY = (Count==0)? 1'b1:1'b0; 

assign FULL = (Count==STORAGE)? 1'b1:1'b0; 

always @ (posedge Clk) 

begin 

 if (EN==0); 

 else begin 

  if (Rst) begin 

		   readCounter = 0; 

		   writeCounter = 0; 
			
			empty=1;
		  end 

  else begin
  if (RD ==1'b1 && Count!=0) begin 

		   dataOut  = FIFO[readCounter]; 

		   readCounter = readCounter+1; 

		  end 

   if (WR==1'b1 && Count<STORAGE) begin
		   FIFO[writeCounter]  = dataIn; 

		   writeCounter  = writeCounter+1; 

		  end 

	else; 
	Count = (readCounter > writeCounter) ? readCounter - writeCounter : writeCounter - readCounter ; 
	empty = Count==0? 1:0;
end
 end 

 if (writeCounter==STORAGE) 

  writeCounter=0; 

 else if (readCounter==STORAGE) 

  readCounter=0; 

 else;



end 

endmodule
