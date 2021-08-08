`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2020 11:07:21 PM
// Design Name: 
// Module Name: ss_indicator
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


module ss_indicator(
    input [7 : 0] ss_state1,
    input [7 : 0] ss_state2,
    input [7 : 0] ss_state3,
    input [7 : 0] ss_state4,
    input slow_clock,
    output reg [3:0] anode_p,
    output reg [7:0] seven_seg
    );
    
    reg [2 : 0] count = 0;
    
    always @ (posedge slow_clock) begin
        case(count)
        3'd0: begin
        seven_seg <= ss_state4;
        anode_p <= 4'b0111;
        count <= count + 1;
        end
        3'd1: begin
        seven_seg <= ss_state3;
        anode_p <= 4'b1011;
        count <= count + 1;
        end        
        3'd2: begin
        seven_seg <= ss_state2;
        anode_p <= 4'b1101;
        count <= count + 1;
        end
        3'd3: begin
        seven_seg <= ss_state1;
        anode_p <= 4'b1110;
        count <= count + 1;
        end
        3'd4: begin   
        count <= 0;
        end             
        endcase
    end
    
endmodule
