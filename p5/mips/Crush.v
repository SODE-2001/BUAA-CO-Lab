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
	output reg weD,
	output reg clrE,
	output reg freezePC,
	output reg [2:0] rsDfwd,
	output reg [2:0] rtDfwd,
	output reg [2:0] rsEfwd,
	output reg [2:0] rtEfwd,
	output reg [2:0] rtMfwd
    );
	 
	reg stallE,stallM;
	reg [4:0] rsD,rtD,rsE,rtE,rtM;
	
	always@(*)begin
		rsD=instrD[25:21];
		rtD=instrD[20:16];
		rsE=instrE[25:21];
		rtE=instrE[20:16];
		rtM=instrM[20:16];
		
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
				 
		if(stallE||stallM)begin
			weD=0;
			clrE=1;
			freezePC=1;
		end
		else begin
			weD=1;
			clrE=0;
			freezePC=0;
		end
	end
endmodule
