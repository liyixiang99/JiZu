`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:16 11/07/2018 
// Design Name: 
// Module Name:    gray 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
    reg [2:0] counter;
	 reg of;
	 initial begin
	 counter = 0;
	 of = 0;
	 end
	 always @(posedge Clk)begin
	    if(Reset == 1)begin
		    counter <= 3'b000;
			 of <= 1'b0;
		 end
		 else if(Reset == 0 && En == 1)begin
		    counter <= counter+1;
		 end
		 if(counter>= 3'b111)begin
		    counter <= 3'b000;
			 of <= 1'b1;
 		 end
	 end
	 assign Output = (counter >> 1) ^ counter;
	 assign Overflow = of; 
endmodule