`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:20:16 07/22/2019 
// Design Name: 
// Module Name:    ID 
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
module ID(
	 input clk,
    input reset,
	 input [31:0] IR_D,
	 input [31:0] IR_W,
	 input [31:0] PC4_D,
	 input [31:0] PC8_D,
	 input [31:0] PC4_W,
	 input [31:0] DM_W,
	 input [31:0] D1,
	 input [31:0] D2,
	 output j_D,
	 output jr_D,
	 output PCSrc_D,
    output [31:0] EXT,
    output [31:0] RData1,
    output [31:0] RData2,
	 output [31:0] NPC
    );
	 wire [1:0] EXTOp_D;
	 wire Branch_D;
	 wire RegWrite_W;
	 wire lwpl_W;
	 wire [1:0] BOp_D;
	 wire blezals_W;
	 wire blezalr_D;
	 Controller Controller_ID(.func(IR_D[5:0]),.Op(IR_D[31:26]),.EXTOp(EXTOp_D),.Branch(Branch_D),.j(j_D),.jr(jr_D),.BOp(BOp_D),.blezalr(blezalr_D));
	 Controller Controller_WB(.func(IR_W[5:0]),.Op(IR_W[31:26]),.RegWrite(RegWrite_W),.RegDst(RegDst_W),.jal(jal_W),.lwpl(lwpl_W),.blezals(blezals_W));
	 reg [31:0] rf[31:0];
	 integer i = 0;
	 wire [4:0] WAddr_W;
	 assign PCSrc_D = (D1==D2&&Branch_D==1&&BOp_D==0||$signed(D1)<=0&&Branch_D==1&&BOp_D==1||$signed(D1)>=0&&Branch_D==1&&BOp_D==2)?1:0;
	 assign EXT = (EXTOp_D==0)?({{16'b0},{IR_D[15:0]}}):
					  (EXTOp_D==1)?({{16{IR_D[15]}},{IR_D[15:0]}}):
					  (EXTOp_D==2)?({{IR_D[15:0]},{16'b0}}):000;
	 assign WAddr_W = (RegDst_W==0&&jal_W==0&&lwpl_W==0&&blezals_W==0||(lwpl_W==1&&DM_W%4!=0&&blezals_W==0))?(IR_W[20:16]):
							(RegDst_W==1&&jal_W==0)?(IR_W[15:11]):
							(jal_W==1||(lwpl_W==1&&DM_W%4==0)||blezals_W==1)?(5'b11111):000;
	 assign NPC = (PCSrc_D==1&&j_D==0&&jr_D==0&&blezalr_D==0)?(PC4_D+{{14{IR_D[15]}},{IR_D[15:0]},2'b00}):
					  (PCSrc_D==0&&j_D==0&&jr_D==1&&blezalr_D==0)?D1:
					  (PCSrc_D==1&&j_D==0&&jr_D==0&&blezalr_D==1)?D2:
                 (PCSrc_D==0&&j_D==1&&jr_D==0&&blezalr_D==0)?({PC4_D[31:28],IR_D[25:0],2'b00}):PC8_D;
	 initial
	 begin
		for(i=0;i<32;i=i+1)
			rf[i] = 0;
	 end
	 always @(posedge clk)
	 begin
		if(reset==1)
			for(i=0;i<32;i=i+1)
				rf[i] <= 0;
		else if(RegWrite_W==1)
		begin
			if(WAddr_W==0)
				rf[WAddr_W] <= 0;
			else
				rf[WAddr_W] <= DM_W;
				
			$display("%d@%h: $%d <= %h", $time,PC4_W-4,WAddr_W,DM_W);
		end
	 end
	 assign  RData1=rf[IR_D[25:21]];
	 assign  RData2=rf[IR_D[20:16]];
endmodule
