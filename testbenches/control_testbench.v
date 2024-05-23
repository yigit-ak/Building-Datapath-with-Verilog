module controller_testbench();
  reg [5:0] in, funct;
  wire regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop2,aluop1,aluop0,jump,brv,jmxor,nandi,blezal,jalpc,baln;
  
  initial
  begin
    $monitor("Instruction opcode=%06b,RegDest=%b, ALUSrc=%b, MemToReg=%b, RegWrite=%b MemRead=%b, MemWrite=%b, Branch=%b, ALUOp=%b%b%b\nJump=%b, Brv=%b, JMXOR=%b, NANDI=%b, Blezal=%b, Jalpc=%b, Baln=%b",in,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop2,aluop1,aluop0,jump,brv,jmxor,nandi,blezal,jalpc,baln);
    
    in=6'b000000; funct=6'b100100;        #10;
    $display("R-Type\n"); 
    
    in=6'b000000; funct=6'b100011;        #10;
    $display("R-type and jmxor\n");
    
    in=6'b000000; funct=6'b010100;         #10;
    $display("R-type and brv\n");
    
    in=6'b100011;         #10;
    $display("Load\n");   
    
    in=6'b101011;         #10;
    $display("Store\n");  
    
    in=6'b000100;         #10;
    $display("beq\n");    
    
    in=6'b010000;         #10;
    $display("NANDI\n");  
    
    in=6'b100100;         #10;
    $display("Blezal\n"); 
    
    in=6'b000010;         #10;
    $display("Jump\n");   
    
    in=6'b011111;         #10;
    $display("Jalpc\n"); 
    
    in=6'b011011;         #10;
    $display("Baln\n");
    
  $finish;
  end
  
  control cont(in,funct,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop2,aluop1,aluop0,jump,brv,jmxor,nandi,blezal,jalpc,baln);

endmodule