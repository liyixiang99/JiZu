`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:27:10 07/23/2019 
// Design Name: 
// Module Name:    EX 
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
module EX(
	 input [31:0] IR_E,
	 input [31:0] ALU_A,
	 input [31:0] ALU_B,
	 input [31:0] PC4_E,
	 input [31:0] EXT_E,
    output [31:0] ALUout_E
    );
	 wire [2:0] ALUOp_E;
	 wire ALUSrc_E;
	 wire blezals_E;
	 wire blezalr_E;
	 Controller Controller_EX(.func(IR_E[5:0]),.Op(IR_E[31:26]),.ALUOp(ALUOp_E),.ALUSrc(ALUSrc_E),.jal(jal_E),.blezals(blezals_E),.blezalr(blezalr_E));
	 wire [31:0] ALUB;
	 integer i;
	 reg PD;
	 reg [31:0] temp;
	 reg [31:0] result;
	 always @(*)
	 begin
		temp = 32;
		for(i=31;i>=0;i=i-1)
		begin
			if(ALU_A[i]==1&&PD==0)
			begin
				temp = 31-i;
				PD = 1;
			end
		end
	 PD = 0;
	 result = temp;
	 end
	 assign ALUB = (ALUSrc_E==0)?(ALU_B):EXT_E;
	 assign ALUout_E = (jal_E==1||blezals_E==1||blezalr_E==1)?(PC4_E+4):
							 (ALUOp_E==0)?(ALU_A&ALUB):
							 (ALUOp_E==1)?(ALU_A|ALUB):
							 (ALUOp_E==2)?(ALU_A+ALUB):
							 (ALUOp_E==3)?(ALU_A-ALUB):
							 (ALUOp_E==4)?(ALUB):
							 (ALUOp_E==5)?(result):000;
endmodule
