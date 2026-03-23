class i2c_write_seq extends uvm_sequence #(seq_item);

	//factory registration
	`uvm_object_utils(i2c_write_seq)

	//construction	
	function new(string name="i2c_write_seq");
		super.new(name);
	endfunction

	//body task
	virtual task body();
		`uvm_do_with(req, {req.apb_addr == 6'h14; req.apb_wdata == 32'h6; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h08; req.apb_wdata == 32'h9E; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h18; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h04; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h10; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h28; req.apb_wdata == 32'h14; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h24; req.apb_wdata == 32'h6; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h2C; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h30; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h34; req.apb_wdata == 32'h00; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h0C; req.apb_wdata == 32'h18A; req.apb_write == 0;})
		//`uvm_do_with(req, {req.apb_addr == 6'h00; req.apb_wdata == 32'h09; req.apb_write == 0;})

		`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | APB_ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", req.apb_write, req.apb_addr, req.apb_wdata, req.apb_rdata), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("ADDRESS AND DATA TRANSMITTED TO THE SEQUENCER"), UVM_LOW)
	endtask
endclass
