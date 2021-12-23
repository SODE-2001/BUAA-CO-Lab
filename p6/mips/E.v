`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:55 11/18/2021 
// Design Name: 
// Module Name:    E 
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
module E(
	input clk,
	input reset,
	input [31:0] rd1D,
	input [31:0] rd2D,
	input [31:0] instrD,
	input [31:0] imm32D,
	input [31:0] PCD,
	input [31:0] luiD,
	output reg [31:0] rd1E,
	output reg [31:0] rd2E,
	output reg [31:0] instrE,
	output reg [31:0] imm32E,
	output reg [31:0] PCE,
	output reg [31:0] luiE
    );
	
	always@(posedge clk)begin
		if(reset)begin
			rd1E<=0;
			rd2E<=0;
			instrE<=0;
			imm32E<=0;
			PCE<=0;
			luiE<=0;
		end
		else begin
			rd1E<=rd1D;
			rd2E<=rd2D;
			instrE<=instrD;
			imm32E<=imm32D;
			PCE<=PCD;
			luiE<=luiD;
		end
	end

endmodule
