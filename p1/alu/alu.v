`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:10 10/21/2021 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input [31:0] A,
	input [31:0] B,
	input [2:0] ALUOp,
	output [31:0] C
    );
	
	assign C=(ALUOp==0)?$signed(A+B):
				(ALUOp==1)?$signed(A-B):
				(ALUOp==2)?$signed(A&B):
				(ALUOp==3)?$signed(A|B):
				(ALUOp==4)?$signed(A>>B):$signed(A)>>>B;
	
endmodule
