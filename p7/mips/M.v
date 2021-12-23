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
	input [31:0] HIE,
	input [31:0] LOE,
	input [4:0] ExcCodeE,
	input [2:0] Ov,
	input BDE, 
	input Req,
	output reg [31:0] rd2M,
	output reg [31:0] ALUOutM,
	output reg [31:0] instrM,
	output reg [31:0] luiM,
	output reg [31:0] PCM,
	output reg [31:0] HIM,
	output reg [31:0] LOM,
	output reg [4:0] ExcCodeM,
	output reg BDM
    );
	
	always@(posedge clk)begin
		if(reset|Req)begin
			rd2M<=0;
			ALUOutM<=0;
			instrM<=0;
			luiM<=0;
			PCM<=(Req) ? 32'h4180 : 0;
			HIM<=0;
			LOM<=0;
			ExcCodeM<=0;
			BDM<=0;
		end
		else begin
			rd2M<=rd2E;
			ALUOutM<=ALUOutE;
			luiM<=luiE;
			PCM<=PCE;
			HIM<=HIE;
			LOM<=LOE;
			BDM<=BDE;
			if(!ExcCodeE&&!Ov) instrM<=instrE;
			else instrM<=0;
			if(!ExcCodeE&&Ov)begin
				if(Ov==1) ExcCodeM<=12;
				if(Ov==2) ExcCodeM<=4;
				if(Ov==3) ExcCodeM<=5;
			end
			else ExcCodeM<=ExcCodeE;
		end
	end

endmodule
