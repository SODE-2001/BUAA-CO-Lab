`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:12 11/18/2021 
// Design Name: 
// Module Name:    M 
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
module M(
	input clk,
	input reset,
	input [31:0] rd2E,
	input [31:0] ALUOutE,
	input [31:0] instrE,
	input [31:0] luiE,
	input [31:0] PCE,
	output reg [31:0] rd2M,
	output reg [31:0] ALUOutM,
	output reg [31:0] instrM,
	output reg [31:0] luiM,
	output reg [31:0] PCM
    );
	
	always@(posedge clk)begin
		if(reset)begin
			rd2M<=0;
			ALUOutM<=0;
			instrM<=0;
			luiM<=0;
			PCM<=0;
		end
		else begin
			rd2M<=rd2E;
			ALUOutM<=ALUOutE;
			instrM<=instrE;
			luiM<=luiE;
			PCM<=PCE;
		end
	end

endmodule
