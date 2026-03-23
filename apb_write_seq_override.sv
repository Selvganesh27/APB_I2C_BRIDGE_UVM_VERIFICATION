//new apb write sequence for override

class apb_write_seq_override extends apb_write_seq;

	//factory registration
	`uvm_object_utils(apb_write_seq_override)
	
	//constructor
	function new (string name="apb_write_seq_override");
		super.new(name);
	endfunction

	task body();
		`uvm_do_with(req, {req.apb_addr == 6'h10; req.apb_wdata == 32'h5A; req.apb_write == 1;})
		`uvm_info(get_type_name(), $sformatf("NEW SEQ OVERRIDDEN "), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", req.apb_write, req.apb_addr, req.apb_wdata, req.apb_rdata), UVM_LOW)
	endtask
endclass
