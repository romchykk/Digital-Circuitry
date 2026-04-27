module testbench;
  
  reg[6:0] Ain_r, Bin_r;
  reg Ci_r;
  wire [6:0] Ain, Bin;
  wire [6:0] res_sum, res_ref;
  wire Ci, cs, cr;
  
  assign Ain = Ain_r;
  assign Bin = Bin_r;
  assign Ci = Ci_r;
  
  Sum sum_block(Ain, Bin, Ci, res_sum, cs);
  ref ref_block(Ain, Bin, Ci, res_ref, cr);
  
  initial
    begin
      $display("Time\tAin     \tBin     \tCi\tres_sum  \tcs\tres_ref \tcr");
      $monitor("%4d\t%08b\t%08b\t%b\t%08b\t%b\t%08b\t%b", 
                 $time, Ain, Bin, Ci, res_sum, cs, res_ref, cr);
      #500 $finish;
    end
  initial
    begin
      Ain_r = 7'b0000001;
      #50 Ain_r = 7'b0001010;
      #50 Ain_r = 7'b1000100;
      #50 Ain_r = 8'b0011101;
      #50 Ain_r = 7'b0011010;
      #50 Ain_r = 7'b1000110;
      #50 Ain_r = 7'b0010110;
    end
  initial
    begin
      Bin_r = 7'b0000010;
      #50 Bin_r = 7'b0001100; 
      #50 Bin_r = 7'b1010101; 
      #50 Bin_r = 7'b1110000; 
      #100 Bin_r = 7'b0000001; 
      #100 Bin_r = 7'b1111111;
    end
  initial 
    begin
      Ci_r = 1'b0;
      #250 Ci_r = 1'b1;
    end
endmodule