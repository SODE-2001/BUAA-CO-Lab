`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:21 11/11/2021 
// Design Name: 
// Module Name:    mips 
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
/////////////////////////////////////////////////////////////////////////////////

module mips(
	input clk,
	input reset
    );
	
	wire [31:0] Instr,jal,RD1,RD2,ReadData,imm32,ALUResult,MUX2,MUX3,PC;
	wire [5:0] opcode,funct;
	wire [4:0] rs,rt,rd,shift,MUX1;
	wire [15:0] imm;
	wire [25:0] imm26;
	wire [2:0] ALUCtrl;
	wire [1:0] RegDst,RegData,ALUSrc,NPCSel,stride,Cmp;
	wire RegWrite,MemWrite,ExtOp;
	
	IFU IFU(
		.NPCop(NPCSel),	.clk(clk),		.reset(reset),
		.branch(imm32),	.jump(imm26),	.jr(RD1),
		.Instr(Instr),		.jal(jal),		.PC(PC)
	);
	
	Cut Cut(
		.Instr(Instr),	.opcode(opcode),	.rs(rs),
		.rt(rt),			.rd(rd),				.funct(funct),
		.imm(imm),		.imm26(imm26),		.shift(shift)
	);
	
	ALU ALU(
		.ALUCtrl(ALUCtrl),	.shift(shift),	.SrcA(RD1),
		.SrcB(MUX3),			.Cmp(Cmp),		.ALUResult(ALUResult)
	);
	
	GRF GRF(
		.clk(clk),	.we(RegWrite),	.reset(reset),
		.A1(rs),		.A2(rt),			.A3(MUX1),
		.WD(MUX2),	.PC(PC),			.RD1(RD1),		
		.RD2(RD2)
	);
	
	DM DM(
		.clk(clk),			.reset(reset),			.MemWrite(MemWrite),
		.stride(stride),	.Addr(ALUResult),		.WD(RD2),
		.PC(PC),				.RD(ReadData)
	);
	
	Controller Controller(
		.opcode(opcode),		.funct(funct),			.Cmp(Cmp),
		.RegDst(RegDst),		.RegData(RegData),	.RegWrite(RegWrite),
		.MemWrite(MemWrite),	.ALUSrc(ALUSrc),		.ALUCtrl(ALUCtrl),
		.NPCSel(NPCSel),		.ExtOp(ExtOp),			.stride(stride)
	);
	
	assign MUX1=(RegDst==0)?rt:
					(RegDst==1)?rd:
					(RegDst==2)?31:0;
	
	assign MUX2=(RegData==0)?ALUResult:
					(RegData==1)?ReadData:
					(RegData==2)?{imm32[15:0],16'b0}:jal;
					
	assign MUX3=(ALUSrc==0)?RD2:
					(ALUSrc==1)?imm32:0;
	
	assign imm32=(ExtOp==0)?{{16{imm[15]}},imm[15:0]}:{16'b0,imm[15:0]};
	
endmodule
