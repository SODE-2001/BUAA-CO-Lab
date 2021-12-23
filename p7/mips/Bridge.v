`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:07:10 12/13/2021 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
	input [31:0] rdata_in,
	input [31:0] addr,
	input [3:0] byteen_in,
	input [31:0] TCOut1,
	input [31:0] TCOut2,
	output reg [3:0] byteen_out,
	output reg TCwe1,
	output reg TCwe2,
	output reg [31:0] PrRD
    );
	
	wire HitDM=(addr>=0&&addr<=32'h2fff);
	wire HitTC1=(addr>=32'h7f00&&addr<=32'h7f0b);
	wire HitTC2=(addr>=32'h7f10&&addr<=32'h7f1b);
	
	always@(*)begin
		byteen_out=(HitDM||(addr==32'h7F20))?byteen_in:0;
		TCwe1=(HitTC1&&byteen_in==4'b1111);
		TCwe2=(HitTC2&&byteen_in==4'b1111);
		
		PrRD=(HitDM)?rdata_in:
				(HitTC1)?TCOut1:
				(HitTC2)?TCOut2:0;
	end

endmodule
