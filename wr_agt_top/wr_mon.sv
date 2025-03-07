class wr_mon extends uvm_monitor;
	`uvm_component_utils(wr_mon)

	function new(string name = "wr_mon",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual scon_if.wr_mon_mp vif;
	wr_cfg m_cfg;
	uvm_analysis_port #(wr_xtn)mon_port;
	wr_xtn xtn;

	function void build_phase (uvm_phase phase);
		if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get m-cfg from wr_mon")
		mon_port = new("mon_port",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			
			begin
				@(vif.wr_mon_cb);

				monitor();
				`uvm_info(get_type_name(),$sformatf("The mon data %s",xtn.sprint()),UVM_LOW)
			end
	endtask

	task monitor();
		xtn = wr_xtn::type_id::create("xtn");
		@(vif.wr_mon_cb);
			xtn.reset = vif.wr_mon_cb.reset;// <= req.reset;
			xtn.mode = vif.wr_mon_cb.mode ;//<= req.mode;
			xtn.ren = vif.wr_mon_cb.ren;//<=req.ren;
			xtn.tb8_set = vif.wr_mon_cb.tb8_set;// <= req.tb8_set;
			xtn.rb8_receive = vif.wr_mon_cb.rb8_receive;// <=req.rb8_receive;
			xtn.tx_complete = vif.wr_mon_cb.tx_complete;//<= req.tx_complete;
			xtn.rx_complete = vif.wr_mon_cb.rx_complete;//<= req.rx_complete;
		mon_port.write(xtn);
	
			
	endtask


endclass
