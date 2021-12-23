`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:33:09 10/22/2021
// Design Name:   BlockChecker
// Module Name:   C:/Users/wangxuezhu/Desktop/p1/BlockChecker/test.v
// Project Name:  BlockChecker
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BlockChecker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire result;

	// Instantiate the Unit Under Test (UUT)
	BlockChecker uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		in = 0;

		// Wait 100 ns for global reset to finish
		#10 reset=1;
      #10 in="e"; reset=0;
		#10 in="n";
		#10 in="n";
		#10 in=" ";
		#10 in="b";
		#10 in="e";
		#10 in="g";
		#10 in="i";
		#10 in="n";
		#10 in=" ";

	end
      always #5 clk=~clk;
endmodule

