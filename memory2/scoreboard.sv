class mem_scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(mem_scoreboard)

	mem_seq_item queue[$];
	bit[7:0] mem[0:15];

	uvm_analysis_imp#(mem_seq_item,mem_scoreboard) item_collected_export;

	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			item_collected_export = new("item_collected_export", this);
			foreach(mem[i]) mem[i] = 0;
			$display("sb built");
	endfunction

	
	/*virtual function void write(mem_seq_item pkt);
		queue.push_back(pkt);
	endfunction

	virtual task run_phase(uvm_phase phase);
		mem_seq_item mem_pkt;
		forever begin
			wait(queue.size() > 0);
			mem_pkt = queue.pop_front();
			
			if(mem_pkt.rst) begin
				foreach(mem[i]) mem[i] = 0;
			end
			else begin
				if(mem_pkt.rd_enb) begin 
					if (mem[mem_pkt.rd_addr] == mem_pkt.rd_data) begin
							`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
						  `uvm_info(get_type_name(),$sformatf("rd_Addr: %0d",mem_pkt.rd_addr),UVM_LOW)
						  `uvm_info(get_type_name(),$sformatf("Expected Data: %0d Actual Data: %0d",mem[mem_pkt.rd_addr],mem_pkt.rd_data),UVM_LOW)
						  `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
					end
					else begin 
					 `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
					  `uvm_info(get_type_name(),$sformatf("Addr: %0d",mem_pkt.rd_addr),UVM_LOW)
					  `uvm_info(get_type_name(),$sformatf("Expected Data: %0d Actual Data: %0d",mem[mem_pkt.rd_addr],mem_pkt.rd_data),UVM_LOW)
					  `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
					end
				end

				else if(mem_pkt.wr_enb) begin
					mem[mem_pkt.wr_addr] = mem_pkt.wr_data;
					`uvm_info(get_type_name(),$sformatf("---------:: WRITE DATA ::----------"), UVM_LOW)
					`uvm_info(get_type_name(),$sformatf("\t wr_Addr = %0d", mem_pkt.wr_addr),UVM_LOW)
					`uvm_info(get_type_name(),$sformatf("\t wr_data = %0d", mem_pkt.wr_data),UVM_LOW)
					`uvm_info(get_type_name(),"---------------------",UVM_LOW)
				end 
			end
	
		end
	endtask*/

	virtual function void write(mem_seq_item mem_pkt);
		if(mem_pkt.rst) begin
			foreach(mem[i]) mem[i] = 0;
			$display("REEEEESET");
		end
		
		else if(mem_pkt.rd_enb) begin 
			if (mem[mem_pkt.rd_addr] == mem_pkt.rd_data) begin
				`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
			  	`uvm_info(get_type_name(),$sformatf("rd_Addr: %0d",mem_pkt.rd_addr),UVM_LOW)
				`uvm_info(get_type_name(),$sformatf("Expected Data: %0d Actual Data: %0d",mem[mem_pkt.rd_addr],mem_pkt.rd_data),UVM_LOW)
				`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
			end
			else begin 
				`uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
				`uvm_info(get_type_name(),$sformatf("Addr: %0d",mem_pkt.rd_addr),UVM_LOW)
				`uvm_info(get_type_name(),$sformatf("Expected Data: %0d Actual Data: %0d",mem[mem_pkt.rd_addr],mem_pkt.rd_data),UVM_LOW)
				`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
			end
		end

		else if(mem_pkt.wr_enb) begin
			mem[mem_pkt.wr_addr] = mem_pkt.wr_data;
			`uvm_info(get_type_name(),$sformatf("---------:: WRITE DATA ::----------"), UVM_LOW)
			`uvm_info(get_type_name(),$sformatf("\t wr_Addr = %0d", mem_pkt.wr_addr),UVM_LOW)
			`uvm_info(get_type_name(),$sformatf("\t wr_data = %0d", mem_pkt.wr_data),UVM_LOW)
			`uvm_info(get_type_name(),"---------------------",UVM_LOW)
		end 
		`uvm_info("SB", $sformatf("sc mem : %p", mem), UVM_LOW)
	endfunction
endclass




