class wr_drv extends uvm_driver#(wr_xtn);
	`uvm_component_utils(wr_drv)

	function new(string name = "wr_drv",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual scon_if.wr_drv_mp vif;
	wr_cfg m_cfg;
	
	function void build_phase (uvm_phase phase);
		if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get m-cfg from wr_drv")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				drive(req);
				`uvm_info(get_type_name(),$sformatf("The drive data %s",req.sprint()),UVM_LOW)
				seq_item_port.item_done();
			end
	endtask

	task drive(wr_xtn xtn);
		@(vif.wr_drv_cb);
			vif.wr_drv_cb.reset <= req.reset;
			vif.wr_drv_cb.mode <= req.mode;
			vif.wr_drv_cb.ren<=req.ren;
			vif.wr_drv_cb.tb8_set <= req.tb8_set;
			vif.wr_drv_cb.rb8_receive <=req.rb8_receive;
			vif.wr_drv_cb.tx_complete<= req.tx_complete;
			vif.wr_drv_cb.rx_complete<= req.rx_complete;

		@(vif.wr_drv_cb);

			
	endtask
endclass
