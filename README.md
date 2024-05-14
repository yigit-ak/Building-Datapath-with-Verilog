# Building-Datapath-with-Verilog

This project, assigned in the CSE 3038 - Computer Organization course, requires extending the MIPS single-cycle implementation by adding six additional instructions. 
These instructions are part of the R-format, I-format, and J-format categories. 
The task involves designing a revised single-cycle datapath and control units to accommodate the new instructions, implementing them in Verilog HDL, and testing the functionality using ModelSim simulator.

## Assigned Instructions

The assigned instructions for our group in this project are:

| # | Instruction | Type   | Code      | Syntax                | Meaning |
| - | ----------- | ------ | --------- | --------------------- | ------- |
| 1 | brv         | R-type | funct=20  | brv $rs               | If Status [V] = 1, branches to address found in register $rs |
| 2 | jmxor       | R-type | funct=34  | jmxor $rs, $rt        | Jumps to address found in memory [$rs XOR $rt], link address is stored in $31 |
| 3 | nandi       | I-type | opcode=16 | nandi $rt, $rs, Label | Put the logical NAND of register $rs and the zero- extended immediate into register $rt |
| 4 | blezal      | I-type | opcode=36 | blezal $rs, Label     | If R[rs] <= 0, branch to to PC-relative address (formed as beq & bne do), link address is stored in register 25 |
| 5 | jalpc       | I-type | opcode=31 | jalpc $rt, Target     | Jumps to PC-relative address (formed as beq and bne do), link address is stored in $rt |
| 6 | baln        | J-type | opcode=27 | baln Target           | If Status [N] = 1, branches to pseudo-direct address (formed as jal does), link address is stored in register 31 |
