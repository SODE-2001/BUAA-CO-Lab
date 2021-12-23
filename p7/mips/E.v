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
	input [4:0] ExcCodeD,
	input RI,
	input BDD,
	input Req,
	input stall,
	output reg [31:0] rd1E,
	output reg [31:0] rd2E,
	output reg [31:0] instrE,
	output reg [31:0] imm32E,
	output reg [31:0] PCE,
	output reg [31:0] luiE,
	output reg [4:0] ExcCodeE,
	output reg BDE
    );
	
	always@(posedge clk)begin
		if(reset|stall|Req)begin
			rd1E<=0;
			rd2E<=0;
			instrE<=0;
			imm32E<=0;
			PCE<=(Req)?32'h4180:( (stall) ? PCD : 0 );
			luiE<=0;
			ExcCodeE<=0;
			BDE<=(stall) ? BDD : 0;
		end
		else begin
			rd1E<=rd1D;
			rd2E<=rd2D;
			imm32E<=imm32D;
			PCE<=PCD;
			luiE<=luiD;
			BDE<=BDD;
			if(!ExcCodeD&&!RI) instrE<=instrD;
			else instrE<=0;
			if(!ExcCodeD&&RI) ExcCodeE<=10;
			else ExcCodeE<=ExcCodeD;
			/*
				if(!ExcCodeD&&RI) ExcCodeE<=10;
				else if(!ExcCodeD&&!RI&&tltiu) ExcCodeE<=13;
				else ExcCodeE<=ExcCodeD;
			*/
		end
	end

endmodule
