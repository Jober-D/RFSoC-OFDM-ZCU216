-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_AutoCorr.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_AutoCorr
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/SchmidlCoxMetric /AutoCorr
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_AutoCorr IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        AcorrIn_re                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        AcorrIn_im                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        AcorrOut_re                       :   OUT   std_logic_vector(24 DOWNTO 0);  -- sfix25_En23
        AcorrOut_im                       :   OUT   std_logic_vector(24 DOWNTO 0)  -- sfix25_En23
        );
END ofdm_rx_src_AutoCorr;


ARCHITECTURE rtl OF ofdm_rx_src_AutoCorr IS

  -- Signals
  SIGNAL AcorrIn_re_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL AcorrIn_im_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_re_1                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_im_1                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay3_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay3_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_1_C2ReIm_A        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL reduced_reg_re                   : vector_of_signed16(0 TO 14);  -- sfix16_En14 [15]
  SIGNAL reduced_reg_im                   : vector_of_signed16(0 TO 14);  -- sfix16_En14 [15]
  SIGNAL Delay1_out1_re_2                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_im_2                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL conj_cast                        : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL conj_cast_1                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Math_Function_out1_re            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_re_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_re_2          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im_2          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_2_C2ReIm_A        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_mul_temp                 : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Re_AC                    : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_Re_AC_1                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_C2ReIm_1_C2ReIm_B        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_2_C2ReIm_B        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Re_BD                    : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product1_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Im_AD                    : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_Im_AD_1                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product3_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Im_BC                    : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_Re_BD_1                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL mulOutput                        : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_Im_BC_1                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL mulOutput_1                      : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_out1_re                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Product_out1_im                  : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Delay2_out1_re                   : signed(24 DOWNTO 0);  -- sfix25_En23
  SIGNAL Delay2_out1_im                   : signed(24 DOWNTO 0);  -- sfix25_En23

BEGIN
  AcorrIn_re_signed <= signed(AcorrIn_re);

  AcorrIn_im_signed <= signed(AcorrIn_im);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1_re <= to_signed(16#0000#, 16);
      Delay1_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay1_out1_re <= AcorrIn_re_signed;
        Delay1_out1_im <= AcorrIn_im_signed;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1_re_1 <= to_signed(16#0000#, 16);
      Delay1_out1_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay1_out1_re_1 <= Delay1_out1_re;
        Delay1_out1_im_1 <= Delay1_out1_im;
      END IF;
    END IF;
  END PROCESS reduced_process;


  Delay3_out1_re <= Delay1_out1_re_1;

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_A <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_A <= Delay3_out1_re;
      END IF;
    END IF;
  END PROCESS reduced_1_process;


  reduced_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      reduced_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        reduced_reg_im(0) <= Delay1_out1_im_1;
        reduced_reg_im(1 TO 14) <= reduced_reg_im(0 TO 13);
        reduced_reg_re(0) <= Delay1_out1_re_1;
        reduced_reg_re(1 TO 14) <= reduced_reg_re(0 TO 13);
      END IF;
    END IF;
  END PROCESS reduced_2_process;

  Delay1_out1_re_2 <= reduced_reg_re(14);
  Delay1_out1_im_2 <= reduced_reg_im(14);

  Math_Function_out1_re <= Delay1_out1_re_2;
  conj_cast <= resize(Delay1_out1_im_2, 17);
  conj_cast_1 <=  - (conj_cast);
  
  Math_Function_out1_im <= X"7FFF" WHEN (conj_cast_1(16) = '0') AND (conj_cast_1(15) /= '0') ELSE
      X"8000" WHEN (conj_cast_1(16) = '1') AND (conj_cast_1(15) /= '1') ELSE
      conj_cast_1(15 DOWNTO 0);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Math_Function_out1_re_1 <= to_signed(16#0000#, 16);
      Math_Function_out1_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Math_Function_out1_re_1 <= Math_Function_out1_re;
        Math_Function_out1_im_1 <= Math_Function_out1_im;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  Math_Function_out1_re_2 <= Math_Function_out1_re_1;

  reduced_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_A <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_A <= Math_Function_out1_re_2;
      END IF;
    END IF;
  END PROCESS reduced_3_process;


  Product_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_A;
  Product_Re_AC <= Product_mul_temp(29 DOWNTO 5);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_AC_1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Re_AC_1 <= Product_Re_AC;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay3_out1_im <= Delay1_out1_im_1;

  reduced_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_B <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_B <= Delay3_out1_im;
      END IF;
    END IF;
  END PROCESS reduced_4_process;


  Math_Function_out1_im_2 <= Math_Function_out1_im_1;

  reduced_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_B <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_B <= Math_Function_out1_im_2;
      END IF;
    END IF;
  END PROCESS reduced_5_process;


  Product2_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_B;
  Product_Re_BD <= Product2_mul_temp(29 DOWNTO 5);

  Product1_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_B;
  Product_Im_AD <= Product1_mul_temp(29 DOWNTO 5);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_AD_1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Im_AD_1 <= Product_Im_AD;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Product3_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_A;
  Product_Im_BC <= Product3_mul_temp(29 DOWNTO 5);

  PipelineRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_BD_1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Re_BD_1 <= Product_Re_BD;
      END IF;
    END IF;
  END PROCESS PipelineRegister2_process;


  mulOutput <= Product_Re_AC_1 - Product_Re_BD_1;

  PipelineRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_BC_1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Im_BC_1 <= Product_Im_BC;
      END IF;
    END IF;
  END PROCESS PipelineRegister3_process;


  mulOutput_1 <= Product_Im_AD_1 + Product_Im_BC_1;

  Delay5_output_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_re <= to_signed(16#0000000#, 25);
      Product_out1_im <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Product_out1_re <= mulOutput;
        Product_out1_im <= mulOutput_1;
      END IF;
    END IF;
  END PROCESS Delay5_output_process;


  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1_re <= to_signed(16#0000000#, 25);
      Delay2_out1_im <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_out1_re <= Product_out1_re;
        Delay2_out1_im <= Product_out1_im;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  AcorrOut_re <= std_logic_vector(Delay2_out1_re);

  AcorrOut_im <= std_logic_vector(Delay2_out1_im);

END rtl;

