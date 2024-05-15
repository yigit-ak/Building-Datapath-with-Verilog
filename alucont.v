module alucont(aluop2,aluop1,aluop0,f3,f2,f1,f0,gout);//Figure 4.12 
input aluop2,aluop1,aluop0,f3,f2,f1,f0;
output [3:0] gout; // changed the alu control to be 4 bits instead of 3
reg [3:0] gout;

always @(aluop2 or aluop1 or aluop0 or f3 or f2 or f1 or f0)
begin
if (~(aluop2|aluop1|aluop0))  gout=4'b0010; // load or store
else if (~(aluop2|aluop1)&aluop0) gout=4'b0110; // beq or blezal
else if (~(aluop2)&aluop1&aluop0)gout=4'b1100;
if(aluop2)//R-type
begin
	if (~(f3|f2|f1|f0))gout=4'b0010; 	//function code=0000,ALU control=0010 (add)
	else if (~(aluop1)&f1&f3)gout=4'b0111;			//function code=1x1x,ALU control=0111 (set on less than)
	else if (~(aluop1)&~(f3)&~(f2)&f1&~(f0))gout=4'b0110;		//function code=0010,ALU control=0110 (sub)
	else if (f2&f0&~(f1)&~(f3))gout=4'b0001;			//function code=0101,ALU control=0001 (or)
	else if (~(f3)&f2&~(f1)&~(f0))gout=4'b0000;		//function code=0100,ALU control=0000 (and)
	else if (~(f3)&f2&f1&f0)gout=4'b1001;  // function code=0111, ALU control=1001 (nor)
	else if (~(f3)&f2&f1&~(f0))gout=4'b1101; // function code=0110, ALU control=1101 (xor)
	else if (~(f3)&~(f2)&f1&f0)gout=4'b1101; //fucntion code=0011, ALU control=1101 (jmxor)
	else if (aluop1&~(aluop0)&f3)gout=4'b0100; // function code=1xxx, ALU control=0100 (andi)
	else if (aluop1&aluop0&~(f3))gout=4'b1111; // function code=0xxx, ALU control=1111 (brv) NO OPERATION
	  
end
end
endmodule

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
    aluop2=1; aluop1=0; aluop0=0; f3=0; f2=0; f1=1; f0=0; #10; // CHECK
    aluop2=1; aluop1=1; aluop0=0; f3=1; #10;
    aluop2=1; aluop1=1; aluop0=1; f3=0;
    $finish;
  end
alucont alucontroller(aluop2,aluop1,aluop0,f3,f2,f1,f0,gout);
endmodule
