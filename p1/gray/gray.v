`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:15 10/21/2021 
// Design Name: 
// Module Name:    gray 
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
module gray(
	input Clk,
	input Reset,
	input En,
	output [2:0] Output,
	output reg Overflow 
    );
	 reg [2:0] status;
	 initial begin
		status=0;
		Overflow=0;
	 end
	 assign Output=status;
	always@(posedge Clk)begin
		if(Reset)begin
			status=0;
			Overflow=0;
		end
		else begin
			if(En)begin
				case(status)
					0:begin status=1; end
					1:begin status=3; end
					2:begin status=6; end
					3:begin status=2; end
					4:begin status=0; Overflow=1; end
					5:begin status=4; end
					6:begin status=7; end
					7:begin status=5; end
				endcase
			end
		end
	end
	
endmodule
