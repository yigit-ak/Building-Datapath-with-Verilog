module alu_testbench;

reg [31:0] op1, op2;
reg [3:0] alu_control_code;

reg [31:0] result;
reg v_flag, n_flag, z_flag;
  
initial
begin
  op1 = 32'h00ff;
  op2 = 32'h0f0f;

  // tests for logic operations
  alu_control_code = 4'b0000; #10; // AND
  $display("%h AND %h = %h", op1, op2, result);
  alu_control_code = 4'b0001; #10; // OR
  $display("%h OR %h = %h", op1, op2, result);
  alu_control_code = 4'b1001; #10; // NOR
  $display("%h NOR %h = %h", op1, op2, result);
  alu_control_code = 4'b1101; #10; // XOR
  $display("%h XOR %h = %h", op1, op2, result);
  alu_control_code = 4'b1100; #10; // NAND
  $display("%h NAND %h = %h", op1, op2, result);

  // tests for arithmetic operations
  alu_control_code = 4'b0010; // ADD
  op1 = 32'sd10; op2 = 32'sd10; #10; // P+P
  $display("%d + %d = %d", op1, op2, result);
  op1 = 32'sd10; op2 = -32'sd10; #10; // P+N
  $display("%d + %d = %d", op1, op2, result);
  op1 = -32'sd10; op2 = 32'sd10; #10; // N+P
  $display("%d + %d = %d", op1, op2, result);
  op1 = -32'sd10; op2 = -32'sd10; #10; // N+N
  $display("%d + %d = %d", op1, op2, result);

  alu_control_code = 4'b0110; // SUB
  op1 = 32'sd10; op2 = 32'sd10; #10; // P-P
  $display("%d - %d = %d", op1, op2, result);
  op1 = 32'sd10; op2 = -32'sd10; #10; // P-N
  $display("%d - %d = %d", op1, op2, result);
  op1 = -32'sd10; op2 = 32'sd10; #10; // N-P
  $display("%d - %d = %d", op1, op2, result);
  op1 = -32'sd10; op2 = -32'sd10; #10; // N-N
  $display("%d - %d = %d", op1, op2, result);

  $finish;
end

endmodule