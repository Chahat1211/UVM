import uvm_pkg::*;
`include "sequence.sv"
class wr_rd_test extends mem_model_base_test;

  `uvm_component_utils(wr_rd_test)
  

  rd_wr_sequence seq;

  function new(string name = "wr_rd_test",uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seq = rd_wr_sequence::type_id::create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    
      phase.raise_objection(this);
      seq.start(env.mem_agnt.sequencer);
      phase.drop_objection(this);
    
    //phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
  
endclass 
