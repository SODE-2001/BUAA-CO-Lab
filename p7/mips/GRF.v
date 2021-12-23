`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:27 11/11/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	input clk,
	input we,
	input reset,
	input [31:0] instr,
	input [4:0] A3,
	input [31:0] WD,
	input [31:0] PC,
	output [31:0] RD1,
	output [31:0] RD2	
    );
	reg [31:0] grf[31:0];
	wire [4:0] A1,A2;
	integer i;
	
	always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<32;i=i+1)begin
				grf[i]<=0;
			end
		end
		else begin
			if(we&&A3)begin
				grf[A3]<=WD;
			end
		end
	end
	
	assign A1=instr[25:21];
	assign A2=instr[20:16];
	
	assign RD1=(we&&A3&&A1==A3)?WD:grf[A1];
	assign RD2=(we&&A3&&A2==A3)?WD:grf[A2];

endmodule
