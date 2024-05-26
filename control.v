module control(in,funct,regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop2, aluop1, aluop0, jump, brv, jmxor, nandi, blezal, jalpc, baln);
input [5:0] in, funct;
output reg regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop2, aluop1, aluop0, jump, brv, jmxor, nandi, blezal, jalpc, baln;

// Define the instruction types as wires
wire rformat, lw, sw, beq,isBrv,isJmxor;
assign rformat=~|in;
assign lw=in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);
assign isBrv=rformat&~funct[5]&funct[4]&~funct[3]&funct[2]&~funct[1]&~funct[0]; //010100 brv
assign isJmxor=rformat&funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&funct[0]; //100011 jmxor

always @ (*) begin
    // Default values
    regdest = 0; alusrc = 0; memtoreg = 0; regwrite = 0; memread = 0; memwrite = 0; branch = 0; baln = 0;
    aluop2 = 0; aluop1 = 0; aluop0 = 0; jump = 0; brv = 0; jmxor = 0; nandi = 0; blezal = 0; jalpc = 0;

    case(in)
        6'b000000: begin // R-type
            if (~isBrv&~isJmxor)
              begin
                regdest = 1; regwrite = 1; aluop2 = 1;
              end
            else if (isBrv)
              begin
                aluop2=1; aluop1=1; aluop0=1;
                brv=1;
              end
          else if(isJmxor)
            begin
              alusrc=1; regwrite=1; memread=1; aluop2=1;
              jmxor=1;
          end
        end
        6'b100011: begin // LOAD
            alusrc = 1; memtoreg = 1;
            regwrite = 1; memread = 1;
        end
        6'b101011: begin // STORE
            alusrc = 1; memwrite = 1;
        end
        6'b000100: begin // BEQ
            branch = 1; aluop0 = 1;
        end
        6'b000010: begin // JUMP
            //regdest=1'bx; alusrc=1'bx; 
            jump = 1;
        end
        6'b010000: begin // NANDI
            regwrite=1; aluop1=1; aluop0=1;
            nandi = 1;
        end
        6'b100100: begin // BLEZAL
            regwrite=1; aluop0=1;
            blezal = 1;
        end
        6'b011111: begin // JALPC
            jalpc = 1;
            aluop2=1; aluop1=1; aluop0=1;
        end
        6'b011011: begin // BALN
            alusrc=1'bx; regwrite=1;
            aluop2=1; aluop1=1; aluop0=1;
            baln = 1;
        end
    endcase
end
  
endmodule
