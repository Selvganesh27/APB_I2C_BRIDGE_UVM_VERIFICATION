//apb sequencer
class apb_sequencer extends uvm_sequencer #(seq_item);
	`uvm_component_utils(apb_sequencer);

	function new(string name="apb_sequencer", uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), $sformatf("SUCCESSFULLY TRANSFERRED TO DRIVER"), UVM_LOW)
	endfunction
endclass
