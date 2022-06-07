//Name: Seongjae Shin
//Assignment: Final Project
//Purpose: Test function
//Date: May 6, 2021
//Module: Final_test
//Date of Last Update: Mar 6, 2021


module Final_test;
  // set testbench reg and wire
  reg S_tb,X_tb,U_tb;
  wire [2:0] Z_tb;
  
  // reacll hw11_main to test
  proj_main test1(.S(S_tb),.X(X_tb),.U(U_tb),.Z(Z_tb));
  
  // set initial values of each input
  initial
    begin
      // Initially OFF
      U_tb=0;
      S_tb=0;
    end
  
  // Change 0 to 1 or 1 to 0 per given time
  always #1 U_tb=!U_tb;
	always
      begin
        //OFF->ON
		#1 S_tb=1;
        //ON->First
        #1 X_tb=0;
        //First->Second
        #1 X_tb=1;
        //Second->Third
        #1 X_tb=0;
        //Third->Fourth
        #1 X_tb=0;
        //Fourth->Lock
        #1 X_tb=0;
        //Lock->ON
        #1 X_tb=0;
        //ON->Trigger
        #1 X_tb=1;
        //Tigger->Error
        #1 X_tb=1;
        //Error->Trigger
        #1 X_tb=1;
        //Trigger->T-First
        #1 X_tb=0;
        //T-First->T-Second
        #1 X_tb=1;
        //T-Second->T-Third
        #1 X_tb=0;
        //T-third->ON
        #1 X_tb=0;
      	//ON->First
        #1 X_tb=0;
        //First->Second
        #1 X_tb=1;
        //Second->Third
        #1 X_tb=0;
        //Third->Foruth
        #1 X_tb=0;
        //Fourth->Unlock
        #1 X_tb=0;
        //Unlock->ON
        #1 X_tb=0;
      end
  
  // Set table, names and values of columns
  initial
    begin
      $display("S\t\X\t\U\t\tZ");
      $monitor("%b\t%b\t%b\t%b",S_tb,X_tb,U_tb,Z_tb);
    end
  
  // set waveform
  initial
    begin
      $dumpfile("Final.vcd");
      $dumpvars;
    end
  
  // set total timeer
  initial
    #20 $finish;
endmodule