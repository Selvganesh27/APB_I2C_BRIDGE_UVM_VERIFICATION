class i2c_read_test extends uvm_test;
	
	//handle for environment
	environment env;

	//handle for apb read sequence
	apb_read_seq apb_seq;

	//handle for i2c read sequence
	i2c_read_seq i2c_seq;

	//factory registration
	`uvm_component_utils(i2c_read_test)

	//constructor
	function new(string name="i2c_read_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
		apb_seq = apb_read_seq::type_id::create("apb_seq", this);
		i2c_seq = i2c_read_seq::type_id::create("i2c_seq", this);
	endfunction

	//run phase
	virtual task run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	`uvm_info(get_type_name(), $sformatf("******READY TO START THE TEST******"), UVM_LOW)
	apb_seq.start(env.apb_ag.apb_seqr);
	`uvm_info(get_type_name(), $sformatf("STARTED THE APB READ TEST"), UVM_LOW)
	i2c_seq.start(env.i2c_ag.i2c_seqr);
	`uvm_info(get_type_name(), $sformatf("STARTED THE I2C READ TEST"), UVM_LOW)
	phase.drop_objection(this);
	`uvm_info(get_type_name(),"*****SUCCESSFULLY STARTS THE BOTH TEST*****", UVM_LOW)

	endtask
endclass
