module alu_controller_testbench();
  reg aluop2,aluop1,aluop0,f3,f2,f1,f0;
  wire [3:0] gout;
  
  initial
  begin
    aluop2=0; aluop1=0; aluop0=0; #10;
    aluop2=0; aluop1=0; aluop0=1; #10;
    aluop2=0; aluop1=1; aluop0=1; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=0; f0=0; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=0; f0=1; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=0; f0=0; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=1; f0=0; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=1; f2=0; f1=1; f0=0; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=1; f0=1; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=1; f0=0; #10;
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=1; f0=1; #10;
    aluop2=1; aluop1=1; aluop0=1; f3=0;
    $finish;
  end
alucont alucontroller(aluop2,aluop1,aluop0,f3,f2,f1,f0,gout);
endmodule