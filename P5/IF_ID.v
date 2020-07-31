`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:56 07/22/2019 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	 input clk,
	 input reset,
	 input [31:0] ADD4,
	 input [31:0] ADD8,
	 input [31:0] IM,
	 input IF_ID_en,
	 output reg [31:0] IR_D,
	 output reg [31:0] PC4_D,
	 output reg [31:0] PC8_D
    );
	 initial
	 begin
		IR_D = 0;
		PC4_D = 0;
		PC8_D = 0;
	 end
	 always @(posedge clk)
	 begin
		if(reset==1)
		begin
			IR_D <= 0;
			PC4_D <= 0;
			PC8_D <= 0;
		end
		else
		begin
			if(IF_ID_en==1)
			begin
				IR_D <= IM;
				PC4_D <= ADD4;
				PC8_D <= ADD8;
			end
		end
	 end
endmodule
