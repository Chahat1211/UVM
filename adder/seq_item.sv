
class transaction extends uvm_sequence_item;
  rand bit[3:0] a;
  rand bit[3:0] b;
  bit[4:0] c;
  	
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a, UVM_ALL_ON)
  `uvm_field_int(b, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new (string name = "transaction");
    super.new(name);
  endfunction 
  
endclass

