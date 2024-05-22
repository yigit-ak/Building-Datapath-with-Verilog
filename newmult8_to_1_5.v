module newmult8_to_1_5(out, i0, i1, i2, i3, i4, i5, i6, i7, s0, s1, s2);
output [4:0] out;
input [4:0] i0, i1, i2, i3, i4, i5, i6, i7;
input s0, s1, s2;

assign out = (s2 == 0 && s1 == 0 && s0 == 0) ? i0 :
             (s2 == 0 && s1 == 0 && s0 == 1) ? i1 :
             (s2 == 0 && s1 == 1 && s0 == 0) ? i2 :
             (s2 == 0 && s1 == 1 && s0 == 1) ? i3 :
             (s2 == 1 && s1 == 0 && s0 == 0) ? i4 :
             (s2 == 1 && s1 == 0 && s0 == 1) ? i5 :
             (s2 == 1 && s1 == 1 && s0 == 0) ? i6 :
                                               i7;
endmodule
