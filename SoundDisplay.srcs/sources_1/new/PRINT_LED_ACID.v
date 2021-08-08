`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2020 17:26:34
// Design Name: 
// Module Name: PRINT_LED_ACID
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


module PRINT_LED_ACID(input clock,input [6:0]volume,
    input[6:0]x, input[6:0]y,input border , input [1:0]part , output reg [15:0] color
    
    );
    
    always@ (posedge clock) 
    begin
        case(border) // set border to 1 pixel
            1'b0:
                begin
                    if(y==0 && part!=2 || y==63 && part!=2)
                    begin
                        color = 16'hD01F; // set to BLACK
                    end
                    else if(x==0 && part!=2 || x==95 && part!=2)
                    begin
                        color = 16'hD01F; // set to white , all 1
                    end
                    else if(y>0 && y == (63-(volume*4)))
                    begin
                        color = 16'hFFE0;
                    end
                    else if(x > 37 && x < 57 && y > 0 && y < 21 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET BLUE
                    begin
                        color = 16'h029F;
                    end
                    else if(x > 37 && x < 57 && y > 20 && y < 41 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET PURPLE
                    begin
                        color = 16'hD01F;
                    end
                    else if(x > 37 && x < 57 && y > 40 && y < 63 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET RED
                    begin
                        
                        color = 16'b1111100000000000;
                    end
                    else if((y % 4)==0) 
                    begin
                        color = 16'hFFE0; // set other pixels to BLACK
                    end        
                    else
                    begin
                        color = 16'hFFE0; // SET ALL OTHER COLORS TO BLACK
                    end              
                end    
                
            1'b1: // SET BORDER TO 3 PIXEL
                    begin
                        if(y==0 && part!=2 || y==1 && part!=2 || y==2&& part!=2 || y==61 && part!=2 || y==62 && part!=2 || y==63 && part!=2)
                        begin
                            color = 16'hD01F; // set to GREEN , all 1
                        end
                        else if(x==0 && part!=2 || x==1 && part!=2 || x==2 && part!=2 || x==93 && part!=2 || x==94 && part!=2 || x==95 && part!=2)
                        begin
                            color = 16'hD01F; // set to white , all 1
                        end
                        else if(y>2 && y == (60-(volume*4)))
                        begin
                            color = 16'hFFE0;
                        end
                        else if(x > 37 && x < 57 && y > 2 && y < 20 && (y % 4)!=0 && part!=3 && y > (60-(volume*4))) // SET BLUE
                        begin
 
                            color = 16'h029F;
                        end
                        else if(x > 37 && x < 57 && y > 19 && y < 41 && (y % 4)!=0 && part!=3 && y > (60-(volume*4))) // SET PURP
                        begin
                            color = 16'hD01F;
                        end
                        else if(x > 37 && x < 57 && y > 40 && y < 61 && (y % 4)!=0 && part!=3 && y > (60-(volume*4))) // SET RED
                        begin
                            color = 16'b1111100000000000;
                        end  
                        else if((y % 4)==0) 
                        begin
                            color = 16'hFFE0; // set other pixels to BLACK
                        end 
                        else
                        begin
                            color = 16'hFFE0; // set other pixels to BLACK                       
                        end                  
                    end               
            default: // we set default to be 1 pixel border
                        begin
                            if(y==0 && part!=2 || y==63 && part!=2)
                            begin
                                color = 16'hD01F; // set to GREEN , all 1
                            end
                            else if(x==0 && part!=2 || x==95 && part!=2)
                            begin
                                color = 16'hD01F; // set to white , all 1
                            end
                            else if(y>0 && y == (63-(volume*4)))
                            begin
                                color = 16'hFFE0;
                            end
                            else if(x > 37 && x < 57 && y > 0 && y < 21 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET BLUE
                            begin                         
                                color = 16'h029F;
                            end
                            else if(x > 37 && x < 57 && y > 20 && y < 41 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET PURP
                            begin
                                color = 16'hD01F;
                            end
                            else if(x > 37 && x < 57 && y > 40 && y < 63 && (y % 4)!=0 && part!=3 && y > (63-(volume*4))) // SET RED
                            begin                              
                                color = 16'b1111100000000000;
                            end 
                            else if((y % 4)==0) 
                            begin
                                color = 16'hFFE0; // set other pixels to BLACK
                            end       
                            else
                            begin
                                color = 16'hFFE0; // SET ALL OTHER COLORS TO BLACK
                            end              
                        end 
              endcase   
    end
    
    
    
endmodule

