`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:07:49 11/25/2021 
// Design Name: 
// Module Name:    Compare 
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
module Compare(
	input [31:0] SrcA,
	input [31:0] SrcB,
	input [2:0] CmpSel,
	output reg [2:0] CmpOut
    );
	always@(*)begin
		if(CmpSel==0)begin
			CmpOut=(SrcA==SrcB)?0:
					 ($signed(SrcA)>$signed(SrcB))?1:2;
		end
		else begin
			CmpOut=(SrcA==0)?0:
					 ($signed(SrcA)>0)?1:2;
		end
	end

endmodule
