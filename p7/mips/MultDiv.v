`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:53 11/27/2021 
// Design Name: 
// Module Name:    MultDiv 
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
module MultDiv(
	input clk,
	input reset,
	input start,
	input [31:0] rd1,
	input [31:0] rd2,
	input [2:0] op,
	input Req,
	output reg [31:0] HI,
	output reg [31:0] LO,
	output busy
    );
	
	reg [31:0] count,state;
	reg [31:0] div,res;
	reg [63:0] mul;
	
	always@(posedge clk)begin
		if(reset)begin
			HI<=0;
			LO<=0;
			state<=0;
			count<=0;
		end
		else if(op<4&&!Req) begin
			case(state)
				0:begin
					if(start==1)begin
						case(op)
							0:begin 
								state<=1; 
								mul<=$signed(rd1)*$signed(rd2);
							end
							1:begin
								state<=1;
								mul<=rd1*rd2;
							end
							2:begin
								state<=2;
								div<=$signed(rd1)/$signed(rd2); 
								res<=$signed(rd1)%$signed(rd2);
							end
							3:begin
								state<=2;
								div<=rd1/rd2; res<=rd1%rd2;
							end
						endcase
					end
				end
				1:begin						//mul
					if(count<4)begin
						count<=count+1;
					end
					else begin
						HI<=mul[63:32]; LO<=mul[31:0];
						state<=0;
						count<=0;
					end
				end
				2:begin						//div
					if(count<9)begin
						count<=count+1;
					end
					else begin
						HI<=res; LO<=div;
						state<=0;
						count<=0;
					end
				end
			endcase
		end
		else if(op==4&&!Req)begin
			HI<=rd1;
		end
		else if(op==5&&!Req)begin
			LO<=rd1;
		end
	end
	
	assign busy=(state||start);
	
endmodule
