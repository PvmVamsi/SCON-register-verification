class wr_cfg extends uvm_object;
	`uvm_object_utils(wr_cfg)

	function new(string name = "wr_cfg");
		super.new(name);
	endfunction
	
	uvm_active_passive_enum is_active;
	virtual scon_if vif;
endclass
