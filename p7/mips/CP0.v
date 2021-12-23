`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:19 12/11/2021 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
	input [31:0] instr,
	input [31:0] Din,
	input [31:0] PC,
	input [4:0] ExcCode,
	input [5:0] HWInt,
	input EXLclr,
	input BD,
	input clk,
	input reset,
	output Req,
	output IntReq,
	output reg [31:0] EPC,
	output reg [31:0] Dout
    );
	
	reg [31:0] SR,Cause,PrID;

	wire [4:0] A1=instr[15:11];
	wire [4:0] A2=instr[15:11];
	wire we=(instr[31:26]==6'b010000&&instr[25:21]==5'b00100);
	
	//IM	SR[15:10] : allow interrupt  one hot
	//EXL	SR[1] : during interrupt
	//IE	SR[0] : interrupt enable
	
	//BD			Cause[31] : delay branch
	//HWInt 		Cause[15:10] which interrupt 
	//ExcCode	Cause[6:2] exception code
	
	assign IntReq=HWInt[2]&&SR[12]&&(!SR[1])&&SR[0];
	wire HWReq=(HWInt&SR[15:10])&&(!SR[1])&&SR[0];
	wire ExcReq=(ExcCode)&&(!SR[1]);
	assign Req=HWReq|ExcReq;
	
	always@(*)begin
		case(A1)
			12:Dout=SR;
			13:Dout=Cause;
			14:Dout=EPC;
			15:Dout=PrID;
		endcase
	end
	
	always@(posedge clk)begin
		if(reset)begin
			SR<=0;
			Cause<=0;
			EPC<=0;
			PrID<=0;
		end
		else begin
			Cause[15:10]<=HWInt;	
			
			if(Req)begin
				Cause[31]<=BD;		
				Cause[6:2]<=(HWReq)?0:ExcCode;
				SR[1]<=1;
				EPC<=(BD)?PC-4:PC;
			end
			else if(we)begin
				case(A2)
					12:SR<=Din;
					13:Cause<=Din;
					14:EPC<=Din;
					15:PrID<=Din;
				endcase
			end
			
			if(EXLclr)begin
				SR[1]<=0;
			end
		end
	end

endmodule
