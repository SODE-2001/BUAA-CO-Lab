`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:31 11/11/2021 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	input [2:0] Cmp,
	input [31:0] instr,
	output reg [2:0] RegSrc,
	output reg RegWrite,
	output reg MemWrite,
	output reg [2:0] ALUSrc,
	output reg [2:0] ALUCtrl,
	output reg [2:0] NPCSel,
	output reg [2:0] ExtOp,
	output reg [2:0] tnew,
	output reg [2:0] tuseRs,
	output reg [2:0] tuseRt,
	output reg [4:0] A3,
	output reg [2:0] CmpSel
    );
	
	reg [4:0] rt,rd;
	reg [5:0] opcode,funct;
	reg [2:0] RegDst;
	
	always@(*)begin
	
		opcode=instr[31:26];
		funct=instr[5:0];
		rt=instr[20:16];
		rd=instr[15:11];		
		RegDst=0;
		RegSrc=0;
		RegWrite=0;
		MemWrite=0;
		ALUSrc=0;
		ALUCtrl=0;
		NPCSel=0;
		ExtOp=0;
		CmpSel=0;
		
		if(opcode)begin
			if(opcode==32'b001101)begin //ori
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=1;
				ExtOp=1;
				tuseRs=1;
				tuseRt=3;
				tnew=1;
			end
			if(opcode==32'b100011)begin //lw
				RegSrc=1;
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				tuseRs=1;
				tuseRt=3;
				tnew=2;
			end
			if(opcode==32'b101011)begin //sw
				MemWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				tuseRs=1;
				tuseRt=2;
				tnew=0;
			end
			if(opcode==32'b000100)begin //beq 
				ALUCtrl=6;
				tuseRs=0;
				tuseRt=0;
				tnew=0;
				if(Cmp==0)begin
					NPCSel=1;
				end
			end
			if(opcode==32'b001111)begin //lui
				RegSrc=2;
				RegWrite=1;
				tuseRs=3;
				tuseRt=3;
				tnew=0;
			end
			if(opcode==32'b000010)begin //j 
				NPCSel=2;
				tuseRs=3;
				tuseRt=3;
				tnew=0;
			end
			if(opcode==32'b000011)begin //jal
				RegDst=2;
				RegSrc=3;
				RegWrite=1;
				NPCSel=2;
				tuseRs=3;
				tuseRt=3;
				tnew=0;
			end
		end
		else begin
			if(funct==32'b100001)begin	//addu
				RegDst=1;
				RegWrite=1;
				ALUCtrl=2;
				tuseRs=1;
				tuseRt=1;
				tnew=1;
			end
			if(funct==32'b100011)begin //subu
				RegDst=1;
				RegWrite=1;
				ALUCtrl=6;
				tuseRs=1;
				tuseRt=1;
				tnew=1;
			end
			if(funct==32'b100101)begin //or
				RegDst=1;
				RegWrite=1;
				ALUCtrl=1;
				tuseRs=1;
				tuseRt=1;
				tnew=1;
			end
			if(funct==32'b001000)begin //jr
				NPCSel=3;
				tuseRs=0;
				tuseRt=3;
				tnew=0;
			end
		end
		
		A3=(RegWrite==0)?0:
			(RegDst==0)?rt:
			(RegDst==1)?rd:
			(RegDst==2)?31:0;
		
	end

	
endmodule
