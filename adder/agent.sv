`include "driver.sv"
`include "sequencer.sv"
`include "monitor.sv"

class agent extends uvm_agent;
  
  `uvm_component_utils(agent)
  
  driver driv;
  monitor mon;
  sequencer seqr;
  function new (string name = "agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driv = driver::type_id::create("driv", this);
    mon = monitor::type_id::create("mon", this);
    seqr = sequencer::type_id::create("seqr", this);
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    driv.seq_item_port.connect(seqr.seq_item_export);
  endfunction 
endclass
