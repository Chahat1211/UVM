class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  transaction trans;
  
  uvm_analysis_imp#(transaction, scoreboard) recieve;
  
  function new (string name = "scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recieve = new("recieve", this);
    trans = transaction::type_id::create("trans");
  endfunction 
  
  virtual function void write (transaction trans);
    trans.print();
    if ( trans.a + trans.b == trans.c ) begin
      `uvm_info("SCB" ,"TEST PASSED :) ", UVM_NONE )
    end
    else begin
      `uvm_error("SCB", "TEST FAILED :( ")
    end
  endfunction 
endclass
