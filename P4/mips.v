`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:40 07/18/2019 
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
	 wire j;
	 wire jr;
	 
	 wire [31:0] instr;
	 wire [31:0] PC;
	 wire [31:0] PC_next;
	 
	 wire RegDst;
	 wire RegWrite;
	 wire jal;
	 wire [4:0] rd;
	 wire [4:0] rt;
	 wire [4:0] rs;
    wire [4:0] WAddr;

    wire [31:0] WData;
	 
    wire [31:0] RData1;
    wire [31:0] RData2;
	 

    wire [2:0] ALUOp;
	 wire Branch;
	 wire [1:0] BOp;
	 
    wire [31:0] ALUresult;
    wire PCSrc;
	 
	 wire MemWrite;
    wire [11:2] MemAddr;


	 wire MemtoReg;
	 
    wire [31:0] MemOut;
	 
	 wire [15:0] EXTIn;
    wire [1:0] EXTOp;
    wire [31:0] EXTOut;
	 
	 wire [5:0] func;
    wire [5:0] Op;
	 
	 wire ALUSrc;

	 wire lb_Enable;
	 wire lh_Enable;
	 wire lbu_Enable;
 

	 
	 IFU IFU(.clk(clk),.reset(reset),.PCSrc(PCSrc),.j(j),.jr(jr),.instr(instr),.PC(PC),.PC_next(PC_next),.RData1(RData1));
	 GRF GRF(.clk(clk),.reset(reset),.RegWrite(RegWrite),.MemOut(MemOut),.RegDst(RegDst),.jal(jal),.rt(instr[20:16]),.rd(instr[15:11]),.rs(instr[25:21]),.PC_next(PC_next),.PC(PC),.RData1(RData1),.RData2(RData2));
	 ALU ALU(.RData1(RData1),.RData2(RData2),.ALUOp(ALUOp),.Branch(Branch),.BOp(BOp),.ALUSrc(ALUSrc),.EXTOut(EXTOut),.ALUresult(ALUresult),.PCSrc(PCSrc));
	 EXT EXT(.EXTIn(instr[15:0]),.EXTOp(EXTOp),.EXTOut(EXTOut));
	 DM DM(.clk(clk),.reset(reset),.MemWrite(MemWrite),.MemAddr(ALUresult[11:2]),.addr(ALUresult),.MemData(RData2),.PC(PC),.ALUresult(ALUresult),.MemtoReg(MemtoReg),.lh_Enable(lh_Enable),.lb_Enable(lb_Enable),.lbu_Enable(lbu_Enable),.MemOut(MemOut));
	 Controller Controller(.func(instr[5:0]),.Op(instr[31:26]),.EXTOp(EXTOp),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.Branch(Branch),.ALUOp(ALUOp),.ALUSrc(ALUSrc),.RegDst(RegDst),.RegWrite(RegWrite),.j(j),.jal(jal),.jr(jr),.BOp(BOp),.lb_Enable(lb_Enable),.lh_Enable(lh_Enable),.lbu_Enable(lbu_Enable));

endmodule
