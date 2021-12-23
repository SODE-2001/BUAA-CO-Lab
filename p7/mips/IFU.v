`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:14 11/11/2021 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
	input [2:0] NPCop,
	input clk,
	input reset,
	input [31:0] branch,
	input [25:0] jump,
	input [31:0] jr,
	input stall,
	input Req,
	input eretD,
	input [31:0] EPC,
	output [31:0] PC
    );

	reg [31:0] branchPC,jumpPC,tempPC;
	
	always@(*)begin
		branchPC=PC+(branch<<2);
		jumpPC={PC[31:28],jump,2'b00};
	end
	
	always@(posedge clk)begin
		if(reset)begin
			tempPC<=32'h3000; 
		end
		else begin
			tempPC<=(Req===1)?32'h4180:
					  (stall===1)?tempPC:
					  (NPCop==0)?PC+4:
					  (NPCop==1)?branchPC:
					  (NPCop==2)?jumpPC:jr;
		end
	end
	
	assign PC=(eretD===1)?EPC:tempPC;
	
endmodule
