
class sequence_1 extends uvm_sequence#(transaction);
  transaction trans;
  `uvm_object_utils(sequence_1);
  
  function new (string name = "sequence_1");
    super.new(name);	
    trans = transaction::type_id::create("trans");
  endfunction
  
  virtual task body();
    repeat(10) begin
    start_item(trans);
    assert(trans.randomize());
    finish_item(trans);
    end
  endtask
endclass
