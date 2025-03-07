class wr_agt_top extends uvm_env;
	`uvm_component_utils(wr_agt_top)
	function new(string name = "wr_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	env_cfg m_cfg;
	wr_agt wr_agth[];

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"Can t get config from wr_agt_top")
		wr_agth = new[m_cfg.no_of_wr];
		
		foreach(wr_agth[i])
			begin
			wr_agth[i] = wr_agt::type_id::create($sformatf("wr_agth[%0d]",i),this);
			uvm_config_db#(wr_cfg)::set(this,$sformatf("wr_agth[%0d]*",i),"wr_cfg",m_cfg.wr_cfgh[i]);
			end
	endfunction


endclass

