`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): 
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input sw1,
input sw0,
input sw2,
input sw3,
input sw4,
input sw5,
input sw6,
input CLOCK, 
input pbc, pbl,pbr,pbu,pbd, // centre, left ,right,up buttons
input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
output [7:0]JC, // for display
output [15:0]led,
output [7:0]seg,
output [3:0]an
    // Delete this comment and include other inputs and outputs here
    );
    
    wire csout, out_6p25m, out_20k, out_SP, out_blink;
    wire pbcout,pblout,pbrout,pbuout,pbdout, frame_begin, sending_pixels, sample_pixel, teststate;
    wire [12:0] pixel_index;
    wire [3:0] volume;
    reg [3:0] volume_value; // volume stored to send to oled
    wire reset;
    wire [11:0] sample;
    wire [15:0] col_acid;
    wire [15:0] col_default;
    wire [15:0] col_water;
    reg [15:0] col=0;
    wire [15:0] col_ani;
    wire [15:0] col_ani2;
    wire [15:0] col_ani3;
    reg offstate = 0;
    wire [11:0]ledset;
    assign JC[2]=0;
    wire [6:0] x;
    wire [6:0]y;  
    reg toggleborder=0;
    reg [1:0]toggletheme=1;
    wire sclock;  
    wire SLOWCLOCK;
    reg [1:0]toggleparts=1;
    reg togglescreen=1;
    integer gametime=0;
    reg freezeframe=0; // create module that occurs one cycle later to collect value of vol AS LONG AS THIS IS ZERO
    wire volume_level; // LINKED TO FREEZEFRAME, SEE ABV
    wire [3:0] delay;
    reg [3:0] volume_lev;  
    reg [3:0] old_volume_lev=0;
    wire [15:0] col_image_1;
    wire [15:0] col_image_2;
    wire [15:0] col_image_3;
    wire [15:0] col_image_4;
     
    // Delete this comment and write your codes and instantiations here
    var_clock clk_6p25m (CLOCK, 7, out_6p25m);
    //var_clock clk_25k (CLOCK, 2499, out_20k);
    //var_clock clk_SP (CLOCK, 65100, out_SP);
    singlepulse pbcentre (CLOCK, pbc, pbcout);
    singlepulse pbleft (CLOCK, pbl, pblout);
    singlepulse pbright (CLOCK, pbr, pbrout);
    singlepulse pbup (CLOCK, pbu, pbuout);
  
    reset_clock fortoggling(CLOCK, sclock);
        
    ANIMATION pls(pixel_index[12:0],out_6p25m,4,col_ani[15:0]);
    ANIMATION_2 PLEASE(pixel_index[12:0] , out_6p25m,volume_value[3:0], col_ani2[15:0]);
    IMAGE_SEQUENCE PLEASEE(pixel_index[12:0] , out_6p25m,volume_value[3:0], col_ani3[15:0]);
    PRINT_LED_DEFAULT test1(out_6p25m,volume_value[3:0],x[6:0], y[6:0], toggleborder,toggleparts[1:0], col_default[15:0]);
    PRINT_LED_ACID test2(out_6p25m,volume_value[3:0],x[6:0], y[6:0], toggleborder,toggleparts[1:0], col_acid[15:0]);
    PRINT_LED_WATER test3(out_6p25m,volume_value[3:0],x[6:0], y[6:0], toggleborder,toggleparts[1:0], col_water[15:0]);
    IMAGEONE test12(pixel_index[12:0],out_6p25m,col_image_1[15:0]);
    IMAGEFOUR test1234(pixel_index[12:0],out_6p25m,col_image_4[15:0]);
    
    Oled_Display Oled (out_6p25m, reset, frame_begin, sending_pixels,
    sample_pixel, pixel_index[12:0], col[15:0], JC[0], JC[1], JC[3], JC[4], JC[5], JC[6],
    JC[7], teststate); 
    
    ASSIGN_COORDINATE xy(x[6:0] , y[6:0], pixel_index[12:0]); 
    

  //SOUND PORTION  

    wire [1:0] win_cond;
    wire [1:0] img_state;
    wire [2:0] b_select;
    wire [1:0] b_change;
    wire [7:0] sev_seg1;
    wire [7:0] sev_seg2;
    wire [7:0] sev_seg3;
    wire [7:0] sev_seg4;
    reg [11:0]max_vol = 0;
    reg [15:0]count = 0;
    assign JC[2]=0;
    // Delete this comment and write your codes and instantiations here
    var_clock clk_25k (CLOCK, 2499, out_20k);
    var_clock clk_SP (CLOCK, 65100, out_SP);
    var_clock clk_blinky (CLOCK, 200000000, out_blink);
    sp_in pbdown (pbd, out_20k, pbdout);
   Audio_Capture souncCap(CLOCK, out_20k, J_MIC3_Pin3, J_MIC3_Pin1,J_MIC3_Pin4,sample[11:0]);
        always @ (posedge out_20k) begin
            if (sample[11:0] > max_vol) begin
                max_vol <= sample[11:0];
            end
            if (count == 3500) begin
                count <= 0;
                max_vol <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
        vol_indicator dev1(max_vol[11:0], out_20k, sw2, sw3, sw4, sw5, sw6, pbdout, led[15:0], sev_seg1[7:0], sev_seg2[7:0], sev_seg3[7:0], sev_seg4[7:0], volume[3:0], win_cond[1:0], img_state[1:0]);
        ss_indicator dev2(sev_seg1[7:0], sev_seg2[7:0], sev_seg3[7:0], sev_seg4[7:0], out_20k, an[3:0], seg[7:0]); 
    //mutiplexer2_1 mux (sw,sample[11:0],max_vol[11:0],ledset[11:0]);



// case statements for oled
     always@(*)
         begin
         if(toggletheme ==1 && sw1==0 && sw0==0 && sw2==0)   
         begin
            col <= col_default;
         end
         else if(toggletheme ==2 && sw1==0 && sw0==0 && sw2==0)   
         begin
            col <= col_water;
         end
         else if(toggletheme ==3 && sw1==0 && sw0==0 && sw2==0)   
         begin
            col <= col_acid;
         end
         else if(sw1==1)   
         begin
            col <= col_ani2;
         end
         else if(sw0==1)   
         begin
            col <= col_ani;
         end
         else if(sw2==1 && img_state==1 && win_cond==0 && gametime==0)
         begin
            col <= col_image_1;
         end
         else if(sw2==1 && img_state==1 && win_cond==0 && gametime!=0)
         begin
            col <= col_image_4;
         end         
         else if(sw2==1 && win_cond==1)
         begin
            col <= col_ani3;
         end
         if(freezeframe == 0)
         begin
             volume_value = volume;
         end       
     end    
    always@(posedge out_6p25m)
    begin
        if(pbdout==1)
        begin
            gametime = gametime +1; 
        end
    end    
     always@(posedge sclock)
     begin
         if(pbrout==1)
         begin
             toggleborder = toggleborder +1;
         end
         else if(pblout==1)
         begin
             toggletheme = toggletheme +1;
             if(toggletheme==0)
             begin
                 toggletheme = 1;
             end
         end
         else if(pbcout==1)
         begin
             toggleparts = toggleparts +1; // 1= default, 2 = border off, 3 = vol bar off
             if(toggleparts==0)
             begin
                 toggleparts = 1;
             end
         end
         else if(pbuout==1)
         begin
             freezeframe = freezeframe +1; 
         end
     end    





endmodule