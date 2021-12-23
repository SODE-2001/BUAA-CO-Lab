`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:01 11/11/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [4:0] ALUCtrl,
	input [31:0] instr,
	input [31:0] SrcA,
	input [31:0] SrcB,
	output reg [31:0] ALUOut
    );
	
	always@(*)begin
		
		case(ALUCtrl)
			0:ALUOut=SrcA&SrcB;
			1:ALUOut=SrcA|SrcB;
			2:ALUOut=SrcA+SrcB;
			3:ALUOut=SrcA-SrcB;
			4:ALUOut=~(SrcA|SrcB);
			5:ALUOut=SrcA^SrcB;
			6:ALUOut=SrcB<<instr[10:6];
			7:ALUOut=SrcB<<SrcA[4:0];
			8:ALUOut=SrcB>>instr[10:6];
			9:ALUOut=SrcB>>SrcA[4:0];
			10:ALUOut=$signed(SrcB)>>>instr[10:6];
			11:ALUOut=$signed(SrcB)>>>SrcA[4:0];
			12:ALUOut=($signed(SrcA)<$signed(SrcB))?1:0;
			13:ALUOut=(SrcA<SrcB)?1:0;
		endcase
		
	end
				  
endmodule
