class rd_mon extends uvm_monitor;
	`uvm_component_utils(rd_mon)

	function new(string name = "rd_mon",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual scon_if.rd_mon_mp vif;
	rd_cfg m_cfg;
	rd_xtn xtn;
	
	uvm_analysis_port#(rd_xtn) mon_port;

	function void build_phase (uvm_phase phase);
		if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get m-cfg from wr_mon")
		mon_port = new("mon_port",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction


	task run_phase(uvm_phase phase);
			@(vif.rd_mon_cb);
		
		forever
			
			begin
				//repeat(2)
			//@(vif.rd_mon_cb);

				monitor();
				`uvm_info(get_type_name(),$sformatf("The  data_out %s",xtn.sprint()),UVM_LOW)
			end
	endtask


	task monitor();
		xtn = rd_xtn::type_id::create("xtn");
		repeat(2)
			@(vif.rd_mon_cb);
		
			xtn.scon = vif.rd_mon_cb.scon;// <= req.reset;
			/*xtn.mode = vif.wr_mon_cb.mode ;//<= req.mode;
			xtn.ren = vif.wr_mon_cb.ren;//<=req.ren;
			xtn.tb8_set = vif.wr_mon_cb.tb8_set;// <= req.tb8_set;
			xtn.rb8_receive = vif.wr_mon_cb.rb8_receive;// <=req.rb8_receive;
			xtn.tx_complete = vif.wr_mon_cb.tx_complete;//<= req.tx_complete;
			xtn.rx_complete = vif.wr_mon_cb.rx_complete;//<= req.rx_complete;
			*/
	
			mon_port.write(xtn);
	endtask



endclass
