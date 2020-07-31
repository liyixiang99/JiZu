`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:45:33 07/18/2019 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
	 input clk,
	 input reset,
	 input PCSrc,
	 input j,
	 input jr,
	 input [31:0] RData1,
	 output[31:0] instr,
	 output[31:0] PC_next,
	 output reg [31:0] PC
    );
	 reg [31:0] ROM [1023:0];
	 integer i;
	 initial
	 begin
		PC = 32'h00003000;
		for(i=0;i<1024;i=i+1)
			ROM[i] = 0;
			$readmemh("code.txt",ROM);
	 end
	 assign instr = ROM[PC[11:2]];
	 assign PC_next = PC+4;
	 always @(posedge clk)
	 begin
		if(reset==1)
			PC <= 32'h00003000;
		else
		begin
			if(PCSrc==1&&j==0&&jr==0)
				PC <= PC+4+{{16{ROM[PC[11:2]][15]}},{ROM[PC[11:2]][15:0]}}*4;
			else if(PCSrc==0&&j==0&&jr==1)
				PC <= RData1;
			else if(PCSrc==0&&j==1&&jr==0)
				PC <= {PC[31:28],ROM[PC[11:2]][25:0],2'b00};
			else PC <= PC+4;
		end
	 end
endmodule