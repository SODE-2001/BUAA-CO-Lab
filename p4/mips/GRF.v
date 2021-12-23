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
	input [4:0] A1,
	input [4:0] A2,
	input [4:0] A3,
	input [31:0] WD,
	input [31:0] PC,
	output [31:0] RD1,
	output [31:0] RD2	
    );
	reg [31:0] grf[31:0];
	integer i;
	
	always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<32;i=i+1)begin
				grf[i]<=0;
			end
		end
		else begin
			if(we&&A3)begin
				$display("@%h: $%d <= %h", PC, A3, WD);
				grf[A3]<=WD;
			end
		end
	end
	
	assign RD1=grf[A1];
	assign RD2=grf[A2];

endmodule
