`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:34:30 07/18/2019 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input MemWrite,
    input [11:2] MemAddr,
	 input [31:0] addr,
    input [31:0] MemData,
    input [31:0] PC,
	 input [31:0] ALUresult,
	 input MemtoReg,
	 input lh_Enable,
	 input lb_Enable,
	 input lbu_Enable,
    output [31:0] MemOut
    );
	 reg [31:0] RAM [1023:0];
	 integer i = 0;
	 wire [31:0] LH;
	 wire [31:0] LB;
	 wire [31:0] LBU;
	 assign LH = (addr[1]==0)?({{16{RAM[MemAddr[11:2]][15]}},{RAM[MemAddr[11:2]][15:0]}}):
					 (addr[1]==1)?({{16{RAM[MemAddr[11:2]][31]}},{RAM[MemAddr[11:2]][31:16]}}):000;
	 assign LB = (addr[1:0]==0)?({{24{RAM[MemAddr[11:2]][7]}},{RAM[MemAddr[11:2]][7:0]}}):
					 (addr[1:0]==1)?({{24{RAM[MemAddr[11:2]][15]}},{RAM[MemAddr[11:2]][15:8]}}):
					 (addr[1:0]==2)?({{24{RAM[MemAddr[11:2]][23]}},{RAM[MemAddr[11:2]][23:16]}}):
					 (addr[1:0]==3)?({{24{RAM[MemAddr[11:2]][31]}},{RAM[MemAddr[11:2]][31:24]}}):000;
	 assign LBU = (addr[1:0]==0)?({{24'b0},{RAM[MemAddr[11:2]][7:0]}}):
					  (addr[1:0]==1)?({{24'b0},{RAM[MemAddr[11:2]][15:8]}}):
					  (addr[1:0]==2)?({{24'b0},{RAM[MemAddr[11:2]][23:16]}}):
					  (addr[1:0]==3)?({{24'b0},{RAM[MemAddr[11:2]][31:24]}}):000;
	 assign MemOut = (MemtoReg==0&&lb_Enable==0&&lh_Enable==0&&lbu_Enable==0)?(ALUresult):
						  (MemtoReg==1&&lb_Enable==0&&lh_Enable==0&&lbu_Enable==0)?(RAM[MemAddr[11:2]]):
						  (lb_Enable==1)?(LB):
						  (lh_Enable==1)?(LH):
						  (lbu_Enable==1)?(LBU):000;
	 initial
	 begin
		for(i=0;i<1024;i=i+1)
			RAM[i] = 0;
	 end
	 always @(posedge clk, posedge reset)
	 begin
		if(reset==1)
			for(i=0;i<1024;i=i+1)
				RAM[i]<=0;
		else
		begin
			if(MemWrite==1)
			begin
				RAM[MemAddr[11:2]] <= MemData;
				$display("@%h: *%h <= %h",PC,addr,MemData);
			end
		end
	 end
endmodule
