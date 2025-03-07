class test extends uvm_test;
	`uvm_component_utils(test)
	
	function new(string name = "test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	env_cfg m_cfg;
	int no_of_wr;
	int no_of_rd;
	
	wr_cfg wr_cfgh[];
	rd_cfg rd_cfgh[];
	
	env envh;	

	wr_seq wr_seqh;

	function void build_phase(uvm_phase phase);
		
		m_cfg = env_cfg::type_id::create("m_cfg");
		no_of_wr = 1;
		no_of_rd = 1;
		
		wr_cfgh = new[no_of_wr];
		rd_cfgh = new[no_of_rd];


		foreach(wr_cfgh[i]) begin
			wr_cfgh[i] = wr_cfg::type_id::create($sformatf("wr_cfgh[%0d]",i));
			if(!uvm_config_db#(virtual scon_if)::get(this,"","vif",wr_cfgh[i].vif))
				`uvm_fatal(get_type_name(),"virt")
				
			wr_cfgh[i].is_active = UVM_ACTIVE;
		end

		foreach(rd_cfgh[i]) begin
			rd_cfgh[i] = rd_cfg::type_id::create($sformatf("rd_cfgh[%0d]",i));
			if(!uvm_config_db#(virtual scon_if)::get(this,"","vif",rd_cfgh[i].vif))
				`uvm_fatal(get_type_name(),"virt")
			rd_cfgh[i].is_active = UVM_PASSIVE;
		end
		
	 	m_cfg.no_of_wr = no_of_wr;
		m_cfg.no_of_rd = no_of_rd;
		m_cfg.wr_cfgh = wr_cfgh;
		m_cfg.rd_cfgh = rd_cfgh;

		envh = env::type_id::create("envh",this);
				uvm_config_db#(env_cfg)::set(this,"*","env_cfg",m_cfg);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction


	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			wr_seqh = wr_seq::type_id::create("wr_seqh");


			wr_seqh.start(envh.wr_toph.wr_agth[0].seqrh);

			#20;
		phase.drop_objection(this);
	endtask

			
endclass
