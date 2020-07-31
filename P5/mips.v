`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:04:18 07/24/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
	 input clk,
	 input reset
    );
	 wire [31:0] NPC;
	 wire [31:0] IM;
	 wire [31:0] ADD4;
	 wire [31:0] ADD8;
	 wire [31:0] IR_D;
	 wire [31:0] PC4_D;
	 wire [31:0] PC8_D;
	 wire [31:0] IR_W;
	 wire [31:0] PC4_W;
	 wire [31:0] ALUout_M;
	 wire [31:0] D1;
	 wire [31:0] D2;
	 wire j_D;
	 wire jr_D;
	 wire PCSrc_D;
    wire [31:0] EXT;
    wire [31:0] RData1;
    wire [31:0] RData2;
	 wire [31:0] IR_E;
	 wire [31:0] PC4_E;
	 wire [31:0] PC8_E;
	 wire [31:0] RS_E;
	 wire [31:0] RT_E;
	 wire [31:0] EXT_E;
	 wire [31:0] ALU_A;
	 wire [31:0] ALU_B;
    wire [31:0] ALUout_E;
	 wire [31:0] IR_M;
	 wire [31:0] PC4_M;
	 wire [31:0] PC8_M;
	 wire [31:0] RT_M;
    wire [31:0] WD;
    wire [31:0] DM;
	 wire [31:0] PC8_W;
	 wire [31:0] DM_W;
	 wire IF_en;
	 wire IF_ID_en;
	 wire ID_EX_reset;


	 
	 IF IF(.clk(clk),.reset(reset),.IF_en(IF_en),.NPC(NPC),.j_D(j_D),.jr_D(jr_D),.PCSrc_D(PCSrc_D),.IM(IM),.ADD4(ADD4),.ADD8(ADD8));
	 IF_ID IF_ID(.clk(clk),.reset(reset),.ADD4(ADD4),.ADD8(ADD8),.IM(IM),.IF_ID_en(IF_ID_en),.IR_D(IR_D),.PC4_D(PC4_D),.PC8_D(PC8_D));
	 ID ID(.clk(clk),.reset(reset),.IR_D(IR_D),.IR_W(IR_W),.PC4_D(PC4_D),.PC8_D(PC8_D),.PC4_W(PC4_W),.DM_W(DM_W),.D1(D1),.D2(D2),.j_D(j_D),.jr_D(jr_D),.PCSrc_D(PCSrc_D),.EXT(EXT),.RData1(RData1),.RData2(RData2),.NPC(NPC));
	 ID_EX ID_EX(.clk(clk),.reset(reset),.ID_EX_reset(ID_EX_reset),.IR_D(IR_D),.D1(D1),.D2(D2),.EXT(EXT),.IR_E(IR_E),.PC4_D(PC4_D),.PC4_E(PC4_E),.PC8_D(PC8_D),.PC8_E(PC8_E),.RS_E(RS_E),.RT_E(RT_E),.EXT_E(EXT_E));
	 EX EX(.IR_E(IR_E),.ALU_A(ALU_A),.ALU_B(ALU_B),.PC4_E(PC4_E),.EXT_E(EXT_E),.ALUout_E(ALUout_E));
	 EX_MEM EX_MEM(.clk(clk),.reset(reset),.IR_E(IR_E),.PC4_E(PC4_E),.PC8_E(PC8_E),.ALUout_E(ALUout_E),.ALU_B(ALU_B),.IR_M(IR_M),.PC4_M(PC4_M),.PC8_M(PC8_M),.ALUout_M(ALUout_M),.RT_M(RT_M));
	 MEM MEM(.clk(clk),.reset(reset),.IR_M(IR_M),.WD(WD),.PC4_M(PC4_M),.ALUout_M(ALUout_M),.DM(DM));
	 MEM_WB MEM_WB(.clk(clk),.reset(reset),.PC4_M(PC4_M),.PC8_M(PC8_M),.DM(DM),.IR_M(IR_M),.IR_W(IR_W),.PC4_W(PC4_W),.PC8_W(PC8_W),.DM_W(DM_W));
	 Hazard Hazard(.IR_D(IR_D),.IR_E(IR_E),.IR_M(IR_M),.IR_W(IR_W),.ALUout_M(ALUout_M),.RData1(RData1),.RData2(RData2),.RS_E(RS_E),.RT_E(RT_E),.RT_M(RT_M),.DM_W(DM_W),.IF_en(IF_en),.IF_ID_en(IF_ID_en),.ID_EX_reset(ID_EX_reset),.D1(D1),.D2(D2),.ALU_A(ALU_A),.ALU_B(ALU_B),.WD(WD));


endmodule
