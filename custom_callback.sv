class custom_callback extends driver_callback;
  
  //factory registration
  `uvm_object_utils(custom_callback)
  
  //constructor
  function new(string name="custom_callback");
    super.new(name);
  endfunction
  
  virtual task pre_task(seq_item seq);
    `uvm_info("DRIVER", $sformatf("######## addr=%0h, data=%0h ########", seq.apb_addr, seq.apb_wdata), UVM_LOW)
  endtask
  
  virtual task post_task(seq_item seq);
    `uvm_info("DRIVER",$sformatf("#######POST TASK COMPLETED########"), UVM_LOW)
  endtask
endclass
