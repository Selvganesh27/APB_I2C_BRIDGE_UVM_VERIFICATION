class apb_monitor extends uvm_monitor;
	virtual interf vif;
	// factroy registration
	`uvm_component_utils(apb_monitor)
	
	// analysis port declaration
	uvm_analysis_port#(seq_item)mon_ap;

	//construction
	function new(string name="apb_monitor", uvm_component parent);
		super.new(name, parent);
		mon_ap = new("mon_ap", this);
	endfunction

	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual interf)::get(this, "*", "vif", vif))
		`uvm_fatal(get_type_name(), "VIRTUAL INTERFACE WASN'T SET")
		else
		`uvm_info(get_type_name(), $sformatf("VIRTUAL INTERFACE GOTTED FOR APB MONITOR"), UVM_LOW)
	endfunction

//run phase
virtual task run_phase(uvm_phase phase);
seq_item seq;
forever begin
@(posedge vif.apb_clk)
if(vif.apb_sel && vif.apb_en && vif.apb_ready) begin
	seq = seq_item::type_id::create("seq", this);
	seq.apb_addr = vif.apb_addr;
	seq.apb_write = vif.apb_write;
	if(vif.apb_write)
		seq.apb_wdata = vif.apb_wdata;
	else
		seq.apb_rdata = vif.apb_rdata;
	`uvm_info(get_type_name(), $sformatf("TRANSCATION CAPTURED"), UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", seq.apb_write, seq.apb_addr, seq.apb_wdata, seq.apb_rdata), UVM_LOW)
	mon_ap.write(seq);
end
end
endtask
endclass
