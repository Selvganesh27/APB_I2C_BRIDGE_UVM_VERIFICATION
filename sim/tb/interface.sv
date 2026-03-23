interface interf;
	logic apb_clk;
	logic apb_reset_n;
	logic[5:0] apb_addr;
	logic[31:0] apb_wdata;
	logic apb_write;
	logic apb_sel;
	logic apb_en;
	logic sda_in;
	logic[31:0] apb_rdata;
	logic apb_ready;
	logic sda_out;
	logic sda_oe;
	logic sclk;
	logic intr_i2c;
 endinterface
