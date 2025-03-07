class rd_cfg extends uvm_object;
	`uvm_object_utils(rd_cfg)

	function new(string name = "rd_cfg");
		super.new(name);
	endfunction
	
	uvm_active_passive_enum is_active;
	virtual scon_if vif;
endclass
