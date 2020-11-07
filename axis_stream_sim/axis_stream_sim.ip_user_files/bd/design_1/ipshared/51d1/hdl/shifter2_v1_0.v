
`timescale 1 ns / 1 ps

	module shifter2_v1_0 #
	(
                parameter integer TDATA_WIDTH                   = 32,


		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= TDATA_WIDTH,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= TDATA_WIDTH

	)
	(
		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready,

                //debug output
                output wire [1 : 0] state
	);
        // states definition for state machine
        parameter [1:0] IDLE = 2'b00,
                        SLAVE_READ = 2'b01,
                        MASTER_WRITE = 2'b10,
                        DONE = 2'b11;
        // state variable
        reg [1:0] reg_state;
        assign state = reg_state;

        //output drivers
        reg tvalid_out;
        assign m00_axis_tvalid = tvalid_out;
        reg tlast_out;
        assign m00_axis_tlast = tlast_out;
        reg tready_out;
        assign s00_axis_tready = tready_out;

        reg [TDATA_WIDTH-1 : 0] tdata_out;
        assign m00_axis_tdata = tdata_out;

        assign m00_axis_tstrb = {(TDATA_WIDTH/8){1'b1}};

        //we assume master and slave ahve common clock and common reset
        

        always @(posedge m00_axis_aclk)
        begin
            if(!m00_axis_aresetn)
            begin
                reg_state <= IDLE;
                tvalid_out <= 1'b0;
                tlast_out <= 1'b0;
                tready_out <= 1'b0;
                tdata_out <= {(TDATA_WIDTH){1'b0}};
            end
            else
                case(reg_state)
                    IDLE:
                    begin
                        reg_state <= IDLE;
                        tvalid_out <= 1'b0;
                        tlast_out <= 1'b0;
                        tready_out <= 1'b0;
                        tdata_out <= {(TDATA_WIDTH){1'b0}};
                        // no need to check reset as this is already done
                        // before case statement
                        if(s00_axis_tvalid)
                        begin
                            reg_state <= SLAVE_READ;
                            tready_out <= 1'b1;
                        end
                    end
                    SLAVE_READ:
                    begin
                        //if valid is already high then read the value,
                        //otherwise stay in state to wait for it
                        if(s00_axis_tvalid)
                        begin
                            tdata_out <= s00_axis_tdata >> 1;
                            tvalid_out <= 1'b1;
                            // if ready is already high then the master can
                            // already write this same cycle. then stay in
                            // this state, otherwise go to state of
                            // master_write, forcing at least one cycle wait
                            // if tlast is asserted then go to done, no wait
                            // needed
                            if(s00_axis_tlast)
                            begin
                                reg_state = IDLE;
                                tlast_out <= 1'b1;
                            end
                            else
                            begin
                                if(!m00_axis_tready)
                                begin
                                    // we are waiting for the downstream to
                                    // read our write so stop reading in from
                                    // upstream
                                    reg_state = MASTER_WRITE;
                                    tready_out <= 1'b0;
                                end
                            end
                        end
                        else
                        begin
                            //pause output since we have no new info in
                            tvalid_out <= 0'b0;
                        end
                    end
                    MASTER_WRITE:
                    begin
                        // wait for slave at the other end to assert it is
                        // reading then go back to read state
                        if(m00_axis_tready)
                        begin
                            reg_state <= SLAVE_READ;
                            tready_out <= 1'b1;
                        end
                    end
//                    DONE:
//                    begin
//                        //wait in this state until reset, reset is detected
//                        //before switch case so this case is essentially empty
//                    end
                endcase

        end


	endmodule
