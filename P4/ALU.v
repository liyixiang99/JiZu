`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:31:55 07/18/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] RData1,
	 input [31:0] RData2,
    input [2:0] ALUOp,
	 input Branch,
	 input [1:0] BOp,
	 input ALUSrc,
	 input [31:0] EXTOut, 
    output [31:0] ALUresult,
    output PCSrc
    );
	 wire [31:0] ALUB;
	 assign ALUB = (ALUSrc==0)?(RData2):
						(ALUSrc==1)?(EXTOut):000;
	 assign ALUresult = (ALUOp==0)?(RData1&ALUB):
							  (ALUOp==1)?(RData1|ALUB):
							  (ALUOp==2)?(RData1+ALUB):
							  (ALUOp==3)?(RData1-ALUB):
							  (ALUOp==4)?(ALUB):000;
	 assign PCSrc = (RData1==ALUB&&Branch==1&&BOp==0||$signed(RData1)<0&&Branch==1&&BOp==1||$signed(RData1)==0&&Branch==1&&BOp==1||RData1!=ALUB&&Branch==1&&BOp==2)?1:0;
endmodule
