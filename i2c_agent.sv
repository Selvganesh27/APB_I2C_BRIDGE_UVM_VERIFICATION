class i2c_agent extends uvm_agent;

	//handle for sequencer
	i2c_sequencer i2c_seqr;

	//handle for driver
	i2c_driver i2c_drv;

	//handle for monitor
	i2c_monitor i2c_mon;

	//factory registration
	`uvm_component_utils(i2c_agent)

	//constructor
	function new(string name="i2c_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active) begin
			i2c_seqr = i2c_sequencer::type_id::create("i2c_seqr", this);
			i2c_drv = i2c_driver::type_id::create("i2c_drv", this);
		end
			i2c_mon = i2c_monitor::type_id::create("i2c_mon", this);
		endfunction

	//connect phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active) begin
			i2c_drv.seq_item_port.connect(i2c_seqr.seq_item_export);
			`uvm_info(get_type_name(), $sformatf("CONNECTION SUCCESSFULL"), UVM_LOW)
		end
	endfunction
endclass
