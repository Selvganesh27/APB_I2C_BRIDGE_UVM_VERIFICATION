package p;
	import uvm_pkg::*;
  	  `include "uvm_macros.svh"
	  //sequence item
	  `include "sequence_item.sv"
      //sequence
      `include "apb_write_seq.sv"
      `include "apb_write_seq_override.sv"
	  `include "apb_read_seq.sv"
      `include "apb_wr_seq.sv"
	  `include "i2c_write_seq.sv"
	  `include "i2c_read_seq.sv"
      //sequencer
	  `include "apb_sequencer.sv"
	  `include "i2c_sequencer.sv"
      //driver
      `include "driver_callback.sv"
      `include "custom_callback.sv"
      `include "apb_driver.sv"     
	  `include "i2c_driver.sv"
      //monitor
      `include "apb_monitor.sv"
	  `include "i2c_monitor.sv"
      //scoreboard and coverage collector(subscriber)
	  `include "scoreboard.sv"
      `include "coverage_collector.sv"
      //agent
      `include "apb_agent.sv"
	  `include "i2c_agent.sv"
      //environment
	  `include "environment.sv"
      //test
      `include "apb_write_test.sv"
	  `include "apb_read_test.sv"
      `include "apb_wr_test.sv"
      `include "i2c_write_test.sv"
	  `include "i2c_read_test.sv"
	  `include "i2c_wr_test.sv"
      `include "i2c_rw_test.sv"
	  `include "i2c_rep_write_test.sv"
	  `include "i2c_rep_read_test.sv"
      //call_back test
      
      `include "callback_test.sv"
      
      	  	  
endpackage
