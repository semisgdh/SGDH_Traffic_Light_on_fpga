//////////////////////////////////////////////////////////////////////////////////
// Company: semisgdh
// Engineer: Matbi / SGDH
//
// Create Date:
// Design Name: sgdh_traffic_light_top_tb
// Module Name: sgdh_traffic_light_top_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description: sgdh_traffic_light_top_tb Example
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`include "common_defines.vh"
module sgdh_traffic_light_top_tb;
    reg clk;
    reg areset;
    reg switch_en_c0;
    wire [2:0] light_c0;

    // Instantiate the traffic_light module
    sgdh_traffic_light_top_fpga u_sgdh_traffic_light_top_0 (
        .sysclk(clk),
        .sw({switch_en_c0,areset}),
        .led(light_c0)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test sequence
    initial begin
//        // Dump the waveform // LRM Chapter 18. Value change dump (VCD) files.
//        $dumpfile("sgdh_traffic_light.vcd");
//        $dumpvars(0, sgdh_traffic_light_top_tb);

        // Initialize signals
        areset = 1; switch_en_c0 = 1;

        // Reset the system
        #20 areset = 0;

        // Let the simulation run for a while
        #500;
        switch_en_c0 = 0;
        #500;
        // Finish the simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time: %0d, Light_c0: %b, Switch_en_c0: %b", $time, light_c0, switch_en_c0);
    end
endmodule
