`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:09 11/25/2021 
// Design Name: 
// Module Name:    MUX8 
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
module MUX8#(parameter width=32)(
	input [2:0] sel,
	input [width-1:0] in0,in1,in2,in3,in4,in5,in6,in7,
	output reg [width-1:0] out
    );

	always@(*)begin
		case(sel)
			0: out<=in0;
			1: out<=in1;
			2: out<=in2;
			3: out<=in3;
			4: out<=in4;
			5: out<=in5;
			6: out<=in6;
			7: out<=in7;
		endcase
	end

endmodule
