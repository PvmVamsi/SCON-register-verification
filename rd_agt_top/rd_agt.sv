class rd_agt extends uvm_agent;
	`uvm_component_utils(rd_agt)
	function new(string name = "rd_agt",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	rd_mon monh;
	//wr_drv drvh;
	//wr_seqr seqrh;
	
	rd_cfg m_cfg;
	
	function void build_phase (uvm_phase phase);
		if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get m-cfg from rd_agt")
	
	if(m_cfg.is_active == UVM_PASSIVE)
		monh = rd_mon::type_id::create("monh",this);
	/*	
		if(m_cfg.is_active == UVM_ACTIVE);
			begin
			drvh = wr_drv::type_id::create("drvh",this);
			seqrh = wr_seqr::type_id::create("seqrh",this);
			end*/
	endfunction


endclass
