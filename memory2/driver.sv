

class mem_driver extends uvm_driver#(mem_seq_item);
	virtual inf vif;

	`uvm_component_utils(mem_driver)
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual inf)::get(this,"","vif", vif))
			`uvm_fatal("NO VIF", {"interface is not set:", get_full_name(), ".vif"});
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask

	virtual task drive();
		`uvm_info("DRI",$sformatf("Enable: %b , %b",req.rd_enb,req.wr_enb),UVM_LOW)
		vif.wr_enb <=0;
		vif.rd_enb <=0;
		//@(posedge vif.clk);
		vif.rd_addr <= req.rd_addr;
		vif.wr_addr <= req.wr_addr;
		
		if (req.wr_enb) begin
			vif.wr_enb <= req.wr_enb;
			vif.wr_data <= req.wr_data;
		end 

		else if (req.rd_enb) begin
			vif.rd_enb <= req.rd_enb;
			//@(posedge vif.clk);
			//vif.rd_enb <=0;
			//@(posedge vif.clk);
			//req.rd_data <= vif.rd_data;
		end
		@(posedge vif.clk);
	endtask
endclass
			
			
		
