`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:10:07 07/22/2019 
// Design Name: 
// Module Name:    IF 
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
module IF(
	 input clk,
	 input reset,
	 input [31:0] NPC,
	 input IF_en,
	 input j_D,
	 input jr_D,
	 input PCSrc_D,
	 output [31:0] IM,
	 output [31:0] ADD4,
	 output [31:0] ADD8
    );
	 reg [31:0] PC;
	 reg [31:0] ROM [1023:0];
	 wire [31:0] PC_next;
	 integer i;
	 initial
	 begin
		PC = 32'h00003000;
		for(i=0;i<1024;i=i+1)
			ROM[i] = 0;
			$readmemh("code.txt",ROM);
	 end
	 assign IM = ROM[PC[11:2]];
	 assign ADD4 = PC+4;
	 assign ADD8 = PC+8;
	 assign PC_next = (j_D||jr_D||PCSrc_D)?NPC:PC+4;
	 always @(posedge clk)
	 begin
		if(reset==1)
			PC <= 32'h00003000;
		else
		begin
			if(IF_en==1)
				PC <= PC_next;				
		end
	 end
endmodule
