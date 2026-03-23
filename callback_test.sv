class callback_test extends apb_write_test;
  
  //factory registration 
  `uvm_component_utils(callback_test)
  
  //constructor
  function new(string name="callback_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // handle for custom_callback
  custom_callback cb;
  
  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cb = custom_callback::type_id::create("cb", this);
    `uvm_info("CALLBACK_TEST", "callback_test build_phase executed", UVM_LOW)
    uvm_callbacks #(apb_driver, driver_callback)::add(env.apb_ag.apb_drv, cb);
  endfunction
endclass
