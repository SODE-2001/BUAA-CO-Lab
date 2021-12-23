`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:55 11/18/2021 
// Design Name: 
// Module Name:    D 
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
module D(
	input clk,
	input reset,
	input weD,
	input [31:0] instrF,
	input [31:0] PCF,
	output reg [31:0] instrD,
	output reg [31:0] PCD
    );
	 
	always@(posedge clk)begin
		if(reset)begin
			instrD<=0;
			PCD<=0;
		end
		else begin
			if(weD)begin
				instrD<=instrF;
				PCD<=PCF;
			end
		end
	end

endmodule
