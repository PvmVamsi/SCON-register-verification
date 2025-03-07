module top;
	import uvm_pkg::*;
	import pkg::*;
	bit clk = 0;
	always #5 clk = ~clk;

	scon_if IF(clk);

	SCON duv(clk,IF.reset,IF.mode,IF.ren,IF.tb8_set,IF.rb8_receive,IF.tx_complete,IF.rx_complete,IF.scon);
	
	initial begin
		`ifdef VCS
		$fsdbDumpvars(0,top);
		`endif	

		uvm_config_db#(virtual scon_if)::set(null,"*","vif",IF);
		run_test();
	end
endmodule	
