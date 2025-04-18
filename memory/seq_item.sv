`include "uvm_macros.svh"
import uvm_pkg::*;

class mem_seq_item extends uvm_sequence_item;
	//Control Information
	rand bit[3:0] addr;
	rand bit wr_en;
	rand bit rd_en;

	//payload information
	rand bit[7:0] wdata;

	//analysis information
	bit[7:0] rdata;

	`uvm_object_utils_begin(mem_seq_item)
		`uvm_field_int(addr, UVM_ALL_ON)
		`uvm_field_int(wr_en, UVM_ALL_ON)
		`uvm_field_int(rd_en, UVM_ALL_ON)
		`uvm_field_int(wdata, UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "mem_seq_item");
		super.new(name);
	endfunction

	constraint wr_rd_c {wr_en != rd_en;};
endclass
