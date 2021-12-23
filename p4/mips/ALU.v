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
	input [4:0] shift,
	input [31:0] SrcA,
	input [31:0] SrcB,
	output [1:0] Cmp,
	output [31:0] ALUResult
    );
	 
	 wire [31:0] and_,or_,add,sub,sll;
	 
	assign and_=SrcA&SrcB;
	assign or_=SrcA|SrcB;
	assign add=SrcA+SrcB;
	assign sub=SrcA-SrcB; 
	assign sll=SrcB<<shift;
	
	assign ALUResult=(ALUCtrl==0)?and_:
						  (ALUCtrl==1)?or_:
						  (ALUCtrl==2)?add:
						  (ALUCtrl==3)?sll:sub;
	assign Cmp=(SrcA==SrcB)?0:
				  ($signed(SrcA)>$signed(SrcB))?1:2;
				  
endmodule
