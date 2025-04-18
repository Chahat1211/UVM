`include "uvm_macros.svh"
import uvm_pkg::*;
`include "seq_item.sv"

class mem_monitor extends uvm_monitor;
	
	`uvm_component_utils(mem_monitor)
	uvm_analysis_port#(mem_seq_item) item_collected_port;

	virtual inf vif;
	mem_seq_item trans_collected;

	
	covergroup mem_cov(ref bit wr_enb, ref bit rd_enb, ref bit[3:0] wr_addr, ref bit[3:0] rd_addr);

		wr_enb_cp: coverpoint wr_enb { ignore_bins b0 = {0}; }
		rd_enb_cp: coverpoint rd_enb { ignore_bins b1 = {0}; }
		wr_addr_cp: coverpoint wr_addr;
		rd_addr_cp: coverpoint rd_addr;

		
		axw: cross wr_addr_cp, wr_enb_cp;
		axr: cross rd_addr_cp, rd_enb_cp;
	endgroup

	function new(string name, uvm_component parent);
		super.new(name, parent);
		trans_collected = new();
		mem_cov = new(trans_collected.wr_enb, trans_collected.rd_enb, trans_collected.wr_addr, trans_collected.rd_addr);
		item_collected_port = new("item_collected_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual inf)::get(this, "", "vif", vif))
			`uvm_fatal("NO VIF", {" No interface set for:", get_full_name(), ".vif"});
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.clk);
			trans_collected.rst = vif.rst;
				
			if (vif.wr_enb) begin
				trans_collected.wr_enb = vif.wr_enb;
				trans_collected.wr_addr = vif.wr_addr;
				trans_collected.wr_data = vif.wr_data; 
				trans_collected.rd_enb = 0;
			end
			else if (vif.rd_enb) begin
				trans_collected.rd_enb = vif.rd_enb;
				trans_collected.rd_addr = vif.rd_addr;
				trans_collected.wr_enb = 0;
				//@(posedge vif.clk);
				#1;
				trans_collected.rd_data = vif.rd_data;
			end

			mem_cov.sample();

			item_collected_port.write(trans_collected);
		end
	endtask
	
	
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("MEM_COV", $sformatf("Final Coverage: %0.2f%%", mem_cov.get_coverage()), UVM_MEDIUM);
	endfunction

endclass



