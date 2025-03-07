class env extends uvm_env;
	`uvm_component_utils(env)
	
	function new(string name = "env",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	sb sbh;
	wr_agt_top wr_toph;
	rd_agt_top rd_toph;
	
	function void build_phase(uvm_phase phase);
		sbh = sb::type_id::create("sbh",this);
		wr_toph = wr_agt_top::type_id::create("wr_toph",this);
		rd_toph = rd_agt_top::type_id::create("rd_toph",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		begin
			wr_toph.wr_agth[0].monh.mon_port.connect(sbh.wr_fifoh[0].analysis_export);
			rd_toph.rd_agth[0].monh.mon_port.connect(sbh.rd_fifoh[0].analysis_export);		
		end
	endfunction
endclass
