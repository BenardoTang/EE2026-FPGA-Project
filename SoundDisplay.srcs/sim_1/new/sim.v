`timescale 1ns / 1ps
module sim();
    reg CLOCK; wire LED;
    
    clk20kHz dut (CLOCK, LED);
    
    initial begin
        CLOCK = 0;
    end
    
    always begin
     #5 CLOCK = ~CLOCK;
    end
endmodule