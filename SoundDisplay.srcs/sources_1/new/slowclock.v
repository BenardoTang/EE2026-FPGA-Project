`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2020 16:48:46
// Design Name: 
// Module Name: slowclock
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


module reset_clock(
input clock,output reg slowclock
    );
    
    reg slowclock = 0;
    reg [31:0] count = 0;
    
    always@(posedge clock) begin
    count = count+1;
     if(count == 9888888)
     begin
     slowclock = ~slowclock;
     count = 0;
     end
    end 
     
endmodule
