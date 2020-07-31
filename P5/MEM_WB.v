`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:45 07/23/2019 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
	 input reset,
	 input [31:0] PC4_M,
	 input [31:0] PC8_M,
	 input [31:0] DM,
	 input [31:0] IR_M,
	 output reg [31:0] IR_W,
	 output reg [31:0] PC4_W,
	 output reg [31:0] PC8_W,
	 output reg [31:0] DM_W
    );
	 initial
	 begin
		IR_W = 0;
		PC4_W = 0;
		PC8_W = 0;
		DM_W = 0;
	 end
	 always @(posedge clk)
	 begin
		if(reset==1)
		begin
			IR_W <= 0;
			PC4_W <= 0;
			PC8_W <= 0;
			DM_W <= 0;
		end
		else
		begin
			IR_W <= IR_M;
			PC4_W <= PC4_M;
			PC8_W <= PC8_M;
			DM_W <= DM;
		end
	 end
endmodule
