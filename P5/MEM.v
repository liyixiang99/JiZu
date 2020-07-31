`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:49:02 07/23/2019 
// Design Name: 
// Module Name:    MEM 
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
module MEM(
    input clk,
    input reset,
	 input [31:0] IR_M,
	 input [31:0] WD,
    input [31:0] PC4_M,
	 input [31:0] ALUout_M,
    output [31:0] DM
    );
	 wire MemWrite_M;
	 wire MemtoReg_M;
	 Controller Controller_MEM(.func(IR_M[5:0]),.Op(IR_M[31:26]),.MemWrite(MemWrite_M),.MemtoReg(MemtoReg_M),.lwl(lwl_M));
	 reg [31:0] RAM [1023:0];
	 wire [11:2] MemAddr;
	 wire [31:0] addr;
	 integer i = 0;
	 assign MemAddr = ALUout_M[11:2];
	 assign addr = ALUout_M;
	 wire [31:0] LWL;
	 assign LWL = (addr[1:0]==0)?({RAM[addr[11:2]][31:16],WD[15:0]}):
					  (addr[1:0]==1)?({RAM[addr[11:2]][23:8],WD[15:0]}):
					  (addr[1:0]==2)?({RAM[addr[11:2]][15:0],WD[15:0]}):
					  (addr[1:0]==3)?({RAM[addr[11:2]][7:0],RAM[addr[11:2]+1][31:24],WD[15:0]}):000;
	 assign DM = (MemtoReg_M==0&&lwl_M==0)?(ALUout_M):
					 (MemtoReg_M==1&&lwl_M==0)?(RAM[MemAddr[11:2]]):
					 (lwl_M==1)?(LWL):000;
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
			if(MemWrite_M==1)
			begin
				RAM[MemAddr[11:2]] <= WD;
				$display("%d@%h: *%h <= %h", $time,PC4_M-4,addr,WD);
			end
		end
	 end
endmodule
