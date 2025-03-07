class env_cfg extends uvm_object;
	`uvm_object_utils(env_cfg)

	function new(string name = "env_cfg");
		super.new(name);
	endfunction

	wr_cfg wr_cfgh[];
	rd_cfg rd_cfgh[];
	
	int no_of_wr;
	int no_of_rd;
	
endclass
