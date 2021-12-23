`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:46 10/22/2021 
// Design Name: 
// Module Name:    ext 
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
module ext(
	input [15:0] imm,
	input [1:0] EOp,
	output [31:0] ext
    );
	assign ext=(EOp==0)?{{16{imm[15]}},imm}:
				  (EOp==1)?{{16{0}},imm}:
				  (EOp==2)?{imm,{16{0}}}:{{14{imm[15]}},imm,{2{0}}};

endmodule
