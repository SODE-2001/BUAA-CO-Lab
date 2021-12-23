`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:21 11/11/2021 
// Design Name: 
// Module Name:    mips 
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
/////////////////////////////////////////////////////////////////////////////////
	
module mips(
	input clk,
	input reset,
	input [31:0] i_inst_rdata,
   input [31:0] m_data_rdata,
	input interrupt,                
   output [31:0] macroscopic_pc,   
   output [31:0] i_inst_addr,
   output [31:0] m_data_addr,
   output [31:0] m_data_wdata,
   output [3 :0] m_data_byteen,
   output [31:0] m_inst_addr,
   output w_grf_we,
   output [4:0] w_grf_addr,
   output [31:0] w_grf_wdata,
   output [31:0] w_inst_addr
    );
	
	wire TCwe1,TCwe2,IRQ1,IRQ2;
	wire [3:0] byteen;
	wire [31:0] addr,rdata,wdata,TCOut1,TCOut2;
	
	assign m_data_addr=addr;
	assign m_data_wdata=wdata;
	
	CPU CPU(
		.clk(clk),									.macroscopic_pc(macroscopic_pc),
		.reset(reset),								.i_inst_addr(i_inst_addr),
		.i_inst_rdata(i_inst_rdata),			.m_data_addr(addr),
		.m_data_rdata(rdata),					.m_data_wdata(wdata),
		.HWInt({3'b0,interrupt,IRQ2,IRQ1}),				
														.m_data_byteen(byteen),
														.m_inst_addr(m_inst_addr),
														.w_grf_we(w_grf_we),
														.w_grf_addr(w_grf_addr),
														.w_grf_wdata(w_grf_wdata),
														.w_inst_addr(w_inst_addr)
	);
	
	Bridge Bridge(
		.rdata_in(m_data_rdata),			
		.addr(addr),							.byteen_out(m_data_byteen),
		.byteen_in(byteen),					.TCwe1(TCwe1),
		.TCOut1(TCOut1),						.TCwe2(TCwe2),
		.TCOut2(TCOut2),						.PrRD(rdata)
	);
	
	TC TC1(
		.clk(clk),								.Dout(TCOut1),
		.reset(reset),							.IRQ(IRQ1),
		.Addr(addr[31:2]),
		.WE(TCwe1),
		.Din(wdata)
	);
	
	TC TC2(
		.clk(clk),								.Dout(TCOut2),
		.reset(reset),							.IRQ(IRQ2),
		.Addr(addr[31:2]),
		.WE(TCwe2),
		.Din(wdata)
	);
		
endmodule
