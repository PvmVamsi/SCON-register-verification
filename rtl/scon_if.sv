interface scon_if(input bit clk);
	bit reset;
	logic [1:0]mode;
	bit ren;
	logic tb8_set;
	logic rb8_receive;
	logic tx_complete;
	logic rx_complete;
	logic [7:0]scon;

	clocking wr_drv_cb@(posedge clk);
		default input #1 output #1;
		output reset;
		output mode;
		output ren;
		output tb8_set;
		output rb8_receive;
		output tx_complete;
		output rx_complete;
	endclocking
	
	clocking wr_mon_cb@(posedge clk);
		default input #1 output #1;
		input mode;
		input ren;
		input reset;
		input tb8_set;
		input rb8_receive;
		input tx_complete;
		input rx_complete;
	endclocking

	clocking rd_mon_cb@(posedge clk);
		default input #1 output #1;
		input scon;
	endclocking

	modport wr_drv_mp (clocking wr_drv_cb);
	modport wr_mon_mp (clocking wr_mon_cb);
	modport rd_mon_mp (clocking rd_mon_cb);
endinterface
