class apb_agent extends uvm_agent;
	apb_sequencer apb_seqr;
	apb_driver apb_drv;
	apb_monitor apb_mon;

	//factroy registration
	`uvm_component_utils(apb_agent)

	//construction
	function new(string name="apb_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active()) begin
			apb_seqr = apb_sequencer::type_id::create("apb_seqr", this);
			apb_drv = apb_driver::type_id::create("apb_drv", this);
		end
		        apb_mon = apb_monitor::type_id::create("apb_mon", this);
	endfunction

	//connect phase
	function void connect_phase(uvm_phase phase);
		if(get_is_active()) begin
			apb_drv.seq_item_port.connect(apb_seqr.seq_item_export);
			`uvm_info(get_type_name(), "CONNECTION SUCCESSFULL", UVM_LOW)
		//	`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", req.apb_write, req.apb_addr, req.apb_wdata, req.apb_rdata), UVM_LOW)
		end
	endfunction
endclass
