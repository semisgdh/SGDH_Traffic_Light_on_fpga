//////////////////////////////////////////////////////////////////////////////////
// Company: semisgdh
// Engineer: Matbi / SGDH
//
// Create Date:
// Design Name: sgdh_traffic_light_core
// Module Name: sgdh_traffic_light_core
// Project Name:
// Target Devices:
// Tool Versions:
// Description: sgdh_traffic_light_core 
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`include "common_defines.vh"

module sgdh_traffic_light_core #(
// Timing parameters (for simulation purposes, you can adjust as needed)
    parameter RED_TIME = 5, 
    parameter YELLOW_TIME = 2, 
    parameter GREEN_TIME = 4
) (
    input wire clk,
    input wire areset,
    input wire switch_en,
    output reg [2:0] light // 3-bit output to represent red, yellow, green lights
);
// Include function definitions
`include "functions.vh"

initial begin  // It is not synthesized.
    // No assert function in Verilog. SV has assert function.
//    assert(RED_TIME > 0);
//    assert(YELLOW_TIME > 0);
//    assert(GREEN_TIME > 0);
    if(RED_TIME <= 0 || YELLOW_TIME <= 0 || GREEN_TIME <= 0) begin
        $display("Error in %m: TIME Setting must be larger than 0");
        $finish;
    end
end

// Onehot encoding
localparam RED = 3'b100;
localparam YELLOW = 3'b010;
localparam GREEN = 3'b001;

// State encoding
localparam S_RED = 2'b00;
localparam S_GREEN = 2'b01;
localparam S_YELLOW = 2'b10;
// State and timer registers
reg [1:0] state, n_state; // reduced FSM bits
reg [`TIMER_BIT_WIDTH-1:0] timer, n_timer;
reg [2:0] n_light;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_RED;
        timer <= 1; // initial value
        light <= RED;
    end else begin
        state <= n_state;
        timer <= n_timer;
        // Output logic
        light <= n_light;
    end
end

always @(*) begin
    // Prevent Latch
    n_state = state;
    n_timer = timer;
    n_light = light;

    if (switch_en) begin
        if (timer == 1) begin
            case (state)
                S_RED: begin
                    n_state = S_GREEN;
                    n_timer = GREEN_TIME;
                    n_light = GREEN;
                end
                S_GREEN: begin
                    n_state = S_YELLOW;
                    n_timer = YELLOW_TIME;
                    n_light = YELLOW;
                end
                S_YELLOW: begin
                    n_state = S_RED;
                    n_timer = RED_TIME;
                    n_light = RED;
                end
            endcase
        end else begin
            n_timer = decrement(timer); // Using the included function same as "timer - 1". For study
        end
    end else begin
        n_light = 0;
    end
end
endmodule

