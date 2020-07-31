`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:49 07/23/2019 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	 input clk,
	 input reset,
	 input [31:0] IR_D,
	 input [31:0] PC4_D,
	 input [31:0] PC8_D,
	 input [31:0] D1,
	 input [31:0] D2,
	 input [31:0] EXT,
	 input ID_EX_reset,
	 output reg [31:0] IR_E,
	 output reg [31:0] PC4_E,
	 output reg [31:0] PC8_E,
	 output reg [31:0] RS_E,
	 output reg [31:0] RT_E,
	 output reg [31:0] EXT_E
    );
	 initial
	 begin
	 	IR_E = 0;
		PC4_E = 0;
		PC8_E = 0;
		RS_E = 0;
		RT_E = 0;
		EXT_E = 0;
	 end
	 always @(posedge clk)
	 begin
		if(reset==1||ID_EX_reset==1)
		begin
			IR_E <= 0;
			PC4_E <= 0;
			PC8_E <= 0;
			RS_E <= 0;
			RT_E <= 0;
			EXT_E <= 0;
		end
		else
		begin
			IR_E <= IR_D;
			PC4_E <= PC4_D;
			PC8_E <= PC8_D;
			RS_E <= D1;
			RT_E <= D2;
			EXT_E <= EXT;
		end
	 end 
endmodule
