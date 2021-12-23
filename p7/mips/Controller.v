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
	output reg [2:0] ALUSrc,
	output reg [4:0] ALUCtrl,
	output reg [2:0] NPCSel,
	output reg [2:0] ExtOp,
	output reg [2:0] tnew,
	output reg [2:0] tuseRs,
	output reg [2:0] tuseRt,
	output reg [4:0] A3,
	output reg [2:0] CmpSel,
	output reg [2:0] storeOp,
	output reg [2:0] loadOp,
	output reg [2:0] MDop,
	output reg start,
	output reg useMD,
	output reg CPwe,
	output eret,
	output RI,
	output BD
    );
	
	wire[4:0] rt,rd;
	wire[5:0] opcode,funct;
	reg [2:0] RegDst;
	
	assign opcode=instr[31:26];
	assign funct=instr[5:0];
	assign rt=instr[20:16];
	assign rd=instr[15:11];
	//-----------------------calc_r--------------------------
	assign add =(opcode==0&&funct==6'b100000);
	assign addu=(opcode==0&&funct==6'b100001);
	assign sub =(opcode==0&&funct==6'b100010);
	assign subu=(opcode==0&&funct==6'b100011);
	assign slt =(opcode==0&&funct==6'b101010);
	assign sltu=(opcode==0&&funct==6'b101011);
	assign and_=(opcode==0&&funct==6'b100100);
	assign or_ =(opcode==0&&funct==6'b100101);
	assign nor_=(opcode==0&&funct==6'b100111);
	assign xor_=(opcode==0&&funct==6'b100110);
	assign calc_r=add|addu|sub|subu|slt|sltu|and_|or_|nor_|xor_;
	//-----------------------calc_i--------------------------
	assign addi =(opcode==6'b001000);
	assign addiu=(opcode==6'b001001);
	assign slti =(opcode==6'b001010);
	assign sltiu=(opcode==6'b001011);
	assign andi =(opcode==6'b001100);
	assign ori  =(opcode==6'b001101);
	assign xori =(opcode==6'b001110);
	assign calc_i=addi|addiu|slti|sltiu|andi|ori|xori;
	//-----------------------b_r-----------------------------
	assign beq =(opcode==6'b000100);
	assign bne =(opcode==6'b000101);
	assign b_r=beq|bne;
	//-----------------------b_z-----------------------------
	assign bgez=(opcode==6'b000001&&rt==5'b00001);
	assign bgtz=(opcode==6'b000111);
	assign blez=(opcode==6'b000110);
	assign bltz=(opcode==6'b000001&&rt==5'b00000);
	assign b_z=bgez|bgtz|blez|bltz;
	//-----------------------store---------------------------
	assign sw=(opcode==6'b101011);
	assign sh=(opcode==6'b101001);
	assign sb=(opcode==6'b101000);
	assign store=sw|sh|sb;
	//-----------------------load----------------------------
	assign lw =(opcode==6'b100011);
	assign lh =(opcode==6'b100001);
	assign lhu=(opcode==6'b100101);
	assign lb =(opcode==6'b100000);
	assign lbu=(opcode==6'b100100);
	assign load=lw|lh|lhu|lb|lbu;
	//-----------------------mf------------------------------
	assign mfhi=(opcode==0&&funct==6'b010000);
	assign mflo=(opcode==0&&funct==6'b010010);
	assign mf=mfhi|mflo;
	//-----------------------mt------------------------------
	assign mthi=(opcode==0&&funct==6'b010001);
	assign mtlo=(opcode==0&&funct==6'b010011);
	assign mt=mthi|mtlo;
	//-----------------------md------------------------------
	assign mult =(opcode==0&&funct==6'b011000);
	assign multu=(opcode==0&&funct==6'b011001);
	assign div  =(opcode==0&&funct==6'b011010);
	assign divu =(opcode==0&&funct==6'b011011);
	assign md=mult|multu|div|divu;
	//-----------------------shift_i-------------------------
	assign sll  =(opcode==0&&funct==0&&instr);
	assign srl  =(opcode==0&&funct==6'b000010);
	assign sra  =(opcode==0&&funct==6'b000011);
	assign shift_i=sll|srl|sra;
	//-----------------------shift_r-------------------------
	assign sllv=(opcode==0&&funct==6'b000100);
	assign srlv=(opcode==0&&funct==6'b000110);
	assign srav=(opcode==0&&funct==6'b000111);
	assign shift_r=sllv|srlv|srav;
	//-----------------------jump----------------------------
	assign j   =(opcode==6'b000010);
	assign jr  =(opcode==0&&funct==6'b001000);
	assign jal =(opcode==6'b000011);
	assign jalr=(opcode==0&&funct==6'b001001);
	assign jump=j|jr|jal|jalr;
	//-----------------------lui-----------------------------
	assign lui=(opcode==6'b001111);
	//-----------------------CP0-----------------------------
	assign mfc0=(opcode==6'b010000&&instr[25:21]==0);
	assign mtc0=(opcode==6'b010000&&instr[25:21]==5'b00100);
	assign eret=(opcode===6'b010000&&funct===6'b011000);
	assign CP0=mfc0|mtc0|eret;
	//-------------------------------------------------------
	
	assign RI=(calc_r|calc_i|b_r|b_z|store|load|mf|mt|md|
					 shift_i|shift_r|jump|lui|CP0|!instr)===0;
	assign BD=(b_r===1)|(b_z===1)|(jump===1);
				 
	always@(*)begin	

		RegDst=0;	RegSrc=0;	RegWrite=0;	CmpSel=0;
		ALUSrc=0;	ALUCtrl=0;	NPCSel=0;	ExtOp=0;		
		start=0;		MDop=0;		tuseRs=3;	tuseRt=3;	
		tnew=0;		storeOp=0;	loadOp=0;	CPwe=0;
		useMD=0;	
		
		if(calc_r)begin
			RegDst=1;
			RegWrite=1;
			tuseRs=1;	
			tuseRt=1;	
			tnew=1;
			//ALUCtrl
			if(add)  ALUCtrl=14;
			if(addu) ALUCtrl=2;
			if(sub)  ALUCtrl=15;
			if(subu) ALUCtrl=3;
			if(slt)  ALUCtrl=12;
			if(sltu) ALUCtrl=13;
			if(and_) ALUCtrl=0;
			if(or_)  ALUCtrl=1;
			if(nor_) ALUCtrl=4;
			if(xor_) ALUCtrl=5;
		end
		
		if(calc_i)begin
			RegWrite=1;
			ALUSrc=1;
			tuseRs=1;
			tnew=1;
			//ALUCtrl ExtOp
			if(addi)  ALUCtrl=14;
			if(addiu) ALUCtrl=2;
			if(slti)  ALUCtrl=12;
			if(sltiu) ALUCtrl=13;
			if(andi)  ALUCtrl=0;
			if(ori)   ALUCtrl=1;
			if(xori)  ALUCtrl=5;
			if(andi|ori|xori) ExtOp=1;
		end
		
		if(b_r)begin
			tuseRs=0;
			tuseRt=0;
			// if (Cmp) NPCSel = x
			if(beq&&Cmp==0) NPCSel=1;
			if(bne&&Cmp!=0) NPCSel=1;
		end
		
		if(b_z)begin
			tuseRs=0;
			CmpSel=1;
			// if (Cmp) NPCSel = x
			if(bgez&&(Cmp==1||Cmp==0)) NPCSel=1;
			if(bgtz&&Cmp==1) NPCSel=1;
			if(blez&&(Cmp==2||Cmp==0)) NPCSel=1;
			if(bltz&&Cmp==2) NPCSel=1;
		end
		
		if(store)begin
			ALUSrc=1;
			ALUCtrl=14;
			tuseRs=1;
			tuseRt=2;
			//storeOp
			if(sb) storeOp=1;
			if(sh) storeOp=2;
			if(sw) storeOp=3;
		end
		
		if(load)begin
			RegSrc=1;  
			RegWrite=1;
			ALUSrc=1;
			ALUCtrl=14;
			tuseRs=1;
			tnew=2;
			//loadOp 
			if(lw)  loadOp=0;
			if(lbu) loadOp=1;
			if(lb)  loadOp=2;
			if(lhu) loadOp=3;
			if(lh)  loadOp=4;
		end
		
		if(mf)begin
			RegDst=1;	
			RegWrite=1;						
			tnew=1;
			useMD=1;
			//RegSrc	
			if(mfhi) RegSrc=4;
			if(mflo) RegSrc=5;
		end
		
		if(mt)begin
			tuseRs=1;
			useMD=1;
			//MDop	
			if(mthi) MDop=4;
			if(mtlo) MDop=5;
		end
		
		if(md)begin
			tuseRs=1;
			tuseRt=1;
			start=1;
			useMD=1;
			//MDop
			if(mult)  MDop=0;
			if(multu) MDop=1;
			if(div)   MDop=2;
			if(divu)  MDop=3;
		end
		
		if(shift_i)begin
			RegDst=1;
			RegWrite=1;
			tuseRt=1;		
			tnew=1;
			//ALUCtrl
			if(sll) ALUCtrl=6;
			if(srl) ALUCtrl=8;
			if(sra) ALUCtrl=10;
		end
		
		if(shift_r)begin
			RegDst=1;
			RegWrite=1;
			tuseRt=1;	
			tuseRs=1;
			tnew=1;
			//ALUCtrl
			if(sllv) ALUCtrl=7;
			if(srlv) ALUCtrl=9;
			if(srav) ALUCtrl=11;
		end
		
		if(j)begin
			NPCSel=2;
		end
		
		if(jal)begin
			RegDst=2;
			RegSrc=3;
			RegWrite=1;
			NPCSel=2;
		end
		
		if(jr)begin
			NPCSel=3;
			tuseRs=0;
		end
		
		if(jalr)begin
			NPCSel=3;
			tuseRs=0;
			RegDst=1;
			RegSrc=3;
			RegWrite=1;
		end
		
		if(lui)begin
			RegSrc=2;
			RegWrite=1;
		end
		
		if(mfc0)begin
			RegDst=0;	
			RegWrite=1;						
			tnew=2;
			RegSrc=6;
		end
		
		if(mtc0)begin
			tuseRt=2;
			CPwe=1;
		end
		
		A3=(RegWrite==0)?0:
			(RegDst==0)?rt:
			(RegDst==1)?rd:
			(RegDst==2)?31:0;
		
	end

	
endmodule
