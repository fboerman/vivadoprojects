`timescale 1ns / 1ps

import axi4stream_vip_pkg::*;
import design_1_axi4stream_vip_0_0_pkg::*;
import design_1_axi4stream_vip_1_0_pkg::*;

// clock and reset
bit clk = 0, rst = 1;
// state output
bit[1:0] state;

// write transaction created by master VIP
axi4stream_transaction    wr_tran;
// Ready signal created by slave VIP when TREADY is High
axi4stream_ready_gen      ready_gen;


module axis_testbench();
design_1_wrapper UUT
(
    .aclk_0(clk),
    .aresetn_0(rst),
    .state_0(state)
);

// 50 MHZ clock
always #10ns clk = ~clk;

initial begin
    //reset the system
    rst = 0;
    #50ns;
    rst = 1;

end


// the actual test
initial begin
    // start the vip master agent
    design_1_axi4stream_vip_0_0_mst_t master_agent;
    design_1_axi4stream_vip_1_0_slv_t slave_agent;
    axi4stream_ready_gen ready_gen;
    
    master_agent = new("master vip agent", UUT.design_1_i.axi4stream_vip_master.inst.IF);
    slave_agent = new("slave vip agent", UUT.design_1_i.axi4stream_vip_slave.inst.IF);
    master_agent.start_master();
    slave_agent.start_slave();
    
    ready_gen = slave_agent.driver.create_ready("tready generator");
    ready_gen.set_ready_policy(XIL_AXI4STREAM_READY_GEN_OSC);
    ready_gen.set_low_time(2);
    ready_gen.set_high_time(6);
    slave_agent.driver.send_tready(ready_gen);

    // wait for reset to be release by the previous initial block
    wait (rst == 1'b1);
        #100ns;
    
     
    
   $display("initialization done, starting test");
   
   for (int i = 0; i<8; i++) begin       
       byte unsigned byte_data[];
       byte_data={<<byte{-1*(2**i)}};
   
       wr_tran = master_agent.driver.create_transaction("write transaction");
       wr_tran.set_id(i);
       wr_tran.set_data(byte_data);
       if(i == 7)
           wr_tran.set_last(1'b1);
       else
           wr_tran.set_last(1'b0);
       master_agent.driver.send(wr_tran);
       #400ns;
   end
   
   #400ns;
   
   for (int i = 0; i<8; i++) begin       
       byte unsigned byte_data[];
       byte_data={<<byte{-1*(2**i)}};
   
       wr_tran = master_agent.driver.create_transaction("write transaction");
       wr_tran.set_id(i);
       wr_tran.set_data(byte_data);
       if(i == 7)
           wr_tran.set_last(1'b1);
       else
           wr_tran.set_last(1'b0);
       master_agent.driver.send(wr_tran);
       #400ns;
   end
   
   #400ns;
   
   $stop;


end


endmodule


