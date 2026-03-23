class apb_wr_test extends uvm_test;

	//handle for environment
	environment env;

	//handle for sequence
	apb_wr_seq seq;

	//factory registration
	`uvm_component_utils(apb_wr_test)

	//constructor
	function new(string name="apb_wr_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		//memory foer environment
		env = environment::type_id::create("env", this);
	endfunction

	//run phase
	virtual task run_phase(uvm_phase phase);

	phase.raise_objection(this);
	seq = apb_wr_seq::type_id::create("seq", this);
	seq.start(env.apb_ag.apb_seqr);
	#500;
	phase.drop_objection(this);
        `uvm_info(get_type_name(),"SUCCESSFULLY STARTS THE TEST", UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", seq.req.apb_write, seq.req.apb_addr, seq.req.apb_wdata, seq.req.apb_rdata), UVM_LOW)

endtask
endclass
	
