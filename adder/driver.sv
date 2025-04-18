class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  transaction trans;
  virtual inf vif;
  
  function new (string name  ="driver", uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans = transaction::type_id::create("trans");
    if(!uvm_config_db#(virtual inf)::get(this, "","vif",vif))
      `uvm_fatal("NO VIF", " NO interface is set at Driv");
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(trans);
      vif.a <= trans.a;
      vif.b <= trans.b;
      seq_item_port.item_done();
      #1;
    end
  endtask
endclass
