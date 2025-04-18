import uvm_pkg::*;
`include "uvm_macros.svh"
`include "driver.sv"

class mem_monitor extends uvm_monitor;
	virtual mem_if vif;
	
	uvm_analysis_port#(mem_seq_item) items_collected_port;
		
	mem_seq_item trans_collected;

	`uvm_component_utils(mem_monitor)

	function new ( string name, uvm_component parent);
		super.new(name,parent);
		trans_collected = new();
		items_collected_port = new("items_collected_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual mem_if)::get(this,"","vif", vif))
			`uvm_fatal("NO_VIF",{"virtual interface must be set for:", get_full_name(),"vif"}); 					
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.clk);
			wait(vif.wr_en || vif.rd_en);
				trans_collected.addr = vif.addr;
			if(vif.wr_en) begin 
				trans_collected.wr_en = vif.wr_en;
				trans_collected.wdata = vif.wdata;
				trans_collected.rd_en = 0;
				@(posedge vif.clk);
			end
			if(vif.rd_en) begin
				trans_collected.rd_en = vif.rd_en;
				trans_collected.wr_en = 0;
				@(posedge vif.clk);
				@(posedge vif.clk);
				trans_collected.rdata =  vif.rdata;
			end
			items_collected_port.write(trans_collected);
		end
	endtask
			
	

endclass
