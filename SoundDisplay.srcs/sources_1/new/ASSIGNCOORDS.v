`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2020 15:21:35
// Design Name: 
// Module Name: ASSIGNCOORDS
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

module ASSIGN_COORDINATE( output [6:0] coordx , output [6:0] coordy, input [12:0] coordinate

    );
    assign coordx = (coordinate % 96);
    assign coordy = (coordinate / 96);
    
endmodule

