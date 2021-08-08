`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 04:35:10 PM
// Design Name: 
// Module Name: singlepulse
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


module singlepulse(
    input DFF_CLOCK,
    input D,
    output singlepulse
    );
    wire a;
    wire b;
    wire resetclock;
    
    reset_clock dev0(DFF_CLOCK,resetclock);
    dff md0 (resetclock, D, a);
    dff md1 (resetclock, a, b);
    assign singlepulse = a & ~b;
endmodule
