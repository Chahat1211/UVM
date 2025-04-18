import uvm_pkg::*;
`include "uvm_macros.svh"
`include "env.sv"
`include "sequence.sv"
class test extends uvm_test;
  environment env;
  sequence_1 seq;
  
  `uvm_component_utils(test);
  
  function new (string name = "test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    seq = sequence_1::type_id::create("seq", this);
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agnt.seqr);
    phase.drop_objection(this);
  endtask
endclass

