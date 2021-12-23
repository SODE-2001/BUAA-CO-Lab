`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:14 11/11/2021 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
	input [1:0] NPCop,
	input clk,
	input reset,
	input [31:0] branch,
	input [25:0] jump,
	input [31:0] jr,
	output [31:0] Instr,
	output [31:0] jal,
	output reg [31:0] PC
    );
	 
	reg [31:0] IM [1023:0];  
	wire [31:0] PC4;
	wire [31:0] idx,branchPC,jumpPC;	//MUX access
	initial begin
		$readmemh("code.txt",IM);
	end
	
	assign PC4=PC+4;
	assign idx=(PC-32'h3000)>>2;
	
	assign Instr=IM[idx];
	assign jal=PC4;
	
	assign branchPC=PC4+(branch<<2);
	assign jumpPC={PC[31:28],jump,2'b00};
	
	always@(posedge clk)begin
		if(reset)begin
			PC<=32'h3000; 
		end
		else begin
			PC<=(NPCop==0)?PC4:
				(NPCop==1)?branchPC:
				(NPCop==2)?jumpPC:jr;
		end
	end
endmodule
