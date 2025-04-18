import uvm_pkg::*;
`include "uvm_macros.svh"

class mem_seq_item extends uvm_sequence_item;
	//control
	rand bit wr_enb;
	rand bit rd_enb;
	rand bit[3:0] wr_addr;
	rand bit[3:0] rd_addr;

	//payload 
	rand bit[7:0] wr_data;

	//analysis
	bit[7:0] rd_data;
	bit rst;
	bit clk;

	`uvm_object_utils_begin(mem_seq_item)
		`uvm_field_int(wr_addr,UVM_ALL_ON)
		`uvm_field_int(rd_addr, UVM_ALL_ON)
		`uvm_field_int(wr_enb, UVM_ALL_ON)
		`uvm_field_int(rd_enb, UVM_ALL_ON)
		`uvm_field_int(wr_data, UVM_ALL_ON)
	`uvm_object_utils_end

	function new( string name = "mem_seq_item");
		super.new(name);
	endfunction

	constraint rd_wr_c {rd_enb != wr_enb;};
endclass
