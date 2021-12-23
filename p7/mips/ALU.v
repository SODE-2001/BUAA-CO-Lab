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
	output reg [31:0] ALUOut,
	output reg [2:0] Ov
    );
	
	reg [32:0] exOut;
	reg excDM,range;
	
	wire [5:0] opcode=instr[31:26];
	wire [5:0] funct=instr[5:0];
	
	assign add =(opcode==0&&funct==6'b100000);
	assign sub =(opcode==0&&funct==6'b100010);
	assign addi =(opcode==6'b001000);
	assign ariOv=add|sub|addi;
	
	assign sw=(opcode==6'b101011);
	assign sh=(opcode==6'b101001);
	assign sb=(opcode==6'b101000);
	assign lw =(opcode==6'b100011);
	assign lh =(opcode==6'b100001);
	assign lhu=(opcode==6'b100101);
	assign lb =(opcode==6'b100000);
	assign lbu=(opcode==6'b100100);
	assign DMOv=sw|sh|sb|lw|lh|lhu|lb|lbu;
	
	always@(*)begin
		Ov=0;
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
			14:begin
				exOut={SrcA[31],SrcA}+{SrcB[31],SrcB};
				ALUOut=exOut;
				if(ariOv)begin
					Ov=(exOut[32]!=exOut[31])?1:0;
				end
				if(DMOv)begin
					excDM=0;
					if(exOut[32]!=exOut[31]) excDM=1;
					if((lw|sw)&&exOut[1:0]) excDM=1;
					if((lh|lhu|sh)&&exOut[0]) excDM=1;
					if(lh|lhu|lb|lbu|sh|sb)begin
						if(exOut>=32'h7f00&&exOut<=32'h7f0b) excDM=1;
						if(exOut>=32'h7f10&&exOut<=32'h7f1b) excDM=1;
					end
					range=(exOut>=0&&exOut<=32'h2fff)||
							(exOut>=32'h7f00&&exOut<=32'h7f0b)||
							(exOut>=32'h7f10&&exOut<=32'h7f1b);
					if(!range) excDM=1;
					if(sw|sh|sb)begin
						if(exOut>=32'h7f08&&exOut<=32'h7f0b) excDM=1;
						if(exOut>=32'h7f18&&exOut<=32'h7f1b) excDM=1;
					end
					if(excDM) Ov=(sw|sh|sb)?3:2;
				end
			end
			15:begin
				exOut={SrcA[31],SrcA}-{SrcB[31],SrcB};
				ALUOut=exOut;
				Ov=(exOut[32]!=exOut[31])?1:0;
			end
		endcase
		
	end
				  
endmodule
