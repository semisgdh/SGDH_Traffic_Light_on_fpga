// functions.vh
`include "common_defines.vh"

function [`TIMER_BIT_WIDTH-1:0] decrement;
    input [`TIMER_BIT_WIDTH-1:0] value;
    begin
        decrement = value - 1;
    end
endfunction