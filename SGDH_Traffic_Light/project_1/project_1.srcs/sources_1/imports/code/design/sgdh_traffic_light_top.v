//////////////////////////////////////////////////////////////////////////////////
// Company: semisgdh
// Engineer: Matbi / SGDH
//
// Create Date:
// Design Name: sgdh_traffic_light_top
// Module Name: sgdh_traffic_light_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description: sgdh_traffic_light_top Example
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`include "common_defines.vh"

module sgdh_traffic_light_top #(
// Timing parameters (for simulation purposes, you can adjust as needed)
    parameter RED_TIME_C0       = 3, 
    parameter YELLOW_TIME_C0    = 1, 
    parameter GREEN_TIME_C0     = 2,
    parameter RED_TIME_C1       = 3, 
    parameter YELLOW_TIME_C1    = 1, 
    parameter GREEN_TIME_C1     = 2
) (
    input clk,
    input areset,
    input switch_en_c0,
    input switch_en_c1,
    output [2:0] light_c0, // 3-bit output to represent red, yellow, green lights
    output [2:0] light_c1 // For core 1
);

sgdh_traffic_light_core #(
    .RED_TIME       (RED_TIME_C0       ), 
    .YELLOW_TIME    (YELLOW_TIME_C0    ), 
    .GREEN_TIME     (GREEN_TIME_C0     )
) u_sgdh_traffic_light_core_0 (
    .clk            (clk),
    .areset         (areset),
    .switch_en      (switch_en_c0),
    .light          (light_c0) 
);

generate
  if ((RED_TIME_C1 == 0 ) || (YELLOW_TIME_C1 == 0) || (GREEN_TIME_C1 == 0)) begin 
    // no generate
    assign light_c1 = 0;
  end 
  else begin
  sgdh_traffic_light_core #(
    .RED_TIME       (RED_TIME_C1       ), 
    .YELLOW_TIME    (YELLOW_TIME_C1    ), 
    .GREEN_TIME     (GREEN_TIME_C1     )
) u_sgdh_traffic_light_core_1 (
    .clk            (clk),
    .areset         (areset),
    .switch_en      (switch_en_c1),
    .light          (light_c1) 
);
  end    
endgenerate

endmodule