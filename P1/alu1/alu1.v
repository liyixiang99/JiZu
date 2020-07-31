`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:18:06 11/08/2018 
// Design Name: 
// Module Name:    alu1 
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
module alu1(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output [31:0] C
    );
		assign C = (ALUOp==0)?(A+B):
					  (ALUOp==1)?(A-B):
					  (ALUOp==2)?(A&B):
					  (ALUOp==3)?(A|B):
					  (ALUOp==4)?(A^B):
					  (ALUOp==5)?($signed($signed(A)<<B)):
					  (ALUOp==6)?($signed($signed(A)>>B)):
					  (ALUOp==7)?($signed($signed(A)>>>B)):
					  (ALUOp==8)?((A>B)?1:0):
					  (ALUOp==9)?(($signed(A)>$signed(B))?1:0):000;
endmodule
