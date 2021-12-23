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
	input [5:0] opcode,
	input [5:0] funct,
	input [1:0] Cmp,
	output reg [1:0] RegDst,
	output reg [1:0] RegData,
	output reg RegWrite,
	output reg MemWrite,
	output reg [1:0] ALUSrc,
	output reg [2:0] ALUCtrl,
	output reg [1:0] NPCSel,
	output reg ExtOp,
	output reg [1:0] stride,
	output reg [1:0] tnew,
	output reg [1:0] tuse
    );
	
	reg [31:0] instr;
	
	parameter ori=1;
	parameter lw=2;
	parameter sw=3;
	parameter beq=4;
	parameter lui=5;
	parameter j=6;
	parameter jal=7;
	parameter addiu=8;
	parameter sb=9;
	parameter lb=10;
	parameter sh=11;
	parameter lh=12;
	parameter addu=13;
	parameter subu=14;
	parameter or_=15;
	parameter jr=16;
	parameter sll=17;
	parameter bgtz=18;
	
	always@(*)begin
		if(opcode)begin
			if(opcode==32'b001101)begin
				instr=ori;
			end
			if(opcode==32'b100011)begin
				instr=lw;
			end
			if(opcode==32'b101011)begin
				instr=sw;
			end
			if(opcode==32'b000100)begin
				instr=beq;
			end
			if(opcode==32'b001111)begin
				instr=lui;
			end
			if(opcode==32'b000010)begin
				instr=j;
			end
			if(opcode==32'b000011)begin
				instr=jal;
			end
			if(opcode==32'b001001)begin
				instr=addiu;
			end
			if(opcode==32'b101000)begin
				instr=sb;
			end
			if(opcode==32'b100000)begin
				instr=lb;
			end
			if(opcode==32'b101001)begin
				instr=sh;
			end
			if(opcode==32'b100001)begin
				instr=lh;
			end
			if(opcode==32'b000111)begin
				instr=bgtz;
			end
		end
		else begin
			if(funct==32'b100001)begin
				instr=addu;
			end
			if(funct==32'b100011)begin
				instr=subu;
			end
			if(funct==32'b100101)begin
				instr=or_;
			end
			if(funct==32'b001000)begin
				instr=jr;
			end
			if(funct==32'b000000)begin
				instr=sll;
			end
		end
	end
	
	always@(*)begin
		RegDst=0;
		RegData=0;
		RegWrite=0;
		MemWrite=0;
		ALUSrc=0;
		ALUCtrl=0;
		NPCSel=0;
		ExtOp=0;
		stride=0;
		case(instr)
			addu:begin
				RegDst=1;
				RegWrite=1;
				ALUCtrl=2;
			end
			subu:begin
				RegDst=1;
				RegWrite=1;
				ALUCtrl=6;
			end
			or_:begin
				RegDst=1;
				RegWrite=1;
				ALUCtrl=1;
			end
			jr:begin
				NPCSel=3;
			end
			sll:begin
				RegDst=1;
				RegWrite=1;
				ALUCtrl=3;
			end
			ori:begin
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=1;
				ExtOp=1;
			end
			lw:begin
				RegData=1;
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				stride=2;
			end
			sw:begin
				MemWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				stride=2;
			end
			beq:begin
				ALUCtrl=6;
				if(Cmp==0)begin
					NPCSel=1;
				end
			end
			lui:begin
				RegData=2;
				RegWrite=1;
			end
			j:begin
				NPCSel=2;
			end
			jal:begin
				RegDst=2;
				RegData=3;
				RegWrite=1;
				NPCSel=2;
			end
			addiu:begin
				ALUSrc=1;
				ALUCtrl=2;
			end
			sb:begin
				MemWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
			end
			lb:begin
				RegData=1;
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
			end
			sh:begin
				MemWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				stride=1;
			end
			lh:begin
				RegData=1;
				RegWrite=1;
				ALUSrc=1;
				ALUCtrl=2;
				stride=1;
			end
			bgtz:begin
				ALUCtrl=6;
				ALUSrc=2;
				if(Cmp==1)begin
					NPCSel=1;
				end
			end
		endcase
	end
	
endmodule
