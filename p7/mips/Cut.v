`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:18:25 11/18/2021 
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
	input [31:0] instr,
	output [5:0] opcode,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] rd,
	output [5:0] funct,
	output [15:0] imm16,
	output [25:0] imm26,
	output [4:0] shift
    );
	
	assign opcode=instr[31:26];
	assign rs=instr[25:21];
	assign rt=instr[20:16];
	assign rd=instr[15:11];
	assign funct=instr[5:0];
	assign imm16=instr[15:0];
	assign imm26=instr[25:0];
	assign shift=instr[10:6];
	
endmodule
