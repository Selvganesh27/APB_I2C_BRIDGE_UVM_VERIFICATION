class apb_write_test extends uvm_test;

	//environment handle
	environment env;

	//sequence handle
	apb_write_seq seq;

	//factory registration
	`uvm_component_utils(apb_write_test)

	//construction
	function new(string name="apb_write_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		//create environment
		env = environment::type_id::create("env", this);
      
		//override the new write seq
		/*set_type_override_by_type(apb_write_seq::get_type(),
		                         apb_write_seq_override::get_type(),
					 1);*/
	endfunction

	//run phase
	virtual task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		//create sequence
		seq = apb_write_seq::type_id::create("seq", this);
		//start the sequence
		seq.start(env.apb_ag.apb_seqr);
		#500;
		phase.drop_objection(this);
		`uvm_info(get_type_name(),"SUCCESSFULLY STARTS THE TEST", UVM_LOW)
		//`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", seq.req.apb_write, seq.req.apb_addr, seq.req.apb_wdata, seq.req.apb_rdata), UVM_LOW)
	endtask
endclass
