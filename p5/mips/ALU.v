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
	input [2:0] ALUCtrl,
	input [31:0] instr,
	input [31:0] SrcA,
	input [31:0] SrcB,
	output reg [31:0] ALUOut
    );
	 
	reg [31:0] and_,or_,add,sub,sll;
	reg [4:0] shift;
	
	always@(*)begin
		shift=instr[10:6];
		
		and_=SrcA&SrcB;
		or_ =SrcA|SrcB;
		add =SrcA+SrcB;
		sub =SrcA-SrcB;
		sll =SrcA<<shift;
		
		ALUOut=(ALUCtrl==0)?and_:
				 (ALUCtrl==1)?or_:
				 (ALUCtrl==2)?add:
				 (ALUCtrl==3)?sll:sub;
	end
				  
endmodule
