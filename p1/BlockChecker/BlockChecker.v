`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:38 10/22/2021 
// Design Name: 
// Module Name:    BlockChecker 
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
module BlockChecker(
	input clk,
	input reset,
	input [7:0] in,
	output result
    );
	reg [31:0] count; 
	reg [3:0] status;
	initial begin
		count=0;
		status=0;
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			count=0;
			status=0; 
		end
		else begin
			if(in==" ")begin
				status=0;
			end
			else begin
			case(status)
			
				0:begin
					if(in=="b"||in=="B")begin
						status=1;
					end
					else if(in=="e"||in=="E")begin
						status=5;
					end
					else begin
						status=7;
					end
				end
				
				1:begin
					if(in=="e"||in=="E")begin
						status=2;
					end
					else begin
						status=7;
					end
				end
				
				2:begin
					if(in=="g"||in=="G")begin
						status=3;
					end
					else begin
						status=7;
					end
				end
				
				3:begin
					if(in=="i"||in=="I")begin
						status=4;
					end
					else begin
						status=7;
					end
				end
				
				4:begin
					if(in=="n"||in=="N")begin
						if($signed(count)>=0)begin
							count=count+1;
						end
						status=8;
					end
					else begin
						status=7;
					end
				end 
				
				5:begin
					if(in=="n"||in=="N")begin
						status=6;
					end
					else begin
						status=7;
					end
				end
				
				6:begin
					if(in=="d"||in=="D")begin
						count=count-1;
						status=9;
					end
					else begin
						status=7;
					end
				end
				
				7:begin
					status=7;
				end
				
				8:begin
					count=count-1;
					status=7;
				end
				
				9:begin
					count=count+1;
					status=7;
				end
				
			endcase
			end
		end
	end
	
	assign result=(count==0)?1:0;
	
endmodule
