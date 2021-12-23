`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:21 11/18/2021 
// Design Name: 
// Module Name:    W 
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
module W(
	input clk,
	input reset,
	input [31:0] MemRdM,
	input [31:0] ALUOutM,
	input [31:0] instrM,
	input [31:0] luiM,
	input [31:0] PCM,
	input [31:0] HIM,
	input [31:0] LOM,
	output reg [31:0] MemRdW,
	output reg [31:0] ALUOutW,
	output reg [31:0] instrW,
	output reg [31:0] luiW,
	output reg [31:0] PCW,
	output reg [31:0] HIW,
	output reg [31:0] LOW
    );
	
	always@(posedge clk)begin
		if(reset)begin
			MemRdW<=0;
			ALUOutW<=0;
			instrW<=0;
			luiW<=0;
			PCW<=0;
			HIW<=0;
			LOW<=0;
		end
		else begin
			MemRdW<=MemRdM;
			ALUOutW<=ALUOutM;
			instrW<=instrM;
			luiW<=luiM;
			PCW<=PCM;
			HIW<=HIM;
			LOW<=LOM;
		end
	end

endmodule
