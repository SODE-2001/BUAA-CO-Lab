`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:50 11/27/2021 
// Design Name: 
// Module Name:    BE 
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
module BE(
	input [31:0] instr,
	input [31:0] idata,
	input [31:0] iaddr,
	input [2:0] storeOp,
	output reg [3:0] byteen,
	output reg [31:0] wdata,
	output reg [31:0] waddr
    );
	
	reg [5:0] opcode;
	
	always@(*)begin
		byteen=0;
		wdata=0;
		opcode=instr[31:26];
		waddr=iaddr;
		
		if(storeOp==1)begin	//sb 
			case(iaddr[1:0])
				0:begin
					byteen=4'b0001;
					wdata[7:0]=idata[7:0];
				end
				1:begin
					byteen=4'b0010;
					wdata[15:8]=idata[7:0];
				end
				2:begin
					byteen=4'b0100;
					wdata[23:16]=idata[7:0];
				end
				3:begin
					byteen=4'b1000;
					wdata[31:24]=idata[7:0];
				end
			endcase
		end
		
		else if(storeOp==2)begin //sh 
			case(iaddr[1])
				0:begin
					byteen=4'b0011;
					wdata[15:0]=idata[15:0];
				end
				1:begin
					byteen=4'b1100;
					wdata[31:16]=idata[15:0];
				end
			endcase
		end
		
		else if(storeOp==3)begin //sw
			byteen=4'b1111;
			wdata=idata;
		end
		
		else begin
			byteen=0;
			wdata=0;
		end
	end

endmodule
