`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:11 11/11/2021 
// Design Name: 
// Module Name:    DM 
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
module DM(
	input clk,
	input reset,
	input MemWrite,
	input [31:0] Addr,
	input [31:0] WD,
	input [31:0] PC,
	output [31:0] RD
    );
	
	reg [31:0] dm[3072:0];
	integer i;
	
	always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=3072;i=i+1)begin
				dm[i]<=0;
			end
		end
		else begin 
			if(MemWrite)begin
				$display("%d@%h: *%h <= %h", $time, PC, Addr,WD);
				dm[Addr[31:2]]<=WD;
			end
		end
	end
	
	assign RD=dm[Addr[31:2]];
	
endmodule
