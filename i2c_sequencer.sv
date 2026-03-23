//i2c sequencer
class i2c_sequencer extends uvm_sequencer #(seq_item);
	`uvm_component_utils(i2c_sequencer);

	function new(string name="i2c_sequencer", uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), $sformatf("SUCCESSFULLY TRANSFERRED TO DRIVER"), UVM_LOW)
	endfunction
endclass
