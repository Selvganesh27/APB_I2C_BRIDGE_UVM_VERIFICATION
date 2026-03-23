class apb_wr_seq extends uvm_sequence #(seq_item);

	//factory registration
	`uvm_object_utils(apb_wr_seq)

	//construction
	function new (string name="apb_wr_seq");
		super.new(name);
	endfunction

	virtual task body();
       `uvm_do_with(req, {req.apb_addr == 6'h14; req.apb_wdata == 32'h6; req.apb_write == 1;})
       `uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", req.apb_write, req.apb_addr, req.apb_wdata, req.apb_rdata), UVM_LOW)
       `uvm_do_with(req, {req.apb_addr == 6'h14; req.apb_write == 0;})
       `uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", req.apb_write, req.apb_addr, req.apb_wdata, req.apb_rdata), UVM_LOW)
       `uvm_info(get_type_name(), $sformatf("ADDRESS AND DATA TRANSMITTED TO THE DRIVER"), UVM_LOW)
endtask
endclass
 
