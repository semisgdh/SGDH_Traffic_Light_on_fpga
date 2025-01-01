`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/01 11:49:11
// Design Name: 
// Module Name: sgdh_traffic_light_top_fpga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sgdh_traffic_light_top_fpga(
    input sysclk,
    input [1:0] sw,
    output [2:0] led // 3-bit output to represent red, yellow, green lights
    );
    
    // Instantiate the traffic_light module
    sgdh_traffic_light_top #(
        .RED_TIME_C0(5 * 125000000), // Zybo Z7 sysclk freq is 125MHz and real time unit is sec.
        .YELLOW_TIME_C0(1 * 125000000),
        .GREEN_TIME_C0(2 * 125000000),
        .RED_TIME_C1(0),  // No generate core1
        .YELLOW_TIME_C1(0),
        .GREEN_TIME_C1(0)
    ) u_sgdh_traffic_light_top_0 (
        .clk(sysclk),
        .areset(sw[0]),
        .switch_en_c0(sw[1]),
        .switch_en_c1(1'b0),
        .light_c0(led),
        .light_c1()
    );
endmodule
