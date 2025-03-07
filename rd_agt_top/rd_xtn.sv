class rd_xtn extends uvm_sequence_item;
	`uvm_object_utils(rd_xtn)
	
	function new(string name = "rd_xtn");
		super.new(name);
	endfunction
	
	bit [7:0]scon;
	function void do_print(uvm_printer printer);
	//	printer.print_field("reset",reset,1,UVM_DEC);
		printer.print_field("scon",scon,8,UVM_BIN);
		//printer.print_field("ren",ren,1,UVM_DEC);
		//printer.print_field("tb8_set",tb8_set,1,UVM_DEC);
		//printer.print_field("rb8_receive",rb8_receive,1,UVM_DEC);
		//printer.print_field("tx_complete",tx_complete,1,UVM_DEC);
		//printer.print_field("rx_complete",rx_complete,1,UVM_DEC);
	endfunction

endclass
