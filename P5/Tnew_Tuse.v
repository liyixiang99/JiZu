`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:59 07/24/2019 
// Design Name: 
// Module Name:    Tnew_Tuse 
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
module Tnew_Tuse(
		input [31:0] IR,
		input [31:0] DM_W,
		output reg [1:0] Tnew_E,
		output reg Tnew_M,
		output reg Tnew_W,
		output reg Tuse_rs,
		output reg [1:0] Tuse_rt,
		output reg rs_use_D,
		output reg rt_use_D,
		output reg [4:0] WAddr,
		output reg RegWrite
    );
	 wire [5:0] Op;
	 wire [5:0] func;
	 wire [5:0] rd;
	 wire [5:0] rt;
	 assign Op = IR[31:26];
	 assign func = IR[5:0];
	 assign rd = IR[15:11];
	 assign rt = IR[20:16];
	 always @(*)
	 begin
		 case(Op)
			6'b000000:
			begin
				case(func)
					6'b000000://nop
					begin
						Tnew_E<=0;
						Tnew_M<=0;
						Tnew_W<=0;
						Tuse_rs<=0;
						Tuse_rt<=0;
						rs_use_D<=0;
						rt_use_D<=0;
						WAddr<=5'b00000;
						RegWrite<=0;
					end
					6'b100001://addu
					begin
						Tnew_E<=1;
						Tnew_M<=0;
						Tnew_W<=0;
						Tuse_rs<=1;
						Tuse_rt<=1;
						rs_use_D<=1;
						rt_use_D<=1;
						WAddr<=rd;
						RegWrite<=1;
					end
					6'b100011://subu
					begin
						Tnew_E<=1;
						Tnew_M<=0;
						Tnew_W<=0;
						Tuse_rs<=1;
						Tuse_rt<=1;
						rs_use_D<=1;
						rt_use_D<=1;
						WAddr<=rd;
						RegWrite<=1;
					end
					6'b001000://jr
					begin
						Tnew_E<=0;
						Tnew_M<=0;
						Tnew_W<=0;
						Tuse_rs<=0;
						Tuse_rt<=0;
						rs_use_D<=1;
						rt_use_D<=0;
						WAddr<=5'b00000;
						RegWrite<=0;
					end
					default:	
					begin
						Tnew_E<=0;
						Tnew_M<=0;
						Tnew_W<=0;
						Tuse_rs<=0;
						Tuse_rt<=0;
						rs_use_D<=0;
						rt_use_D<=0;
						WAddr<=5'b00000;
						RegWrite<=0;
					end
				endcase
			end
			6'b001101://ori
			begin
				Tnew_E<=1;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=0;
				rs_use_D<=1;
			   rt_use_D<=0;
				WAddr<=rt;
				RegWrite<=1;
			end
			6'b100011://lw
			begin
				Tnew_E<=2;
				Tnew_M<=1;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=0;
				WAddr<=rt;
				RegWrite<=1;
			end
			6'b101011://sw
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=2;
				rs_use_D<=1;
				rt_use_D<=1;
				WAddr<=5'b00000;
				RegWrite<=0;
			end
			6'b000100://beq
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=1;
				WAddr<=5'b00000;
				RegWrite<=0;
			end
			6'b001111://lui
			begin
				Tnew_E<=1;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=0;
				rt_use_D<=0;
				WAddr<=rt;
				RegWrite<=1;
			end
			6'b000011://jal
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=0;
				rt_use_D<=0;
				WAddr<=5'b11111;
				RegWrite<=1;
			end
			6'b000010://j
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=0;
				rt_use_D<=0;
				WAddr<=5'b00000;
				RegWrite<=0;
			end
			6'b011001://lwpl
			begin
				Tnew_E<=2;
				Tnew_M<=1;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=2;
				rs_use_D<=1;
				rt_use_D<=0;
				WAddr<=(DM_W%4==0)?5'b11111:rt;
				RegWrite<=1;
			end
			6'b100010://lwl
			begin
				Tnew_E<=2;
				Tnew_M<=1;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=1;
				WAddr<=rt;
				RegWrite<=1;
			end
			6'b011000://blezals
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=0;
				WAddr<=5'b11111;
				RegWrite<=1;
			end
			6'b111111://blezalr
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=0;
				WAddr<=rd;
				RegWrite<=1;
			end
			6'b011100://clz
			begin
				Tnew_E<=1;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=1;
				Tuse_rt<=0;
				rs_use_D<=1;
				rt_use_D<=0;
				WAddr<=rd;
				RegWrite<=1;
			end
			default:
			begin
				Tnew_E<=0;
				Tnew_M<=0;
				Tnew_W<=0;
				Tuse_rs<=0;
				Tuse_rt<=0;
				rs_use_D<=0;
				rt_use_D<=0;
				WAddr<=5'b00000;
				RegWrite<=0;
			end
		 endcase
	 end
endmodule
