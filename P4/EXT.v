`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:32 07/18/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] EXTIn,
    input [1:0] EXTOp,
    output [31:0] EXTOut
    );
	 assign EXTOut = (EXTOp==0)?({{16'b0},EXTIn}):
						  (EXTOp==1)?({{16{EXTIn[15]}},EXTIn}):
						  (EXTOp==2)?({EXTIn,{16'b0}}):000;			
endmodule
