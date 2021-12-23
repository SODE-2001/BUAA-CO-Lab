`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:11 11/11/2021 
// Design Name: 
// Module Name:    DM 
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
module DM(
	input clk,
	input reset,
	input MemWrite,
	input [1:0] stride,	// 0 for sb/lb; 1 for sh/lh; 2 for sw/lw
	input [31:0] Addr,
	input [31:0] WD,
	input [31:0] PC,
	output [31:0] RD
    );
	
	reg [7:0] dm[4095:0];
	integer i;
	
	always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<4095;i=i+1)begin
				dm[i]<=0;
			end
		end
		else begin 
			if(MemWrite)begin
				$display("@%h: *%h <= %h", PC, Addr, WD);
				dm[Addr]<=WD[7:0];
				if(stride>0)begin
					dm[Addr+1]<=WD[15:8];
				end
				if(stride==2)begin
					dm[Addr+2]<=WD[23:16];
					dm[Addr+3]<=WD[31:24];
				end
			end
		end
	end
	
	assign RD=(stride==0)?{24'b0,dm[Addr]}:
				 (stride==1)?{16'b0,dm[Addr+1],dm[Addr]}:
								 {dm[Addr+3],dm[Addr+2],dm[Addr+1],dm[Addr]};
	
endmodule
