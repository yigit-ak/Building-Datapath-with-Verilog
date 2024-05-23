module newprocessor;
reg [31:0] pc; //32-bit prograom counter
reg clk; //clock
reg [7:0] datmem[0:31],mem[0:31]; //32-size data and instruction memory (8 bit(1 byte) for each location)
wire [31:0] 
dataa,	//Read data 1 output of Register File
datab,	//Read data 2 output of Register File
out2,		//Output of mux with ALUSrc control-mult2
out3,		//Output of mux with MemToReg control-mult3
out4,		//Output of mux with (Branch&ALUZero) control-mult4
out5,   ///////////////////////////////////////////////////////////////////////////////////////////Yeni ekledim jum mux çıkışı  
sum,		//ALU result
extad,	//Output of sign-extend unit
zeroextout,	///////////////////////////////////////////////////////////////////////////////////////////Yeni ekledim zero extend çıkışı
adder1out,	//Output of adder which adds PC and 4-add1
adder2out,	//Output of adder which adds PC+4 and 2 shifted sign-extend result-add2
sextad;	//Output of shift left 2 unit

wire [5:0] inst31_26;	//31-26 bits of instruction
wire [4:0] 
inst25_21,	//25-21 bits of instruction
inst20_16,	//20-16 bits of instruction
inst15_11,	//15-11 bits of instruction
out1;		//Write data input of Register File

wire [15:0] inst15_0;	//15-0 bits of instruction

wire [31:0] jumpaddress;	////////////////////////////////////////////////////////////////////////////////////Jump address yeni ekledim
wire [25:0] inst25_0;           ////////////////////////////////////////////////////////////////////////////////////jump için yeni kablo eklendi

wire [31:0] instruc,	//current instruction
dpack;	//Read data output of memory (data read from memory)

wire [3:0] gout;	//Output of ALU control unit

wire zout,nflag,vflag,zflag,	//Zero output of ALU ///////////////////////////// nflag,vflag,zflag alu çıkışına bunlar eklendi
pcsrc,	//Output of AND gate with Branch and ZeroOut inputs
//Control signals
regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop2,aluop1,aluop0,
jump,brv,jmxor,nandi,blezal,jalpc,baln,//////////////////////////////////////////////////////////////////////////Yeni sinyalleri ekledim control unit den
blezalandgateout,orgate3out,brvandgateout,orgate1out,orgate2out,
orgate4out,balnandgateout,blezalorgateout;////////////////////////////////////////////////tüm ara kablolar eklendi

//32-size register file (32 bit(1 word) for each register)
reg [31:0] registerfile[0:31];

integer i;

// datamemory connections

always @(posedge clk)
//write data to memory
if (memwrite)
begin 
//sum stores address,datab stores the value to be written
datmem[sum[4:0]+3]=datab[7:0];
datmem[sum[4:0]+2]=datab[15:8];
datmem[sum[4:0]+1]=datab[23:16];
datmem[sum[4:0]]=datab[31:24];
end

//instruction memory
//4-byte instruction
 assign instruc={mem[pc[4:0]],mem[pc[4:0]+1],mem[pc[4:0]+2],mem[pc[4:0]+3]};
 assign inst31_26=instruc[31:26];
 assign inst25_21=instruc[25:21];
 assign inst20_16=instruc[20:16];
 assign inst15_11=instruc[15:11];
 assign inst15_0=instruc[15:0];
 assign inst25_0=instruc[25:0];
	

// registers

assign dataa=registerfile[inst25_21];//Read register 1
assign datab=registerfile[inst20_16];//Read register 2
always @(posedge clk)
 registerfile[out1]= regwrite ? out3:registerfile[out1];//Write data to register

//read data from memory, sum stores address
assign dpack={datmem[sum[5:0]],datmem[sum[5:0]+1],datmem[sum[5:0]+2],datmem[sum[5:0]+3]};

//multiplexers
//mux with RegDst control
newmult8_to_1_5  mult1(out1,instruc[20:16],instruc[15:11],5'b11001,5'b00000,5'b11111,5'b00000,5'b00000,5'b00000,regdest,blezal,orgate1out);

//mux with ALUSrc control
newmult8_to_1_32 mult2(out2,datab,extad,zeroextout,32'b0,32'b0,32'b0,32'b0,32'b0,alusrc,nandi,blezal);

//mux with MemToReg control
newmult4_to_1_32 mult3(out3,sum,dpack,adder1out,32'b0,memtoreg,orgate2out);

//mux with (Branch&ALUZero) control
newmult4_to_1_32 mult4(out4,adder1out,adder2out,dataa,32'b0,orgate3out,brvandgateout);

//mux with jump control
newmult4_to_1_32 mult5(out5,out4,jumpaddress,dpack,32'b0,orgate4out,jmxor);

//////////////////////////////////////////////////////////////////////////////////////////////////////Tüm mux lar değiştirildi

// load pc
always @(negedge clk)
pc=out5;/////////////////////////////////out 4 değiştirildi out5 yapıldı

// alu, adder and control logic connections

//ALU unit
alu32 alu1(sum,vflag,nflag,zflag,dataa,out2,gout,zout);///////////////nflag,vflag,zflag

//adder which adds PC and 4
adder add1(pc,32'h4,adder1out);

//adder which adds PC+4 and 2 shifted sign-extend result
adder add2(adder1out,sextad,adder2out);

//Control unit
control cont(instruc[31:26],regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop2,aluop1,aluop0,jump,brv,jmxor,nandi,blezal,jalpc,baln);
///////////////////////////////////////////////////////////////////////////////////////////////////yeni sinyaller eklendi
//Sign extend unit
signext sext(instruc[15:0],extad);

//Zero extend unit
zeroextend zext(instruc[15:0],zeroextout);////////////////////////////////////////////zero extend eklendi

//ALU control unit
alucont acont(aluop2,aluop1,aluop0,instruc[3],instruc[2], instruc[1], instruc[0] ,gout);

//Shift-left 2 unit
shift shift2(sextad,extad);

findjumpaddress fja(inst25_0,adder1out,jumpaddress);////////////////////////jump adres oluşturuldu

//Branch mux related gates
assign pcsrc=branch & zout;
assign blezalorgateout = zflag | nflag;
assign blezalandgateout = blezal & blezalorgateout;
assign orgate3out = pcsrc | blezalandgateout | jalpc;
assign brvandgateout = vflag & brv;//////////////////////////////////////Branch le ilgili tüm kapılar eklendi

//ALUSrc mux related gates
//////////////////////////////////////////////////////////////////////////////////extradan kapıya ihtiyaç yok
	
//MemtoReg mux related gates
assign orgate2out = jmxor | jalpc | blezalandgateout | balnandgateout;//////////////////////////////////////MemtoReg le ilgili tüm kapılar eklendi

//RegDst mux related gates
assign orgate1out = jmxor | baln;//////////////////////////////////////RegDst le ilgili tüm kapılar eklendi

//Jump mux related gates
assign balnandgateout = baln & nflag;
assign orgate4out = jump | balnandgateout;//////////////////////////////////////Jump le ilgili tüm kapılar eklendi

//initialize datamemory,instruction memory and registers
//read initial data from files given in hex
initial
begin
$readmemh("initDm.dat",datmem); //read Data Memory
$readmemh("initIM.dat",mem);//read Instruction Memory
$readmemh("initReg.dat",registerfile);//read Register File

	for(i=0; i<31; i=i+1)
	$display("Instruction Memory[%0d]= %h  ",i,mem[i],"Data Memory[%0d]= %h   ",i,datmem[i],
	"Register[%0d]= %h",i,registerfile[i]);
end

initial
begin
pc=0;
#400 $finish;
	
end
initial
begin
clk=0;
//40 time unit for each cycle
forever #20  clk=~clk;
end
initial 
begin
  $monitor($time,"PC %h",pc,"  SUM %h",sum,"   INST %h",instruc[31:0],
"   REGISTER %h %h %h %h ",registerfile[4],registerfile[5], registerfile[6],registerfile[1] );
end
endmodule
