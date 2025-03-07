class sb extends uvm_scoreboard;
	`uvm_component_utils(sb)
	
	uvm_tlm_analysis_fifo #(rd_xtn) rd_fifoh[];
	uvm_tlm_analysis_fifo #(wr_xtn) wr_fifoh[];

	env_cfg m_cfg;


	wr_xtn wxtn;
	rd_xtn rxtn;
	bit[7:0]dout;

	int unsigned count_matched = 0;	
	int unsigned count_read = 0;
	

	covergroup cv;
		reset:coverpoint wxtn.reset {bins rst[] = {1,0};}
		mode:coverpoint wxtn.mode {bins load[] = {1,0};}
		ren:coverpoint wxtn.ren;
		tb8:coverpoint wxtn.tb8_set;
		rb8:coverpoint wxtn.rb8_receive;
		tx_complete:coverpoint wxtn.tx_complete;
		rx_complete:coverpoint wxtn.rx_complete;
	endgroup


	function new(string name = "sb",uvm_component parent = null);
			super.new(name,parent);
			cv = new;
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_type_name(),"cant get env cfg")
		$display("m_cfg.no_of_rd : %0d=============================",m_cfg.no_of_rd);	
		rd_fifoh = new[m_cfg.no_of_rd];
		wr_fifoh = new[m_cfg.no_of_wr];
		
		foreach(rd_fifoh[i])
			rd_fifoh[i] = new($sformatf("rd_fifoh[%0d]",i),this);
		
		
		foreach(wr_fifoh[i])
			wr_fifoh[i] = new($sformatf("wr_fifoh[%0d]",i),this);
	endfunction	

	task run_phase(uvm_phase phase);
		fork
			forever begin
				wr_fifoh[0].get(wxtn);
				`uvm_info("SB",$sformatf("The W_XTN from sb :%s",wxtn.sprint()),UVM_LOW)
				check_data(wxtn);
				cv.sample();			
			end

	
			forever begin
				rd_fifoh[0].get(rxtn);
					`uvm_info("SB",$sformatf("The R_XTN from sb :%s",rxtn.sprint()),UVM_LOW)
				count_read++;
							

				
				if(dout == rxtn.scon)begin
					`uvm_info("SB","The data is matched================",UVM_LOW)
						count_matched++;
					end
				else
					`uvm_info("SB",$sformatf("===MISMATCH dout = %0d=====",dout),UVM_LOW)
			end	
	
		join
	endtask

	function void extract_phase(uvm_phase phase);
		`uvm_info("EXTRACT PHASE",$sformatf("Matched : %0d",count_matched),UVM_LOW)
		`uvm_info("EXTRACT PHASE",$sformatf("Mismatched : %0d",count_read-count_matched),UVM_LOW)

	endfunction

	task check_data(wr_xtn xtn);
		 if (xtn.reset) begin
            		dout = 8'b0000_0000; // Reset SCON register

     end 
		else begin
            // Serial Mode Control
            dout[7:6] = xtn.mode;

            // Receive Enable
            dout[5] = xtn.ren;

            // Transmit 9th bit (TB8)
            if (xtn.tb8_set)
                dout[4] = 1'b1;
            else
                dout[4] = 1'b0;

            // Receive 9th bit (RB8)
            if (xtn.rb8_receive)
                dout[3] = 1'b1;
            else
                dout[3] = 1'b0;

            // Transmit Interrupt Flag (TI)
            if (xtn.tx_complete)
                dout[2] = 1'b1; // Set TI when transmission completes
            else
                dout[2] = 1'b0;

            // Receive Interrupt Flag (RI)
            if (xtn.rx_complete)
 		dout[1] = 1'b1; // Set RI when reception completes
            else
                dout[1] = 1'b0;
        end
   
	endtask

endclass
