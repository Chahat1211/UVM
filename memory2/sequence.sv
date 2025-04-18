import uvm_pkg::*;
`include "uvm_macros.svh"

class rd_wr_sequence extends uvm_sequence#(mem_seq_item);

  `uvm_object_utils(rd_wr_sequence)

  function new(string name = "rd_wr_sequence");
    super.new(name);
  endfunction 

  virtual task body(); 

    repeat(20) begin
      `uvm_do_with(req, {req.wr_enb == 1;})
      `uvm_do_with(req, {req.rd_enb == 1;})
    end

    //repeat(10) begin
      //`uvm_do_with(req, {req.rd_enb == 1;})
    //end
  endtask 
endclass


/*virtual task body();
  mem_seq_item req;
  
  repeat(10) begin
    req = mem_seq_item::type_id::create("req");
    if (!req.randomize())  
      `uvm_error("SEQ", "Randomization failed for req!")
    `uvm_do_with(req, {req.wr_enb == 1;})
    `uvm_info("SEQ", $sformatf("Generated wr_enb=%0b, addr=%0d, data=%0d", req.wr_enb, req.wr_addr, req.wr_data), UVM_MEDIUM)
  end

  repeat(10) begin
    req = mem_seq_item::type_id::create("req");
    if (!req.randomize())  
      `uvm_error("SEQ", "Randomization failed for req!")
    `uvm_do_with(req, {req.rd_enb == 1;})
    `uvm_info("SEQ", $sformatf("Generated rd_enb=%0b, addr=%0d", req.rd_enb, req.rd_addr), UVM_MEDIUM)
  end
endtask
endclass*/

