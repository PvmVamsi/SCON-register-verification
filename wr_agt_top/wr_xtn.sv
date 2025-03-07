class wr_xtn extends uvm_sequence_item;
	`uvm_object_utils(wr_xtn)
	function new(string name = "wr_xtn");
		super.new(name);
	endfunction


	rand bit reset;
	rand bit [1:0]mode;
	rand bit ren;
	rand bit tb8_set;
	rand bit rb8_receive;
	rand bit tx_complete;
	rand bit rx_complete;
	
	function void do_print(uvm_printer printer);
		printer.print_field("reset",reset,1,UVM_DEC);
		printer.print_field("mode",mode,2,UVM_DEC);
		printer.print_field("ren",ren,1,UVM_DEC);
		printer.print_field("tb8_set",tb8_set,1,UVM_DEC);
		printer.print_field("rb8_receive",rb8_receive,1,UVM_DEC);
		printer.print_field("tx_complete",tx_complete,1,UVM_DEC);
		printer.print_field("rx_complete",rx_complete,1,UVM_DEC);
	endfunction

endclass
