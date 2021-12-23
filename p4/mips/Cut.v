`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:26 11/11/2021 
// Design Name: 
// Module Name:    Cut 
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
module Cut(
	input [31:0] Instr,
	output [5:0] opcode,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] rd,
	output [5:0] funct,
	output [15:0] imm,
	output [25:0] imm26,
	output [4:0] shift
    );
	
	assign opcode=Instr[31:26];
	assign rs=Instr[25:21];
	assign rt=Instr[20:16];
	assign rd=Instr[15:11];
	assign funct=Instr[5:0];
	assign imm=Instr[15:0];
	assign imm26=Instr[25:0];
	assign shift=Instr[10:6];
	
endmodule
