//Name: Seongjae Shin
//Assignment: Final Project
//Purpose: Create a security system
//Date: May 6, 2021
//Module: proj_main, out_help
//Date of Last Update: May 6, 2021

// the code is 0100
module proj_main(S,X,U,Z);
  // S is swtich
  // X is user input (password entered)
  // U is update function for program. This always changes 0 to 1 or 1 to 0 to update program
  input S,X,U;
  // Z is 3 bits vertorization. Z[2] = Switch ON/OFF, Z[1] = Lock/Unlcok, Z[0] = Trigger/Not Trigger
  output [2:0]Z;
  
  // PS is present state
  reg [3:0] PS;
  // L is lock
  // if L = 0, it is unlocked, if L=1, it is locked
  reg L;
  
  // parameters for lock
  parameter unlock=1'b0, lock=1'b1;
  // parameters for present state
  parameter Ab=4'b0000,Bb=4'b0001,Cb=4'b0010,Db=4'b0011,Eb=4'b0100,Fb=4'b0101,Gb=4'b0110,Hb=4'b0111,Ib=4'b1000,Jb=4'b1001,Kb=4'b1010,Lb=4'b1011,Mb=4'b1100;
  // initially it is OFF and unlock
  initial PS=4'b0000;
  initial L=1'b0;
  // update when U is changed
  always@(U)
    // checking present state
    case(PS)
      //OFF
      Ab:if(S==1) PS=Bb;
      //ON
      Bb:if(S==0) PS=Ab; else if(S==1 && X==0) PS=Cb; else if(S==1 && X==1) PS=Ib;
      //First
      Cb:if(X==0) PS=Ib; else if(X==1) PS=Db;
      //Second
      Db:if(X==0) PS=Eb; else if(X==1) PS=Ib;
      //Third
      Eb:if(X==0) PS=Fb; else if(X==1) PS=Ib;
      //Fourth
      Fb:if(L==0) PS=Hb; else if(L==1) PS=Gb;
      //Unlock
      Gb:begin
        L=unlock;
        PS=Bb;
      end
      //Lock
      Hb:begin
        L=lock;
        PS=Bb;
      end
      //Trigger
      Ib:if(X==0) PS=Jb; else if(X==1) PS=Mb;
      //T-First
      Jb:if(X==0) PS=Mb; else if(X==1) PS=Kb;
      //T-Second
      Kb:if(X==0) PS=Lb; else if(X==1) PS=Mb;
      //T-Third
      Lb:PS=Bb;
      //Error
      Mb:PS=Ib;
    endcase
  
  // After change the present state based on the input, find the output corresponding state
  out_help out1(L,PS,Z);
  
endmodule

// helping function of output
module out_help(A,B,Z);
  // A is L, which is lock/unlock
  input A;
  // B is present state
  input [3:0]B;
  // Z is output of this system
  output [2:0] Z;
  // F is reg for output
  reg [2:0] F;
  
  // 6 enable outputs
  parameter F1=3'b000,F2=3'b010,F3=3'b100,F4=3'b110,F5=3'b101,F6=3'b111;
  // parameters for states
  parameter Ab=4'b0000,Bb=4'b0001,Cb=4'b0010,Db=4'b0011,Eb=4'b0100,Fb=4'b0101,Gb=4'b0110,Hb=4'b0111,Ib=4'b1000,Jb=4'b1001,Kb=4'b1010,Lb=4'b1011,Mb=4'b1100;
  // update output when state is changed
  always@(B)
    // check present state
    case(B)
      //OFF
      Ab:if(A==0) F=F1; else if(A==1) F=F2;
      //ON
      Bb:if(A==0) F=F3; else if(A==1) F=F4;
      //First
      Cb:if(A==0) F=F3; else if(A==1) F=F4;
      //Second
      Db:if(A==0) F=F3; else if(A==1) F=F4;
      //Third
      Eb:if(A==0) F=F3; else if(A==1) F=F4;
      //Fourth
      Fb:if(A==0) F=F3; else if(A==1) F=F4;
      //Unlock
      Gb:F=F3;
      //Lock
      Hb:F=F4;
      //Trigge
      Ib:if(A==0) F=F5; else if(A==1) F=F6;
      //T-First
      Jb:if(A==0) F=F5; else if(A==1) F=F6;
      //T-Second
      Kb:if(A==0) F=F5; else if(A==1) F=F6;
      //T-Third
      Lb:if(A==0) F=F5; else if(A==1) F=F6;
      //Error
      Mb:if(A==0) F=F5; else if(A==1) F=F6;
    endcase
  //assign reg F value into Z
  assign Z = F;
        
endmodule