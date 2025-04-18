//`include "agent.sv"
`include "scoreboard.sv"
import uvm_pkg::*;

class mem_env extends uvm_env;
	
	mem_agent mem_agnt;
	mem_scoreboard mem_scb;
	
	`uvm_component_utils(mem_env);
	
	function new(string name, uvm_component phase);
		super.new(name,phase);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		mem_agnt = mem_agent::type_id::create("mem_agnt", this);
		mem_scb = mem_scoreboard::type_id::create("mem_scb", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		mem_agnt.monitor.items_collected_port.connect(mem_scb.items_collected_export);
	endfunction

endclass
