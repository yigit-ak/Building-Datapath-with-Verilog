module findjumpaddress(input1,input2,newaddress);
  input [25:0] input1;  //jump address
  input [31:0] input2;  //PC + 4
  output [31:0] newaddress;  

  wire [27:0] shifted_input1;  
  wire [3:0] fourbit_input2;

  assign shifted_input1 = input1 << 2;
  assign fourbit_input2 = input2[31:28];
  
  assign newaddress = {fourbit_input2,shifted_input1};

endmodule
