import uvm_pkg::*;
`include "seq_item.sv"
class mem_sequence extends uvm_sequence#(mem_seq_item);
	
	`uvm_object_utils(mem_sequence)

	function new(string name = "mem_sequence");
		super.new(name);
	endfunction

	`uvm_declare_p_sequencer(mem_sequence)

	virtual task body();
		repeat(10) begin
			req = mem_seq_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			send_request(req);
			wait_for_item_done();
		end
	endtask
endclass

class write_sequence extends uvm_sequence#(mem_seq_item);
	`uvm_object_utils(write_sequence)

	function new( string name = "write_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.wr_en==1;})
	endtask
endclass

class read_sequence extends uvm_sequence#(mem_seq_item);
	`uvm_object_utils(read_sequence);
	
	function new(string name = "read_sequence");
		super.new(name);
	endfunction
	
	virtual task body();
		`uvm_do_with(req,{req.rd_en == 1;})
	endtask
endclass

class write_read_sequence extends uvm_sequence#(mem_seq_item);
	`uvm_object_utils(write_read_sequence)

	function new (string name = "write_read_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.wr_en==1;})
		`uvm_do_with(req,{req.rd_en==1;})
	endtask
endclass

class wr_rd_sequence extends uvm_sequence#(mem_seq_item);
	write_sequence wr_seq;
	read_sequence rd_seq;
	
	`uvm_object_utils(wr_rd_sequence)

	function new(string name = "wr_rd_sequence");
		super.new(name);
	endfunction 

	virtual task body();
		repeat(10) begin
		`uvm_do(wr_seq);
		end
		repeat(10) begin
		`uvm_do(rd_seq);
		end
	endtask
endclass
		
	
