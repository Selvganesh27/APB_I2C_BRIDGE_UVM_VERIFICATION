class my_subscriber extends uvm_subscriber #(seq_item);

	//factory registration
	`uvm_component_utils(my_subscriber);

	//handle for sequence item
	seq_item seq;
	
	//coverage
  covergroup apb_i2c_cg with function sample();

		// Address coverage
		cp_addr : coverpoint seq.apb_addr{
		bins lower_addr = {[0:15]};
		bins mid_addr = {[16:31]};
		bins high_addr = {[32:63]};
	}
      
	    // write/read coverage
	    cp_write : coverpoint seq.apb_write{
        bins write_bin = {1};
		bins read_bin = {0};
	}
      
		//wdata coverage
		cp_wdata : coverpoint seq.apb_wdata{
		bins zero_bin = {32'h0};
		bins max_bin = {32'hFFFF_FFFF};
		bins other_bin = {[1:32'hFFFF_FFFF]};
	}
      
		// rdata coverage
		cp_rdata : coverpoint seq.apb_rdata{
		bins zero_bin = {32'h0};
		bins max_bin = {32'hFFFF_FFFF};
		bins other_bin = {[1:32'hFFFF_FFFF]};
	}
      
		//cross coverage
		cross_addr_rw : cross cp_addr, cp_write;
	endgroup
  
        //constructor
	function new(string name="my_subscriber", uvm_component component);
		super.new(name, component);
		apb_i2c_cg = new();
	endfunction


	//sample in write() method
	function void write(seq_item t);
		seq = t;
		apb_i2c_cg.sample();      
		`uvm_info(get_type_name(),$sformatf("Coverage sampled for addr=%0h write=%0b", t.apb_addr, t.apb_write),UVM_LOW)	
        `uvm_info(get_type_name(), $sformatf("COVERGROUP FINISHED"), UVM_LOW)
    endfunction
endclass
