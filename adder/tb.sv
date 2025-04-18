
`include "design.sv"
`include "interface.sv"
`include "test.sv"


module tb;
  
  inf inf1();
  
  adder DUT (inf1.a,inf1.b, inf1.c);
  
  
  initial begin 
    uvm_config_db#(virtual inf)::set(null,"*","vif", inf1);
    run_test("test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
