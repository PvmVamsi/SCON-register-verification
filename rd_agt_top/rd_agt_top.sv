class rd_agt_top extends uvm_env;
	`uvm_component_utils(rd_agt_top)
	function new(string name = "rd_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	env_cfg m_cfg;
	rd_agt rd_agth[];

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"Can t get config from rd_agt_top")
		rd_agth = new[m_cfg.no_of_rd];
		
		foreach(rd_agth[i])
			begin
			rd_agth[i] = rd_agt::type_id::create($sformatf("rd_agth[%0d]",i),this);
			uvm_config_db#(rd_cfg)::set(this,$sformatf("rd_agth[%0d]*",i),"rd_cfg",m_cfg.rd_cfgh[i]);
			end
	endfunction


endclass

