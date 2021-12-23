`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:37:33 11/20/2021 
// Design Name: 
// Module Name:    Crush 
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
module Crush(
	input [2:0] tuseRsD,
	input [2:0] tuseRtD,
	input [2:0] tnewE,
	input [2:0] tnewM,
	input [31:0] instrD,
	input [31:0] instrE,
	input [31:0] instrM,
	input [4:0] A3E,
	input [4:0] A3M,
	input [4:0] A3W,
	input useMD,
	input MDbusy,
	output reg weD,
	output reg clrE,
	output reg freezePC,
	output reg stall,
	output reg [2:0] rsDfwd,
	output reg [2:0] rtDfwd,
	output reg [2:0] rsEfwd,
	output reg [2:0] rtEfwd,
	output reg [2:0] rtMfwd
    );
	 
	reg stallE,stallM,stall_eret;
	reg [4:0] rsD,rtD,rsE,rtE,rtM,rdE,rdM;
	reg eretD,mtc0E,mtc0M;
	
	always@(*)begin
		rsD=instrD[25:21];
		rtD=instrD[20:16];
		rsE=instrE[25:21];
		rtE=instrE[20:16];
		rtM=instrM[20:16];
		rdE=instrE[15:11];
		rdM=instrM[15:11];
		
		eretD=(instrD[31:26]==6'b010000&&instrD[5:0]==6'b011000);
		mtc0E=(instrE[31:26]==6'b010000&&instrE[25:21]==5'b00100);
		mtc0M=(instrM[31:26]==6'b010000&&instrM[25:21]==5'b00100);
		
		rsDfwd=(rsD&&rsD==A3E&&tnewE==0)?2:
				 (rsD&&rsD==A3M&&$signed(tnewM-1)<=0)?1:0;
	
		rtDfwd=(rtD&&rtD==A3E&&tnewE==0)?2:
				 (rtD&&rtD==A3M&&$signed(tnewM-1)<=0)?1:0;
	
		rsEfwd=(rsE&&rsE==A3M&&$signed(tnewM-1)<=0)?2:
				 (rsE&&rsE==A3W)?1:0;
					  
		rtEfwd=(rtE&&rtE==A3M&&$signed(tnewM-1)<=0)?2:
				 (rtE&&rtE==A3W)?1:0;
					  
		rtMfwd=(rtM&&rtM==A3W)?1:0;
	
		stallE=($signed(tuseRsD)<$signed(tnewE)&&rsD&&rsD==A3E)||
				 ($signed(tuseRtD)<$signed(tnewE)&&rtD&&rtD==A3E);
					
		stallM=($signed(tuseRsD)<$signed(tnewM-1)&&rsD&&rsD==A3M)||
				 ($signed(tuseRtD)<$signed(tnewM-1)&&rtD&&rtD==A3M);
				 
		stall_eret=eretD && ( (mtc0E&&(rdE==14)) || (mtc0M&&(rdM==14)) );
				 
		stall=stallE | stallM | (useMD&MDbusy) | stall_eret;
	end
endmodule
