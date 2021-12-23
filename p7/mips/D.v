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
	input [4:0] ExcCodeF,
	input BDF,
	input Req,
	output reg [31:0] instrD,
	output reg [31:0] PCD,
	output reg [4:0] ExcCodeD,
	output reg BDD
    );
	 
	always@(posedge clk)begin
		if(reset|Req)begin
			instrD<=0;
			PCD<= Req ? 32'h4180 : 0;
			ExcCodeD<=0;
			BDD<=0;
		end
		else begin
			if(weD)begin
				if(!ExcCodeF) instrD<=instrF;
				else instrD<=0;
				PCD<=PCF;
				ExcCodeD<=ExcCodeF;
				BDD<=BDF;
			end
		end
	end

endmodule
