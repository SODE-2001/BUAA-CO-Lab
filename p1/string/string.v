`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:10 10/21/2021 
// Design Name: 
// Module Name:    string 
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
module string(
	input clk,
	input clr,
	input [7:0] in,
	output out
    );
	reg [1:0] status;
	
	initial begin
		status=0;
	end
	always@(posedge clk or posedge clr)begin
		if(clr)begin
			status=0;
		end
		else begin
			case(status)
				0:begin
					if(in>="0"&&in<="9")begin
						status=1;
					end
					else begin
						status=3;
					end
				end
				1:begin
					if(in=="+"||in=="*")begin
						status=2;
					end
					else begin
						status=3;
					end
				end
				2:begin
					if(in>="0"&&in<="9")begin
						status=1;
					end
					else begin
						status=3;
					end
				end
				3:begin
				end
			endcase
		end
	end
	assign out=(status==1)?1:0;
endmodule
