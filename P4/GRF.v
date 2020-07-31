`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:35:43 07/18/2019 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	 input clk,
    input reset,
	 input RegWrite,
	 input RegDst,
	 input jal,
	 input [4:0] rd,
	 input [4:0] rt,
    input [4:0] rs,
	 input [31:0] MemOut,
	 input [31:0] PC_next,
	 input [31:0] PC,
    output [31:0] RData1,
    output [31:0] RData2
    );
	 reg[31:0] rf[31:0];
	 integer i = 0;
	 wire [4:0] WAddr;
	 wire [31:0] WData;
	 assign WAddr = (RegDst==0&&jal==0)?(rt):
						 (RegDst==1&&jal==0)?(rd):
						 (jal==1)?(5'b11111):000;
	 assign WData = (jal==0)?(MemOut):
						 (jal==1)?(PC_next):000;
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
		else if(RegWrite==1)
		begin
			if(WAddr==0)
				rf[WAddr] <= 0;
			else
				rf[WAddr] <= WData;
			$display("@%h: $%d <= %h",PC,WAddr,WData);
		end
	 end
	 assign  RData1=rf[rs];
	 assign  RData2=rf[rt];
endmodule
