//import uvm_pkg::*;     comes in server
`include "uvm_macros.svh"
`include "interface.sv"
`include "package.sv"
//import p::*;           comes in server

module tb;
interf i();

i2c_top uut(
	.apb_clk(i.apb_clk),
	.apb_resetn(i.apb_reset_n),
	.apb_addr(i.apb_addr),
	.apb_write(i.apb_write),
	.apb_wdata(i.apb_wdata),
	.apb_sel(i.apb_sel),
	.apb_en(i.apb_en),
	.apb_ready(i.apb_ready),
	.apb_rdata(i.apb_rdata),
	.sclk(i.sclk),
	.sda_out(i.sda_out),
	.sda_in(i.sda_in),
	.sda_oe(i.sda_oe),
	.intr_i2c(i.intr_i2c));

//clock generation
initial i.apb_clk = 0;
always #5 i.apb_clk = ~i.apb_clk;

//active low reset
initial begin
	i.apb_reset_n = 0;
	repeat(2) @(posedge i.apb_clk);
	i.apb_reset_n = 1;
end

//config_db for set interface and running test
initial begin
	uvm_config_db#(virtual interf)::set(null,"*","vif",i);
	`uvm_info("TB","SUCCESSFULLY STARTS THE VERIFICATION", UVM_LOW)
  run_test("i2c_read_test");
end

initial begin
  uvm_root::get().set_timeout(1000000, 1);
end

//for waveform and command line use
initial begin
//	if($test$value$plusarg("dump")) begin
//		$vcdplusfile("output.vpd");
//		$vcdpluson;
//	end
  $dumpfile("i2c_top.vcd");
  $dumpvars(0, tb);
end
endmodule
