import uvm_pkg::*;
`include "uvm_macros.svh"
class mem_sequencer extends uvm_sequencer#(mem_seq_item);

	`uvm_component_utils(mem_sequencer)

	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction
endclass

