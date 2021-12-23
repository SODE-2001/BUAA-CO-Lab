`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:07 11/25/2021 
// Design Name: 
// Module Name:    Ext 
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
module Ext(
	input [31:0] instr,
	input [2:0] ExtOp,
	output reg [31:0] lui,
	output reg [31:0] imm32
    );
	always@(*)begin
		lui={instr[15:0],16'b0};
		imm32=(ExtOp==0)?{{16{instr[15]}},instr[15:0]}:
								{16'b0,instr[15:0]};
	end

endmodule
