`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:48 11/27/2021 
// Design Name: 
// Module Name:    DataExt 
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
module DataExt(
	input [31:0] rdata,
	input [31:0] addr,
	input [31:0] instr,
	input [2:0] loadOp,
	output reg [31:0] MemRd
	);
	
	always@(*)begin
		case(loadOp)
			0:begin										//lw
				MemRd=rdata;
			end
			
			1:begin										//lbu
				case(addr[1:0])
					0:MemRd={24'b0,rdata[7:0]};
					1:MemRd={24'b0,rdata[15:8]};
					2:MemRd={24'b0,rdata[23:16]};
					3:MemRd={24'b0,rdata[31:24]};
				endcase
			end
			
			2:begin										//lb
				case(addr[1:0])
					0:MemRd={{24{rdata[7]}},rdata[7:0]};
					1:MemRd={{24{rdata[15]}},rdata[15:8]};
					2:MemRd={{24{rdata[23]}},rdata[23:16]};
					3:MemRd={{24{rdata[31]}},rdata[31:24]};
				endcase
			end
			
			3:begin										//lhu
				case(addr[1])
					0:MemRd={16'b0,rdata[15:0]};
					1:MemRd={16'b0,rdata[31:16]};
				endcase
			end
			
			4:begin										//lh
				case(addr[1])
					0:MemRd={{16{rdata[15]}},rdata[15:0]};
					1:MemRd={{16{rdata[31]}},rdata[31:16]};
				endcase
			end
		endcase
	end

endmodule
