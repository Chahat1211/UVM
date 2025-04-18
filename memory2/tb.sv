import uvm_pkg::*;
`include "uvm_macros.svh"
`include "design.sv"
`include "interface.sv"
`include "basetest.sv"
`include "wr_rd_test.sv"

module tb_top;
	bit clk;
	bit rst;
	
	always #5 clk = ~clk;
		
	initial begin
		clk = 0;
		rst = 1;
	    #10 rst = 0;
	    #60 rst = 1;
	#15 rst=0;
	end

	inf inf1(clk, rst);
		
	ram DUT(inf1.clk, inf1.rst, inf1.wr_enb, inf1.wr_addr, inf1.wr_data, inf1.rd_enb, inf1.rd_addr, inf1.rd_data);
	
	initial begin 
		uvm_config_db#(virtual inf)::set(null,"*","vif", inf1);
	end

	initial begin
		run_test("wr_rd_test");
	end

	
endmodule 

