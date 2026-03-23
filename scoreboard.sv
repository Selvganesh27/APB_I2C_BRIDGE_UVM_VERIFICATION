class my_scoreboard extends uvm_scoreboard;

	//factory registration
	`uvm_component_utils(my_scoreboard)

	//analysis fifo for apb and i2c 
	uvm_tlm_analysis_fifo#(seq_item)apb_fifo;
	uvm_tlm_analysis_fifo#(seq_item)i2c_fifo;

	//constructor
	function new(string name="my_scoreboard", uvm_component parent);
		super.new(name, parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		apb_fifo = new("apb_fifo", this);
		i2c_fifo = new("i2c_fifo", this);
		`uvm_info(get_type_name(), $sformatf("BUILD PHASE COMPLETED"), UVM_LOW)
	endfunction

	//run phase
	virtual task run_phase(uvm_phase phase);
	seq_item apb_txn, i2c_txn;
	forever begin
		//getting from monitors
		fork
		apb_fifo.get(apb_txn);
		i2c_fifo.get(i2c_txn);
	    join
		`uvm_info(get_type_name(), $sformatf("FIFOS GOTTED THE DATAS"), UVM_LOW)


		//address check
		if(apb_txn.apb_addr !== i2c_txn.apb_addr)
			`uvm_error(get_type_name(), $sformatf("ADDRESS MISMATCHED** apb_addr:%0h, i2c_addr:%0h", apb_txn.apb_addr, i2c_txn.apb_addr))

		//wdata check
		if(apb_txn.apb_write) begin
			if(apb_txn.apb_wdata !== i2c_txn.apb_wdata)
				`uvm_error(get_type_name(), $sformatf("WDATA MISMATCHED** apb_wdata:%0h, i2c_wdata:%0h", apb_txn.apb_wdata, i2c_txn.apb_wdata))
		end
		else begin //rdata check
			if(apb_txn.apb_rdata !== i2c_txn.apb_rdata)
				`uvm_error(get_type_name(), $sformatf("RDATA MISMATCHED** apb_rdata:%0h, i2c_rdata:%0h", apb_txn.apb_rdata, i2c_txn.apb_rdata));
			end
			`uvm_info(get_type_name(),"SCOREBOARD FINISHED", UVM_LOW)

                end
	endtask
endclass
