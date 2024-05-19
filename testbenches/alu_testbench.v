module alu_testbench();

reg signed [31:0] op1, op2;
reg signed [3:0] alu_control_code;

wire signed [31:0] result;
wire v_flag, n_flag, z_flag;
  
initial
begin
  op1 = 32'h00_00_ff_ff;
  op2 = 32'h00_ff_00_ff;

  // tests for logic operations
  $display("----- Tests for Logic Operations -----");
  alu_control_code = 4'b0000; #10; // AND 
  $display("%h AND  %h = %h", op1, op2, result);
  alu_control_code = 4'b0001; #10; // OR
  $display("%h OR   %h = %h", op1, op2, result);
  alu_control_code = 4'b1001; #10; // NOR
  $display("%h NOR  %h = %h", op1, op2, result);
  alu_control_code = 4'b1101; #10; // XOR
  $display("%h XOR  %h = %h", op1, op2, result);
  alu_control_code = 4'b1100; #10; // NAND
  $display("%h NAND %h = %h", op1, op2, result);

  // tests for arithmetic operations
  $display("----- Tests for Arithmetic Operations -----");
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

  // tests for flags
  // flags should remain same after logical operations
  $display("----- Tests for Flags and Logical Operations -----");
  op1 = 32'h00_00_ff_ff;
  op2 = 32'h00_ff_00_ff;
  $display("previous values of flags: V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);
  alu_control_code = 4'b0000; #10; // AND
  $display("after AND:  V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);
  alu_control_code = 4'b0001; #10; // OR
  $display("after OR:   V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);
  alu_control_code = 4'b1001; #10; // NOR
  $display("after NOR:  V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);
  alu_control_code = 4'b1101; #10; // XOR
  $display("after XOR:  V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);
  alu_control_code = 4'b1100; #10; // NAND
  $display("after NAND: V = %b, N = %b, Z = %b", v_flag, n_flag, z_flag);

  // test for Z flag
  $display("----- Tests for Z-Flag -----");
  alu_control_code = 4'b0110; // SUB
  op1 = 32'sd10; op2 = 32'sd10; #10; // z-flag on
  $display("%d - %d = %d, Z = %b", op1, op2, result, z_flag);
  op1 = -32'sd10; op2 = 32'sd10; #10; // z-flag off
  $display("%d - %d = %d, Z = %b", op1, op2, result, z_flag);

  // test for N flag
  $display("----- Tests for N-Flag -----");
  alu_control_code = 4'b0110; // SUB
  op1 = -32'sd10; op2 = 32'sd10; #10; // n-flag on
  $display("%d - %d = %d, N = %b", op1, op2, result, n_flag);
  op1 = 32'sd10; op2 = 32'sd10; #10; // n-flag off
  $display("%d - %d = %d, N = %b", op1, op2, result, n_flag);

  // test for V flag
  $display("----- Tests for Overflow -----");
  alu_control_code = 4'b0010; // ADD
  op1 = 32'h7fffffff; op2 = 32'h7fffffff; #10;
  $display("%h + %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h80000000; op2 = 32'h80000000; #10;
  $display("%h + %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h11111111; op2 = 32'h11111111; #10;
  $display("%h + %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h80000000; op2 = 32'h11111111; #10;
  $display("%h + %h = %h, V = %b", op1, op2, result, v_flag);

  alu_control_code = 4'b0110; // SUB
  op1 = 32'h7fffffff; op2 = -32'h7fffffff; #10;
  $display("%h - %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h80000000; op2 = 32'h80000000; #10;
  $display("%h - %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h7fffffff; op2 = 32'h11111111; #10;
  $display("%h - %h = %h, V = %b", op1, op2, result, v_flag);
  op1 = 32'h11111111; op2 = 32'h80000000; #10;
  $display("%h - %h = %h, V = %b", op1, op2, result, v_flag);

  $finish;
end

alu32 alu(result, v_flag, n_flag, z_flag, op1, op2,alu_control_code);

endmodule
