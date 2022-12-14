-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_ChanEst.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_ChanEst
-- Source Path: OFDM_Rx_HW/OFDMRx/ChannelEstEq/ChannelEstimate/ChanEst
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_ChanEst IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        ChanEstIn_re                      :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        ChanEstIn_im                      :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        PreambValidIn                     :   IN    std_logic;
        ChEstOut_re                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        ChEstOut_im                       :   OUT   std_logic_vector(16 DOWNTO 0)  -- sfix17_En14
        );
END ofdm_rx_src_ChanEst;


ARCHITECTURE rtl OF ofdm_rx_src_ChanEst IS

  -- Constants
  CONSTANT InvLLTF_data                   : vector_of_signed16(0 TO 63) := 
    (to_signed(16#0000#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(-16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(-16#0001#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(-16#0001#, 16),
     to_signed(-16#0001#, 16), to_signed(-16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(-16#0001#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0000#, 16),
     to_signed(16#0000#, 16), to_signed(16#0000#, 16), to_signed(16#0000#, 16), to_signed(16#0000#, 16),
     to_signed(16#0000#, 16), to_signed(16#0000#, 16), to_signed(16#0000#, 16), to_signed(16#0000#, 16),
     to_signed(16#0000#, 16), to_signed(16#0000#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(-16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(-16#0001#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(-16#0001#, 16), to_signed(16#0001#, 16), to_signed(-16#0001#, 16),
     to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16), to_signed(16#0001#, 16));  -- sfix16 [64]

  -- Signals
  SIGNAL ChanEstIn_re_signed              : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL ChanEstIn_im_signed              : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Delay4_reg_re                    : vector_of_signed22(0 TO 1);  -- sfix22_En14 [2]
  SIGNAL Delay4_reg_im                    : vector_of_signed22(0 TO 1);  -- sfix22_En14 [2]
  SIGNAL Delay4_out1_re                   : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Delay4_out1_im                   : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Delay4_out1_re_1                 : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Delay4_out1_im_1                 : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Product_C2ReIm_C2ReIm_A          : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL HDL_Counter_out1_1               : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL InvLLTF_k                        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL InvLLTF_out1                     : signed(15 DOWNTO 0);  -- int16
  SIGNAL InvLLTF_out1_1                   : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- int16
  SIGNAL Delay5_bypass_reg                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL InvLLTF_out1_2                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL InvLLTF_out1_3                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL InvLLTF_out1_4                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL Product_mul_temp                 : signed(37 DOWNTO 0);  -- sfix38_En14
  SIGNAL Product_Re                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Re_1                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_C2ReIm_B          : signed(21 DOWNTO 0);  -- sfix22_En14
  SIGNAL Product1_mul_temp                : signed(37 DOWNTO 0);  -- sfix38_En14
  SIGNAL Product_Im                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Im_1                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay6_bypass_reg_re             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay6_bypass_reg_im             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_reg_re                     : vector_of_signed16(0 TO 63);  -- sfix16_En14 [64]
  SIGNAL Delay_reg_im                     : vector_of_signed16(0 TO 63);  -- sfix16_En14 [64]
  SIGNAL Delay_out1_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Subtract_add_cast                : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Subtract_add_cast_1              : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Subtract_add_cast_2              : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Subtract_add_cast_3              : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Subtract_out1_re                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Subtract_out1_im                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Gain_cast                        : signed(33 DOWNTO 0);  -- sfix34_En30
  SIGNAL Gain_cast_1                      : signed(33 DOWNTO 0);  -- sfix34_En30
  SIGNAL Gain_out1_re                     : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Gain_out1_im                     : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Gain_out1_re_1                   : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Gain_out1_im_1                   : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL conj_cast                        : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL conj_cast_1                      : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Math_Function_out1_re            : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Math_Function_out1_im            : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Math_Function_out1_re_1          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Math_Function_out1_im_1          : signed(16 DOWNTO 0);  -- sfix17_En14

BEGIN
  -- Store conjugate as this is used in the 
  -- equaliser. 
  -- 
  -- Read out frequency domain LTS 
  -- when preamble valid is HIGH and 
  -- use this to obtain channel estimate. 
  -- 
  -- 1st half
  -- 
  -- 2nd half

  ChanEstIn_re_signed <= signed(ChanEstIn_re);

  ChanEstIn_im_signed <= signed(ChanEstIn_im);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_reg_re <= (OTHERS => to_signed(16#000000#, 22));
      Delay4_reg_im <= (OTHERS => to_signed(16#000000#, 22));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay4_reg_im(0) <= ChanEstIn_im_signed;
        Delay4_reg_im(1) <= Delay4_reg_im(0);
        Delay4_reg_re(0) <= ChanEstIn_re_signed;
        Delay4_reg_re(1) <= Delay4_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay4_process;

  Delay4_out1_re <= Delay4_reg_re(1);
  Delay4_out1_im <= Delay4_reg_im(1);

  Delay4_out1_re_1 <= Delay4_out1_re;

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_C2ReIm_A <= to_signed(16#000000#, 22);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_C2ReIm_A <= Delay4_out1_re_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_out1 <= PreambValidIn;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 63
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' AND Delay2_out1 = '1' THEN
        HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#01#, 6);
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  HDL_Counter_out1_1 <= HDL_Counter_out1;

  
  InvLLTF_k <= to_unsigned(16#00#, 6) WHEN HDL_Counter_out1_1 = to_unsigned(16#00#, 6) ELSE
      to_unsigned(16#3F#, 6) WHEN HDL_Counter_out1_1 = to_unsigned(16#3F#, 6) ELSE
      HDL_Counter_out1_1;
  InvLLTF_out1 <= InvLLTF_data(to_integer(InvLLTF_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        InvLLTF_out1_1 <= InvLLTF_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay5_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_bypass_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Delay5_bypass_reg <= InvLLTF_out1_1;
      END IF;
    END IF;
  END PROCESS Delay5_bypass_process;

  
  InvLLTF_out1_2 <= InvLLTF_out1_1 WHEN enb_1_12_1 = '1' ELSE
      Delay5_bypass_reg;

  InvLLTF_out1_3 <= InvLLTF_out1_2;

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      InvLLTF_out1_4 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        InvLLTF_out1_4 <= InvLLTF_out1_3;
      END IF;
    END IF;
  END PROCESS reduced_process;


  Product_mul_temp <= Product_C2ReIm_C2ReIm_A * InvLLTF_out1_4;
  Product_Re <= Product_mul_temp(15 DOWNTO 0);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Re_1 <= Product_Re;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Delay4_out1_im_1 <= Delay4_out1_im;

  HwModeRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_C2ReIm_B <= to_signed(16#000000#, 22);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_C2ReIm_B <= Delay4_out1_im_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister2_process;


  Product1_mul_temp <= Product_C2ReIm_C2ReIm_B * InvLLTF_out1_4;
  Product_Im <= Product1_mul_temp(15 DOWNTO 0);

  PipelineRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Im_1 <= Product_Im;
      END IF;
    END IF;
  END PROCESS PipelineRegister2_process;


  Delay6_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_bypass_reg_re <= to_signed(16#0000#, 16);
      Delay6_bypass_reg_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Delay6_bypass_reg_im <= Product_Im_1;
        Delay6_bypass_reg_re <= Product_Re_1;
      END IF;
    END IF;
  END PROCESS Delay6_bypass_process;

  
  Product_out1_re <= Product_Re_1 WHEN enb_1_12_1 = '1' ELSE
      Delay6_bypass_reg_re;
  
  Product_out1_im <= Product_Im_1 WHEN enb_1_12_1 = '1' ELSE
      Delay6_bypass_reg_im;

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay_reg_im(0) <= Product_out1_im;
        Delay_reg_im(1 TO 63) <= Delay_reg_im(0 TO 62);
        Delay_reg_re(0) <= Product_out1_re;
        Delay_reg_re(1 TO 63) <= Delay_reg_re(0 TO 62);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1_re <= Delay_reg_re(63);
  Delay_out1_im <= Delay_reg_im(63);

  Subtract_add_cast <= resize(Delay_out1_re, 17);
  Subtract_add_cast_1 <= resize(Product_out1_re, 17);
  Subtract_out1_re <= Subtract_add_cast + Subtract_add_cast_1;
  Subtract_add_cast_2 <= resize(Delay_out1_im, 17);
  Subtract_add_cast_3 <= resize(Product_out1_im, 17);
  Subtract_out1_im <= Subtract_add_cast_2 + Subtract_add_cast_3;

  Gain_cast <= resize(Subtract_out1_re & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 34);
  Gain_out1_re <= Gain_cast(32 DOWNTO 16);
  Gain_cast_1 <= resize(Subtract_out1_im & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 34);
  Gain_out1_im <= Gain_cast_1(32 DOWNTO 16);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Gain_out1_re_1 <= to_signed(16#00000#, 17);
      Gain_out1_im_1 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Gain_out1_re_1 <= Gain_out1_re;
        Gain_out1_im_1 <= Gain_out1_im;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  Math_Function_out1_re <= Gain_out1_re_1;
  conj_cast <= resize(Gain_out1_im_1, 18);
  conj_cast_1 <=  - (conj_cast);
  
  Math_Function_out1_im <= "01111111111111111" WHEN (conj_cast_1(17) = '0') AND (conj_cast_1(16) /= '0') ELSE
      "10000000000000000" WHEN (conj_cast_1(17) = '1') AND (conj_cast_1(16) /= '1') ELSE
      conj_cast_1(16 DOWNTO 0);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Math_Function_out1_re_1 <= to_signed(16#00000#, 17);
      Math_Function_out1_im_1 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Math_Function_out1_re_1 <= Math_Function_out1_re;
        Math_Function_out1_im_1 <= Math_Function_out1_im;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  ChEstOut_re <= std_logic_vector(Math_Function_out1_re_1);

  ChEstOut_im <= std_logic_vector(Math_Function_out1_im_1);

END rtl;

