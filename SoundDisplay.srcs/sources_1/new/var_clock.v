`timescale 1ns / 1ps

module var_clock(input CLOCK, [32:0]m, output reg myclk = 0);
    reg [12:0] count = 0;
    
    always @ (posedge CLOCK)
    begin   //2499 for 20kHz, 7 for 6.25MHz
        count <= (count == m) ? 0 : count + 1;
        myclk <= (count == 0) ? ~myclk : myclk;
    end
endmodule
