module sp_in(
    input Pbutton,
    input SP_C,
    output SP_Out
    );
    
    wire DFF_one_O, DFF_two_O;
    dff dev1(SP_C, Pbutton, DFF_one_O);
    dff dev2(SP_C, DFF_one_O, DFF_two_O);
    assign SP_Out = DFF_one_O & ~DFF_two_O;
    
endmodule

module dff(input DFF_CLOCK, D, output reg Q = 0);  
     always @ (posedge DFF_CLOCK) begin        
      Q <= D;    
       end 
 endmodule 
