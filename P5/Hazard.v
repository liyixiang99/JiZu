`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:29 07/23/2019 
// Design Name: 
// Module Name:    Hazard 
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
module Hazard(
		input [31:0] IR_D,
		input [31:0] IR_E,
		input [31:0] IR_M,
		input [31:0] IR_W,
		input [31:0] ALUout_M,
		input [31:0] RData1,
		input [31:0] RData2,
		input [31:0] RS_E,
		input [31:0] RT_E,
		input [31:0] RT_M,
		input [31:0] DM_W,
		output IF_en,
		output IF_ID_en,
		output ID_EX_reset,
		output [31:0] D1,
		output [31:0] D2,
		output [31:0] ALU_A,
		output [31:0] ALU_B,
		output [31:0] WD
    );
    wire [1:0] Tnew_E;
    wire Tnew_M;
    wire Tnew_W;
    wire Tuse_rs;
    wire [1:0] Tuse_rt;
    wire rs_use_D;
    wire rt_use_D;
	 wire [4:0] WAddr_E;
	 wire [4:0] WAddr_M;
	 wire [4:0] WAddr_W;
	 wire RegWrite_E;
	 wire RegWrite_M;
	 wire RegWrite_W;
	 
	 Tnew_Tuse Tnew_Tuse_D(.IR(IR_D),.Tuse_rs(Tuse_rs),.Tuse_rt(Tuse_rt),.rs_use_D(rs_use_D),.rt_use_D(rt_use_D));
	 Tnew_Tuse Tnew_Tuse_E(.IR(IR_E),.Tnew_E(Tnew_E),.WAddr(WAddr_E),.RegWrite(RegWrite_E));
	 Tnew_Tuse Tnew_Tuse_M(.IR(IR_M),.Tnew_M(Tnew_M),.WAddr(WAddr_M),.RegWrite(RegWrite_M));
	 Tnew_Tuse Tnew_Tuse_W(.IR(IR_W),.Tnew_W(Tnew_W),.WAddr(WAddr_W),.RegWrite(RegWrite_W),.DM_W(DM_W));
//×ª·¢	 
	 assign D1 = (WAddr_M==IR_D[25:21]&&RegWrite_M==1&&IR_D[25:21]!=0&&Tnew_M==0)?ALUout_M:
					 (WAddr_W==IR_D[25:21]&&RegWrite_W==1&&IR_D[25:21]!=0&&Tnew_W==0)?DM_W:RData1;
					 
	 assign D2 = (WAddr_M==IR_D[20:16]&&RegWrite_M==1&&IR_D[20:16]!=0&&Tnew_M==0)?ALUout_M:
					 (WAddr_W==IR_D[20:16]&&RegWrite_W==1&&IR_D[20:16]!=0&&Tnew_W==0)?DM_W:RData2;
					 
	 assign ALU_A = (WAddr_M==IR_E[25:21]&&RegWrite_M==1&&IR_E[25:21]!=0&&Tnew_M==0)?ALUout_M:
						 (WAddr_W==IR_E[25:21]&&RegWrite_W==1&&IR_E[25:21]!=0&&Tnew_W==0)?DM_W:RS_E;
						 
	 assign ALU_B = (WAddr_M==IR_E[20:16]&&RegWrite_M==1&&IR_E[20:16]!=0&&Tnew_M==0)?ALUout_M:
					    (WAddr_W==IR_E[20:16]&&RegWrite_W==1&&IR_E[20:16]!=0&&Tnew_W==0)?DM_W:RT_E;
						 
	 assign WD = (WAddr_W==IR_M[20:16]&&RegWrite_W==1&&IR_M[20:16]!=0&&Tnew_W==0)?DM_W:RT_M;
//ÔÝÍ£ 
	 wire PC_en;
	 
	 assign PC_en = (WAddr_E==IR_D[25:21]&&RegWrite_E==1&&IR_D[25:21]!=0&&Tuse_rs<Tnew_E&&rs_use_D==1&&IR_D[25:21]!=0)?0:
						 (WAddr_M==IR_D[25:21]&&RegWrite_M==1&&IR_D[25:21]!=0&&Tuse_rs<Tnew_M&&rs_use_D==1&&IR_D[25:21]!=0)?0:
						 (WAddr_E==IR_D[20:16]&&RegWrite_E==1&&IR_D[20:16]!=0&&Tuse_rt<Tnew_E&&rt_use_D==1&&IR_D[25:21]!=0)?0:
						 (WAddr_M==IR_D[20:16]&&RegWrite_M==1&&IR_D[20:16]!=0&&Tuse_rt<Tnew_M&&rt_use_D==1&&IR_D[25:21]!=0)?0:1;
	 assign IF_en = (PC_en==0)?0:1;
	 assign IF_ID_en = (PC_en==0)?0:1;
	 assign ID_EX_reset = (PC_en==0)?1:0;
	 
endmodule
