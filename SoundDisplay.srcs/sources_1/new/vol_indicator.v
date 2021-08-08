`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2020 04:23:17 PM
// Design Name: 
// Module Name: vol_indicator
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


module vol_indicator(
    input [11:0]volume,
    input slow_clock,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input button_in,
    output reg [15:0]led,
    output reg [7:0]seven_seg1,
    output reg [7:0]seven_seg2,
    output reg [7:0]seven_seg3,
    output reg [7:0]seven_seg4,
    output reg [3:0]state_indicator = 0,
    output reg [1:0]win_condition = 0,
    output reg [1:0]image_state = 0
    );
    
    reg [2 : 0] game_state = 0;
    reg [3 : 0] sev_seg; 
    reg [7 : 0] seg;
    reg [3 : 0] ss_count1 = 0;
    reg [3 : 0] ss_count2 = 0;
    reg [3 : 0] ss_count3 = 0;
    reg [3 : 0] ss_count4 = 0;
    
    always @ (*) begin
        case(sev_seg)
        4'd0: seg = 8'b10001110; //F
        4'd1: seg = 8'b10010000; //G
        4'd2: seg = 8'b10001001; //H
        4'd3: seg = 8'b11001111; //I
        4'd4: seg = 8'b11100001; //J
        4'd5: seg = 8'b10001001; //K
        4'd6: seg = 8'b11000111; //L
        4'd7: seg = 8'b11101010; //M
        4'd8: seg = 8'b10101011; //N
        4'd9: seg = 8'b11000000; //O
        endcase
    end
    
    always @ (posedge slow_clock) begin
        case(game_state)
        3'd1: begin
            if (button_in == 1) begin
                ss_count4 <= (ss_count4 == 4'd9)? 4'd0 : (ss_count4 + 1);
            end
        end
        3'd2: begin
            if (button_in == 1) begin
                ss_count3 <= (ss_count3 == 4'd9)? 4'd0 : (ss_count3 + 1);
            end
        end
        3'd3: begin
            if (button_in == 1) begin
                ss_count2 <= (ss_count2 == 4'd9)? 4'd0 : (ss_count2 + 1);
            end
        end
        3'd4: begin
            if (button_in == 1) begin
                ss_count1 <= (ss_count1 == 4'd9)? 4'd0 : (ss_count1 + 1);
            end
        end
        endcase
        if (volume < 2080 && sw1 == 0) begin //0
            led <= 16'b0000000000000001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            seven_seg1 <= 8'b11000000;
            seven_seg2 <= 8'b11000000;
            state_indicator = 0;
        end
        else if (volume > 2080 && volume < 2100 && sw1 == 0) begin //1
            led <= 16'b0000000000000011;
            seven_seg1 <= 8'b11111001;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 1;
        end
        else if (volume > 2100 && volume < 2120 && sw1 == 0) begin //2
            led <= 16'b0000000000000111;
            seven_seg1 <= 8'b10100100;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 2;
        end
        else if (volume > 2120 && volume < 2140 && sw1 == 0) begin //3
            led <= 16'b0000000000001111;
            seven_seg1 <= 8'b10110000;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 3;
        end
        else if (volume > 2140 && volume < 2160 && sw1 == 0) begin //4
            led <= 16'b0000000000011111;
            seven_seg1 <= 8'b10011001;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 4;
        end
        else if (volume > 2160 && volume < 2180 && sw1 == 0) begin //5
            led <= 16'b0000000000111111;
            seven_seg1 <= 8'b10010010;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 5;
        end
        else if (volume > 2180 && volume < 2200 && sw1 == 0) begin //6
            led <= 16'b0000000001111111;
            seven_seg1 <= 8'b10000010;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 6;
        end
        else if (volume > 2200 && volume < 2220 && sw1 == 0) begin //7
            led <= 16'b0000000011111111;
            seven_seg1 <= 8'b11111000;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 7;
        end
        else if (volume > 2220 && volume < 2240 && sw1 == 0) begin //8
            led <= 16'b0000000111111111;
            seven_seg1 <= 8'b10000000;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 8;
        end
        else if (volume > 2240 && volume < 2260 && sw1 == 0) begin //9
            led <= 16'b0000001111111111;
            seven_seg1 <= 8'b10010000;
            seven_seg2 <= 8'b11000000;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 9;
        end
        else if (volume > 2260 && volume < 2280 && sw1 == 0) begin //10
            led <= 16'b0000011111111111;
            seven_seg1 <= 8'b11000000;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 10;
        end
        else if (volume > 2280 && volume < 2300 && sw1 == 0) begin //11
            led <= 16'b0000111111111111;
            seven_seg1 <= 8'b11111001;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 11;
        end
        else if (volume > 2300 && volume < 2320 && sw1 == 0) begin //12
            led <= 16'b0001111111111111;
            seven_seg1 <= 8'b10100100;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 12;
        end
        else if (volume > 2320 && volume < 2340 && sw1 == 0) begin //13
            led <= 16'b0011111111111111;
            seven_seg1 <= 8'b10110000;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 13;
        end
        else if (volume > 2340 && volume < 2360 && sw1 == 0) begin //14
            led <= 16'b0111111111111111;
            seven_seg1 <= 8'b10011001;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 14;
        end
        else if (volume > 2360 && volume < 2380 && sw1 == 0) begin //15
            led <= 16'b1111111111111111;
            seven_seg1 <= 8'b10010010;
            seven_seg2 <= 8'b11111001;
            seven_seg3 <= 8'b11111111;
            seven_seg4 <= 8'b11111111;
            state_indicator = 15;
        end
        else if (sw1 == 1 && game_state == 0 && button_in == 1) begin //mini game
            game_state <= 3'd1;
        end
        else if (sw1 == 1 && game_state == 1 && ss_count4 == 4'd4 && sw2 == 1) begin
            game_state <= 3'd2;
        end
        else if (sw1 == 1 && game_state == 2 && ss_count3 == 4'd9 && sw3 == 1) begin
            game_state <= 3'd3;
        end
        else if (sw1 == 1 && game_state == 3 && ss_count2 == 4'd4 && sw4 == 1) begin
            game_state <= 3'd4;
        end
        else if (sw1 == 1 && game_state == 4 && ss_count1 == 4'd9 && sw5 == 1) begin
            game_state <= 3'd5;
        end
        else if (sw1 == 1 && game_state == 0) begin
            seven_seg1 <= 8'b10010010;
            seven_seg2 <= 8'b10010010;
            seven_seg3 <= 8'b11000000;
            seven_seg4 <= 8'b10000011;
            image_state <= 1;
            //display original image of jotaro walking towards dio.
            end
        else if (sw1 == 1 && game_state == 1) begin
            image_state <= 2;
            sev_seg <= ss_count4[3:0];
            seven_seg1 <= 8'b10001110;
            seven_seg2 <= 8'b10001110;
            seven_seg3 <= 8'b10001110;
            seven_seg4 <= seg;
        end
        else if (sw1 == 1 && game_state == 2) begin
            sev_seg <= ss_count3[3:0];
            seven_seg1 <= 8'b10001110;
            seven_seg2 <= 8'b10001110;
            seven_seg3 <= seg;
            seven_seg4 <= 8'b11100001;
        end            
        else if (sw1 == 1 && game_state == 3) begin
            sev_seg <= ss_count2[3:0];
            seven_seg1 <= 8'b10001110;
            seven_seg2 <= seg;
            seven_seg3 <= 8'b11000000;
            seven_seg4 <= 8'b11100001;
        end 
        else if (sw1 == 1 && game_state == 4) begin
            sev_seg <= ss_count1[3:0];
            seven_seg1 <= seg;
            seven_seg2 <= 8'b11100001;
            seven_seg3 <= 8'b11000000;
            seven_seg4 <= 8'b11100001;
        end
        else if (sw1 == 1 && game_state == 5) begin
            seven_seg1 <= 8'b11111111;
            seven_seg2 <= 8'b10101011;
            seven_seg3 <= 8'b11001111;
            seven_seg4 <= 8'b11010101;
            win_condition <= 1;
                if (volume < 2080) begin //0
                    led <= 16'b0000000000000001;
                    state_indicator = 0;
                end
                if (volume > 2080 && volume < 2100) begin //1
                    led <= 16'b0000000000000011;
                    state_indicator = 1;
                end
                if (volume > 2100 && volume < 2120) begin //2
                    led <= 16'b0000000000000111;
                    state_indicator = 2;
                end
                if (volume > 2120 && volume < 2140) begin //3
                    led <= 16'b0000000000001111;
                    state_indicator = 3;
                end
                if (volume > 2140 && volume < 2160) begin //4
                    led <= 16'b0000000000011111;
                    state_indicator = 4;
                end
                if (volume > 2160 && volume < 2180) begin //5
                    led <= 16'b0000000000111111;
                    state_indicator = 5;
                end
                if (volume > 2180 && volume < 2200) begin //6
                    led <= 16'b0000000001111111;
                    state_indicator = 6;
                end
                if (volume > 2200 && volume < 2220) begin //7
                    led <= 16'b0000000011111111;
                    state_indicator = 7;
                end
                if (volume > 2220 && volume < 2240) begin //8
                    led <= 16'b0000000111111111;
                    state_indicator = 8;
                end
                if (volume > 2240 && volume < 2260) begin //9
                    led <= 16'b0000001111111111;
                    state_indicator = 9;
                end
                if (volume > 2260 && volume < 2280) begin //10
                    led <= 16'b0000011111111111;
                    state_indicator = 10;
                end
                if (volume > 2280 && volume < 2300) begin //11
                    led <= 16'b0000111111111111;
                    state_indicator = 11;
                end
                if (volume > 2300 && volume < 2320) begin //12
                    led <= 16'b0001111111111111;
                    state_indicator = 12;
                end
                if (volume > 2320 && volume < 2340) begin //13
                    led <= 16'b0011111111111111;
                    state_indicator = 13;
                end
                if (volume > 2340 && volume < 2360) begin //14
                    led <= 16'b0111111111111111;
                    state_indicator = 14;
                end   
                if (volume > 2360 && volume < 2380) begin //15
                    led <= 16'b1111111111111111;
                    state_indicator = 15;
                end                                                                                                                                            
            end  
        end                              
        /*else begin
            led <= 16'b0000000000000000;
            seven_seg1 <= 8'b11000000;
            seven_seg2 <= 8'b11000000;
            state_indicator <= 0;*/
        //end
endmodule
