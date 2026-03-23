class i2c_driver extends uvm_driver #(seq_item);

  `uvm_component_utils(i2c_driver)

  virtual interf vif;
  seq_item req;

  function new(string name="i2c_driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual interf)::get(this,"","vif",vif))
      `uvm_fatal("I2C_DRV","virtual interface not set")
    	else
		`uvm_info(get_type_name(),$sformatf("VIRTUAL INTERFACE GOTTED FOR I2C DRIVER"), UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);

      // Only I2C activity here
      drive_i2c_slave(req);

      seq_item_port.item_done();
    end
  endtask

  // ---------------------------------------------------
  // I2C SLAVE BEHAVIOR
  // ---------------------------------------------------

  task drive_i2c_slave(seq_item t);
    wait_start();
    sample_address();
    if(t.apb_write)
      drive_read_data(t);
    else
      sample_write_data(t);
    wait_stop();
  endtask

  // start
  task wait_start();
    @(negedge vif.sda_out iff (vif.sclk == 1));
    vif.sda_in <= 1;
    `uvm_info(get_type_name(),"START detected",UVM_LOW)
  endtask

  //address
  task sample_address();
    bit [6:0] addr;
    bit rw;

    for(int i=6;i>=0;i--) begin
      @(posedge vif.sclk);
      addr[i] = vif.sda_out;
    end

    //rw
    @(posedge vif.sclk);
    rw = vif.sda_out;

    // ACK
    @(negedge vif.sclk);
    vif.sda_in <= 0;
    vif.sda_oe <= 1;

    @(negedge vif.sclk);
    vif.sda_oe <= 0;
    vif.sda_in <= 1;

    `uvm_info(get_type_name(),
      $sformatf("ADDR=%0h RW=%0b",addr,rw),UVM_LOW)
  endtask

  //write task

  task sample_write_data(seq_item t);
    bit [7:0] data;

    for(int i=7;i>=0;i--) begin
      @(posedge vif.sclk);
      data[i] = vif.sda_out;
    end

    // ACK
    @(negedge vif.sclk);
    vif.sda_in <= 0;
    vif.sda_oe <= 1;

    @(negedge vif.sclk);
    vif.sda_oe <= 0;
    vif.sda_in <= 1;

    `uvm_info(get_type_name(),
      $sformatf("WRITE DATA=%0h",data),UVM_LOW)
  endtask

  // read task

  task drive_read_data(seq_item t);
    bit [7:0] data = t.apb_wdata[7:0]; // data from sequence
	
    vif.sda_oe <= 1;

    for(int i=7;i>=0;i--) begin
      @(negedge vif.sclk);
      vif.sda_in <= data[i];
          end

    @(negedge vif.sclk);
    vif.sda_oe <= 0; 


    `uvm_info(get_type_name(),
      $sformatf("READ DATA=%0h",data),UVM_LOW)
  endtask

  // ---------------------------------------------------

  task wait_stop();
    @(posedge vif.sda_out iff (vif.sclk == 1));
    `uvm_info(get_type_name(),"STOP detected",UVM_LOW)
  endtask

endclass
