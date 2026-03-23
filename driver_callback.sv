class driver_callback extends uvm_callback;
  
  //factory registration
  `uvm_object_utils(driver_callback)
  
  //constructor
  function new(string name="driver_callback");
    super.new(name);
  endfunction
  
  //empty methods
  virtual task pre_task(seq_item seq);
  endtask
  virtual task post_task(seq_item seq);
  endtask
  
endclass
  
               
