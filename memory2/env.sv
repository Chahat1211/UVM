
`include "agent.sv"
`include "scoreboard.sv"

class mem_env extends uvm_env;

	`uvm_component_utils(mem_env)

	mem_agent mem_agnt;
	mem_scoreboard scb;

	function new (string name, uvm_component parent);
		super.new(name, parent);	
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mem_agnt = mem_agent::type_id::create("mem_agnt", this);
		scb = mem_scoreboard::type_id::create("scb",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		mem_agnt.monitor.item_collected_port.connect(scb.item_collected_export);
	endfunction
endclass
