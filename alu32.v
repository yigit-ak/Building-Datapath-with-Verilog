module alu32(
	result, // result of ALU [output]
	v_flag, // if result causes overflow [output]
	n_flag, // if result is negative [output]
	z_flag, // if result is zero [output]
	op1, // operand 1 [input]
	op2, // operand 2 [input]
	alu_control_code,
	zout // code from ALU controller [input]
);

input [31:0] op1, op2;
input [3:0] alu_control_code;

output [31:0] result;
output v_flag, n_flag, z_flag, zout;

reg [31:0] result;
reg [31:0] subtracted_value;
reg v_flag, n_flag, z_flag, zout;

always @(op1 or op2 or alu_control_code)
begin
	case(alu_control_code)
	// ALU Control Line = 0000 (AND)
	4'b0000: result = op1 & op2;

	// ALU Control Line = 0001 (OR)
	4'b0001: result = op1 | op2;

	// ALU Control Line = 0010 (ADD)
	4'b0010: begin
		result = op1 + op2;
		// update flags
		v_flag = (op1[31] == op2[31]) && (result[31] != op1[31]);
		n_flag = result[31];
	end

	// ALU Control Line = 0110 (SUB)
	4'b0110: begin
		result = op1 + 1 + (~op2);
		// update flags
		v_flag = (op1[31] != op2[31]) && (result[31] != op1[31]);
		n_flag = result[31];
	end

	// ALU Control Line = 0111 (set-on-less-than)
	4'b0111: begin
		subtracted_value = op1 + 1 + (~op2);
		if (subtracted_value[31]) result = 1;
		else result = 0;
	end

	// ALU Control Line = 1001 (NOR)
	4'b1001: result = ~(op1 | op2);

	// ALU Control Line = 1100 (NAND)
	4'b1100: result = ~(op1 & op2);
	
	// ALU Control Line = 1101 (XOR)
	4'b1101: result = op1 ^ op2;
	
	// ALU Control Line = 1111 (NOP)
	4'b1111: result = result;

	default: result=31'bx;
	endcase

	z_flag = ~(|result);
	zout = ~(|result);

end

endmodule
