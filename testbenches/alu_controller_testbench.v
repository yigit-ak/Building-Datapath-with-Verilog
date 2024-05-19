module alu_controller_testbench();
  reg aluop2,aluop1,aluop0,f3,f2,f1,f0;
  wire [3:0] gout;
  
  initial
  begin
    // Monitor changes and display the values
    $monitor("ALUOP: %b%b%b, FUNC: %b%b%b%b -> GOUT: %04b", aluop2, aluop1, aluop0, f3, f2, f1, f0, gout);
    
    aluop2=0; aluop1=0; aluop0=0; #10;
    $display("ALUOP is LOAD/STORE (%b%b%b) -> ALU Operation is ADD (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=0; aluop1=0; aluop0=1; #10;
    $display("ALUOP is BEQ/BLEZAL (%b%b%b) -> ALU Operation is SUBTRACT (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=0; aluop1=1; aluop0=1; #10;
    $display("ALUOP is NANDI (%b%b%b) -> ALU Operation is NAND (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=0; f0=0; #10;
    $display("ALUOP is AND (%b%b%b) -> ALU Operation is AND (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=0; f0=1; #10;
    $display("ALUOP is OR (%b%b%b) -> ALU Operation is OR (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=0; f0=0; #10;
    $display("ALUOP is ADD (%b%b%b) -> ALU Operation is ADD (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=1; f0=0; #10;
    $display("ALUOP is SUBTRACT (%b%b%b) -> ALU Operation is SUBTRACT (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=1; f2=0; f1=1; f0=0; #10;
    $display("ALUOP is SET ON LESS THAN (%b%b%b) -> ALU Operation is SET ON LESS THAN (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=1; f0=1; #10;
    $display("ALUOP is NOR (%b%b%b) -> ALU Operation is NOR (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=1; f1=1; f0=0; #10;
    $display("ALUOP is XOR (%b%b%b) -> ALU Operation is XOR (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=1; f0=1; #10;
    $display("ALUOP is JMXOR (%b%b%b) -> ALU Operation is XOR (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    
    aluop2=1; aluop1=1; aluop0=1; f3=0; #10;
    $display("ALUOP is BRV (%b%b%b) -> ALU Operation is NO OPERATION (%04b)\n",aluop2,aluop1,aluop0,
    gout);
    $finish;
  end
alucont alucontroller(aluop2,aluop1,aluop0,f3,f2,f1,f0,gout);
endmodule