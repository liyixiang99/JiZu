`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:36:42 07/18/2019 
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
	 output [1:0] BOp,
	 output lb_Enable,
	 output lh_Enable,
	 output lbu_Enable
    );
	 reg [18:0] control = 0;
	 assign{EXTOp,MemtoReg,MemWrite,Branch,ALUOp,ALUSrc,RegDst,RegWrite,j,jal,jr,BOp,lb_Enable,lh_Enable,lbu_Enable}=control;
	 always @(*)
	 begin
		 case(Op)
			6'b000000:
			begin
				case(func)
					6'b000000:	control<=19'b 0000000000000000000;//nop
					6'b100001:	control<=19'b 0000001001100000000;//addu
					6'b100011:	control<=19'b 0000001101100000000;//subu
					6'b001000:	control<=19'b 0000000000000100000;//jr
					default:	control<=19'b 0000000000000000000;
				endcase
			end
			6'b001101:	control<=19'b 0000000110100000000;//ori
			6'b100011:	control<=19'b 0110001010100000000;//lw
			6'b101011:	control<=19'b 0101001010000000000;//sw
			6'b000100:	control<=19'b 0100100000000000000;//beq
			6'b001111:	control<=19'b 1000010010100000000;//lui
			6'b000011:	control<=19'b 0000000000111000000;//jal
			6'b000010:	control<=19'b 0000000000010000000;//j
			6'b000101:  control<=19'b 0100100000000010000;//bne
			6'b000110:  control<=19'b 0100100000000001000;//blez
			6'b100000:  control<=19'b 0100001010100000100;//lb
			6'b100001:  control<=19'b 0100001010100000010;//lh
			6'b100100:  control<=19'b 0100001010100000001;//lbu
			default:	control<=19'b0000000000000000000;
		 endcase
	 end
endmodule
