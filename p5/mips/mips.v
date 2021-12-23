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
	//-----------------F-----------------------
	wire [31:0] instrF;
	wire [31:0] PCF;
	//-----------------D-----------------------
	wire weD,freezePC;
	wire [2:0] Cmp,CmpSel,ExtOp,NPCSel,tuseRsD,tuseRtD,rsDfwd,rtDfwd;
	wire [4:0] A3D;
	wire [31:0] rd1D,rd2D,rd1Draw,rd2Draw,PCD,luiD,imm32D,instrD; 
	//-----------------E-----------------------
	wire clrE;
	wire [2:0] rsEfwd,rtEfwd,ALUSrc,ALUCtrl,RegSrcE,tnewE;
	wire [4:0] A3E;
	wire [31:0] rd1E,rd2E,rd1Eraw,rd2Eraw;
	wire [31:0] instrE,imm32E,PCE,luiE,SrcB,ALUOutE,RegDataE;
	//-----------------M-----------------------
	wire MemWriteM;
	wire [2:0] rtMfwd,RegSrcM,tnewM;
	wire [4:0] A3M;
	wire [31:0] rd2M,luiM,PCM,rd2Mraw,MemRdM,instrM,ALUOutM,RegDataM;
	//-----------------W-----------------------
	wire RegWriteW;
	wire [2:0] RegSrcW;
	wire [4:0] A3W;
	wire [31:0] PCW,luiW,ALUOutW,MemRdW,instrW,RegDataW;
	//-----------------------------------------
	
	IFU IFU(
		.NPCop(NPCSel),	.instr(instrF),
		.clk(clk),			.PC(PCF),
		.reset(reset),
		.branch(imm32D),	
		.jump(instrD[25:0]),		
		.jr(rd1D),
		.freezePC(freezePC)
	);
	
	D D(
		.clk(clk),			.instrD(instrD),
		.reset(reset),		.PCD(PCD),
		.weD(weD),
		.instrF(instrF),
		.PCF(PCF)
	);
	
	Controller CtrlD(
		.Cmp(Cmp),				.NPCSel(NPCSel),
		.instr(instrD),		.ExtOp(ExtOp),
									.tuseRs(tuseRsD),
									.tuseRt(tuseRtD),
									.A3(A3D),
									.CmpSel(CmpSel)
	);
	
	GRF GRF(
		.clk(clk),				.RD1(rd1Draw),
		.we(RegWriteW),		.RD2(rd2Draw),
		.reset(reset),
		.instr(instrD),
		.A3(A3W),
		.WD(RegDataW),
		.PC(PCW)
	);
	
	MUX8 #(32) forward_rsD(
		.sel(rsDfwd),		.out(rd1D),
		.in0(rd1Draw),
		.in1(RegDataM),
		.in2(RegDataE)
	);
	
	MUX8 #(32) forward_rtD(
		.sel(rtDfwd),		.out(rd2D),
		.in0(rd2Draw),
		.in1(RegDataM),
		.in2(RegDataE)
	);
	
	Compare Compare(
		.SrcA(rd1D),			.CmpOut(Cmp),
		.SrcB(rd2D),
		.CmpSel(CmpSel)
	);
				  
	Ext Ext(
		.instr(instrD),		.lui(luiD),
		.ExtOp(ExtOp),			.imm32(imm32D)
	);
	
	E E(
		.clk(clk),				.rd1E(rd1Eraw),
		.reset(reset|clrE),	.rd2E(rd2Eraw),
		.rd1D(rd1D),			.instrE(instrE),
		.rd2D(rd2D),			.imm32E(imm32E),
		.instrD(instrD),		.PCE(PCE),
		.imm32D(imm32D),		.luiE(luiE),
		.PCD(PCD),			
		.luiD(luiD)
	);
	
	MUX8 #(32) M_RegDataE(
		.sel(RegSrcE),		.out(RegDataE),
		.in2(luiE),
		.in3(PCE+8)
	);
	
	Controller CtrlE(
									.ALUSrc(ALUSrc),
									.ALUCtrl(ALUCtrl),
		.instr(instrE),		.RegSrc(RegSrcE),
									.tnew(tnewE),
									.A3(A3E)
	);

	MUX8 #(32) forward_rsE(
		.sel(rsEfwd),		.out(rd1E),
		.in0(rd1Eraw),
		.in1(RegDataW),
		.in2(RegDataM)
	);
	
	MUX8 #(32) forward_rtE(
		.sel(rtEfwd),		.out(rd2E),
		.in0(rd2Eraw),
		.in1(RegDataW),
		.in2(RegDataM)
	);
	
	MUX8 #(32) M_SrcB(
		.sel(ALUSrc),		.out(SrcB),
		.in0(rd2E),
		.in1(imm32E),
		.in2(32'b0)
	);
	
	ALU ALU(
		.ALUCtrl(ALUCtrl),	.ALUOut(ALUOutE),
		.instr(instrE),
		.SrcA(rd1E),
		.SrcB(SrcB)
	);
	
	M M(
		.clk(clk),						.rd2M(rd2Mraw),
		.reset(reset),					.ALUOutM(ALUOutM),
		.instrE(instrE),				.instrM(instrM),
		.rd2E(rd2E),					.luiM(luiM),
		.ALUOutE(ALUOutE),			.PCM(PCM),
		.luiE(luiE),
		.PCE(PCE)
		
	);
	
	MUX8 #(32) M_RegDataM(
		.sel(RegSrcM),		.out(RegDataM),
		.in0(ALUOutM),
		.in2(luiM),
		.in3(PCM+8)
	);
	
	Controller CtrlM(
									.MemWrite(MemWriteM),		
		.instr(instrM),		.RegSrc(RegSrcM),
									.tnew(tnewM),
									.A3(A3M)
	);
	
	MUX8 #(32) forward_rtM(
		.sel(rtMfwd),		.out(rd2M),
		.in0(rd2Mraw),
		.in1(RegDataW)
	);
	
	DM DM(
		.clk(clk),				.RD(MemRdM),
		.reset(reset),
		.MemWrite(MemWriteM),
		.Addr(ALUOutM),
		.WD(rd2M),
		.PC(PCM)
	);
	
	W W(
		.clk(clk),						.MemRdW(MemRdW),
		.reset(reset),					.ALUOutW(ALUOutW),
		.luiM(luiM),					.instrW(instrW),
		.MemRdM(MemRdM),				.luiW(luiW),
		.ALUOutM(ALUOutM),			.PCW(PCW),
		.instrM(instrM),				
		.PCM(PCM)
	);
	
	MUX8 #(32) M_RegDataW(
		.sel(RegSrcW),		.out(RegDataW),
		.in0(ALUOutW),
		.in1(MemRdW),
		.in2(luiW),
		.in3(PCW+8)
	);
	
	Controller CtrlW(
									.RegSrc(RegSrcW),
		.instr(instrW),		.RegWrite(RegWriteW),
									.A3(A3W)
	);
					 
	Crush Crush(
		.tuseRsD(tuseRsD),	.weD(weD),
		.tuseRtD(tuseRtD),	.clrE(clrE),
		.tnewE(tnewE),			.freezePC(freezePC),
		.tnewM(tnewM),			.rsDfwd(rsDfwd),
		.A3E(A3E),				.rtDfwd(rtDfwd),
		.A3M(A3M),				.rsEfwd(rsEfwd),
		.A3W(A3W),				.rtEfwd(rtEfwd),
		.instrD(instrD),		.rtMfwd(rtMfwd),		
		.instrE(instrE),
		.instrM(instrM)
	);
		
endmodule
