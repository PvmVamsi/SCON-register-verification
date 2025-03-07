class wr_agt extends uvm_agent;
	`uvm_component_utils(wr_agt)
	function new(string name = "wr_agt",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	wr_mon monh;
	wr_drv drvh;
	wr_seqr seqrh;
	
	wr_cfg m_cfg;
	
	function void build_phase (uvm_phase phase);
		if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get m-cfg from wr_agt")
		monh = wr_mon::type_id::create("monh",this);
		
		if(m_cfg.is_active == UVM_ACTIVE)
			begin
			drvh = wr_drv::type_id::create("drvh",this);
			seqrh = wr_seqr::type_id::create("seqrh",this);
			end
	endfunction
	
	function void connect_phase(uvm_phase phase);
			if(m_cfg.is_active == UVM_ACTIVE)
			begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
			end

	endfunction

endclass
