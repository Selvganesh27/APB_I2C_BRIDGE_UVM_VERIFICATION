class i2c_monitor extends uvm_monitor;

	//handle for virtual interface
	virtual interf vif;

	//handle for seq_item
	seq_item seq;

	// analysis port
	uvm_analysis_port#(seq_item)i2c_mon_ap;

	//factory registration
	`uvm_component_utils(i2c_monitor)

	//constructor
	function new(string name="i2c_monitor", uvm_component parent);
		super.new(name, parent);
		i2c_mon_ap = new("i2c_mon_ap", this);
	endfunction 

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual interf)::get(this,"","vif",vif))
		`uvm_fatal(get_type_name(), "VIRTUAL INTERFACE WASN'T SET")
	else
		`uvm_info(get_type_name(), $sformatf("VIRUAL INTERFACE GOTTED FOR I2C MONITOR"), UVM_LOW)
	endfunction

	//run phase
	virtual task run_phase(uvm_phase phase);
	forever begin
		seq = seq_item::type_id::create("seq", this);

		//start
		@(negedge vif.sda_out iff(vif.sclk == 1));

	       	//address
		for(int i=6;i>=0;i--) begin
			@(posedge vif.sclk);
			seq.apb_addr[i] = vif.sda_out;
		end

		//rw
		@(posedge vif.sclk);
		seq.apb_write = ~vif.sda_out;

		//skips ack (9th bit)
		@(posedge vif.sclk);

		//write data
		if(seq.apb_write) begin
		for(int i=7;i>=0;i--)begin
			@(posedge vif.sclk);
			seq.apb_wdata[i] = vif.sda_out;
		end
	end
		//read data
		else begin
		for(int i=7;i>=0;i--) begin
			@(posedge vif.sclk);
			seq.apb_rdata[i] = vif.sda_in;
		end
	end

		//skips ack
		@(posedge vif.sclk);

		//stop
		@(posedge vif.sda_out iff(vif.sclk == 1));
		`uvm_info(get_type_name(), $sformatf("TRANSCATION CAPTURED"), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", seq.apb_write, seq.apb_addr, seq.apb_wdata, seq.apb_rdata), UVM_LOW)
		i2c_mon_ap.write(seq);
	end
endtask
endclass
