class wr_seqr extends uvm_sequencer#(wr_xtn);
	`uvm_component_utils(wr_seqr)
	function new(string name = "wr_seqr",uvm_component parent = null);
		super.new(name,parent);
	endfunction

endclass
