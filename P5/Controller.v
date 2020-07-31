`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:45 07/23/2019 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] func,
    input [5:0] Op,
    output [1:0] EXTOp,
    output MemtoReg,
    output MemWrite,
    output Branch,
    output [2:0] ALUOp,
    output ALUSrc,
    output RegDst,
    output RegWrite,
    output j,
    output jal,
    output jr,
	 output lwpl,
	 output lwl,
	 output [1:0] BOp,
	 output blezals,
	 output blezalr
    );
	 reg [19:0] control = 0;
	 assign{EXTOp,MemtoReg,MemWrite,Branch,ALUOp,ALUSrc,RegDst,RegWrite,j,jal,jr,lwpl,lwl,BOp,blezals,blezalr}=control;
	 always @(*)
	 begin
		 case(Op)
			6'b000000:
			begin
				case(func)
					6'b000000:	control<=20'b 00000000000000000000;//nop
					6'b100001:	control<=20'b 00000010011000000000;//addu
					6'b100011:	control<=20'b 00000011011000000000;//subu
					6'b001000:	control<=20'b 00000000000001000000;//jr
					default:	control<=20'b 00000000000000000000;
				endcase
			end
			6'b001101:	control<=20'b 00000001101000000000;//ori
			6'b100011:	control<=20'b 01100010101000000000;//lw
			6'b101011:	control<=20'b 01010010100000000000;//sw
			6'b000100:	control<=20'b 01001000000000000000;//beq
			6'b001111:	control<=20'b 10000100101000000000;//lui
			6'b000011:	control<=20'b 00000000001110000000;//jal
			6'b000010:	control<=20'b 00000000000100000000;//j
			6'b011001:	control<=20'b 01100010101000100000;//lwpl
			6'b100010:	control<=20'b 01000010101000010000;//lwl
			6'b011000:	control<=20'b 01001000001000000110;//blezals
			6'b111111:	control<=20'b 00001000011000001001;//blezalr
			6'b011100:	control<=20'b 00000101011000000000;//clz
			default:	control<=20'b 00000000000000000000;
		 endcase
	 end


endmodule
