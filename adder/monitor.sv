class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  virtual inf vif;
  transaction trans_collected;
  
  uvm_analysis_port#(transaction) send;
  
  function new (string name = "monitor", uvm_component parent);
    super.new(name,parent);
    trans_collected = new();
    send = new("send", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual inf)::get(this,"","vif", vif))
      `uvm_fatal("NO VIF", "Interface is not set at Mon");
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      #1;
      trans_collected.a = vif.a;
      trans_collected.b = vif.b;
      trans_collected.c = vif.c;
      trans_collected.print();
      send.write(trans_collected);
      
    end
  endtask
endclass
