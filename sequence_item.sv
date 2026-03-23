class seq_item extends uvm_sequence_item;
	rand bit[5:0] apb_addr;
	rand bit[31:0] apb_wdata;
	rand bit apb_write;
	bit apb_sel;
	bit apb_en;
	bit sda_in;
	bit[31:0] apb_rdata;
	bit apb_ready;
	bit sda_out;
	bit scl;
	bit sda_oe;

	`uvm_object_utils_begin(seq_item)
	`uvm_field_int(apb_addr, UVM_ALL_ON);
	`uvm_field_int(apb_wdata, UVM_ALL_ON);
	`uvm_field_int(apb_write, UVM_ALL_ON);
	`uvm_field_int(apb_sel, UVM_ALL_ON);
	`uvm_field_int(apb_en, UVM_ALL_ON);
	`uvm_field_int(sda_in, UVM_ALL_ON);
	`uvm_field_int(apb_rdata, UVM_ALL_ON);
	`uvm_field_int(apb_ready, UVM_ALL_ON);
	`uvm_field_int(sda_out, UVM_ALL_ON);
	`uvm_field_int(scl, UVM_ALL_ON);
	`uvm_field_int(sda_oe, UVM_ALL_ON);
	`uvm_object_utils_end

	function new(string name="seq_item");
		super.new(name);
	endfunction
endclass
