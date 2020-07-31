`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:06 07/23/2019 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	 input clk,
	 input reset,
	 input [31:0] IR_E,
	 input [31:0] PC4_E,
	 input [31:0] ALUout_E,
	 input [31:0] ALU_B,
	 input [31:0] PC8_E,
	 output reg [31:0] IR_M,
	 output reg [31:0] PC4_M,
	 output reg [31:0] PC8_M,
	 output reg [31:0] ALUout_M,
	 output reg [31:0] RT_M
    );
	 initial
	 begin
		IR_M = 0;
		PC4_M = 0;
		PC8_M = 0;
		ALUout_M = 0;
		RT_M = 0;
	 end
	 always @(posedge clk)
	 begin
		if(reset==1)
		begin
			IR_M <= 0;
			PC4_M <= 0;
			PC8_M <= 0;
			ALUout_M <= 0;
			RT_M <= 0;
		end
		else
		begin
			IR_M <= IR_E;
			PC4_M <= PC4_E;
			PC8_M <= PC8_E;
			ALUout_M <= ALUout_E;
			RT_M <= ALU_B;
		end
    end
endmodule
