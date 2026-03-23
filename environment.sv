class environment extends uvm_env;
	apb_agent apb_ag;
	i2c_agent i2c_ag;
    my_subscriber sub;
    my_scoreboard sb;

	//factory registration
	`uvm_component_utils(environment)

	//construction
	function new(string name="environment",uvm_component parent);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	//	apb_ag.is_active=UVM_ACTIVE;
		apb_ag = apb_agent::type_id::create("apb_ag", this);

	//	i2c_ag.is_active=UVM_ACTIVE;
		i2c_ag = i2c_agent::type_id::create("i2c_ag", this);
    	
      	sb = my_scoreboard::type_id::create("sb", this);
        sub = my_subscriber::type_id::create("sub", this);
      endfunction

    // connect phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
    //connecting apb and i2c monitors to scoreboard
        apb_ag.apb_mon.mon_ap.connect(sb.apb_fifo.analysis_export);
		i2c_ag.i2c_mon.i2c_mon_ap.connect(sb.i2c_fifo.analysis_export);
    //connecting apb and i2c monitors to subscriber
		apb_ag.apb_mon.mon_ap.connect(sub.analysis_export);
		i2c_ag.i2c_mon.i2c_mon_ap.connect(sub.analysis_export);
	endfunction

endclass
