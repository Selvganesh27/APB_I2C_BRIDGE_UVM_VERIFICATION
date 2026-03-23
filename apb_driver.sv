class apb_driver extends uvm_driver #(seq_item);

// virtual interface handle creation
	virtual interf vif;
  
// call back registration
  `uvm_register_cb(apb_driver, driver_callback)
	
//factrory registration and construction
	`uvm_component_utils(apb_driver)
	function new(string name="apb_driver",uvm_component parent);
		super.new(name, parent);
	endfunction

//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual interf)::get(this,"","vif",vif))
		`uvm_fatal(get_type_name(),"virtual interface wasn't set")
	else
		`uvm_info(get_type_name(),$sformatf("vif gotted for apb driver"), UVM_LOW)
endfunction

//run phase
virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
//idle state
vif.apb_sel <= 0;
vif.apb_en <= 0;
forever begin
//	seq_item seq;
  
	seq_item_port.get_next_item(req);
  `uvm_do_callbacks(apb_driver, driver_callback, pre_task(req))
	apb_drv(req);
  `uvm_do_callbacks(apb_driver, driver_callback, post_task(req))
	seq_item_port.item_done();
  
end
endtask

//driver logic
virtual task apb_drv(seq_item m_item);

//setup state
@(posedge vif.apb_clk)
vif.apb_sel <= 1;
vif.apb_en <= 0;
vif.apb_write <= m_item.apb_write;
vif.apb_addr <= m_item.apb_addr;
if(m_item.apb_write)
vif.apb_wdata <= m_item.apb_wdata;

//access state
@(posedge vif.apb_clk)
vif.apb_en <= 1;

//wait condition
while(!vif.apb_ready) 
	@(posedge vif.apb_clk)

if(!m_item.apb_write)
		m_item.apb_rdata <= vif.apb_rdata;
@(posedge vif.apb_clk)
vif.apb_sel <= 0;
vif.apb_en <= 0;
`uvm_info(get_type_name(), $sformatf("APB_WRITE=%0b | ADDRESS=%0h | APB_WDATA=%0h | APB_RDATA=%0h", m_item.apb_write, m_item.apb_addr, m_item.apb_wdata, m_item.apb_rdata), UVM_LOW)
endtask
endclass
