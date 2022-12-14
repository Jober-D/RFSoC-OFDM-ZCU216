-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_PhaseErrorEst.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_PhaseErrorEst
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/PhaseErrorEst
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_PhaseErrorEst IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataIn_im                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        gradientIn                        :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
        dataValidIn                       :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataOut_im                        :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        PhaseOut                          :   OUT   std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
        dataValidOut                      :   OUT   std_logic
        );
END ofdm_rx_src_PhaseErrorEst;


ARCHITECTURE rtl OF ofdm_rx_src_PhaseErrorEst IS

  -- Constants
  CONSTANT LUT_data                       : vector_of_signed6(0 TO 51) := 
    (to_signed(-16#15#, 6), to_signed(-16#07#, 6), to_signed(16#07#, 6), to_signed(16#15#, 6),
     to_signed(-16#1A#, 6), to_signed(-16#19#, 6), to_signed(-16#18#, 6), to_signed(-16#17#, 6),
     to_signed(-16#16#, 6), to_signed(-16#14#, 6), to_signed(-16#13#, 6), to_signed(-16#12#, 6),
     to_signed(-16#11#, 6), to_signed(-16#10#, 6), to_signed(-16#0F#, 6), to_signed(-16#0E#, 6),
     to_signed(-16#0D#, 6), to_signed(-16#0C#, 6), to_signed(-16#0B#, 6), to_signed(-16#0A#, 6),
     to_signed(-16#09#, 6), to_signed(-16#08#, 6), to_signed(-16#06#, 6), to_signed(-16#05#, 6),
     to_signed(-16#04#, 6), to_signed(-16#03#, 6), to_signed(-16#02#, 6), to_signed(-16#01#, 6),
     to_signed(16#01#, 6), to_signed(16#02#, 6), to_signed(16#03#, 6), to_signed(16#04#, 6), to_signed(16#05#, 6),
     to_signed(16#06#, 6), to_signed(16#08#, 6), to_signed(16#09#, 6), to_signed(16#0A#, 6), to_signed(16#0B#, 6),
     to_signed(16#0C#, 6), to_signed(16#0D#, 6), to_signed(16#0E#, 6), to_signed(16#0F#, 6), to_signed(16#10#, 6),
     to_signed(16#11#, 6), to_signed(16#12#, 6), to_signed(16#13#, 6), to_signed(16#14#, 6), to_signed(16#16#, 6),
     to_signed(16#17#, 6), to_signed(16#18#, 6), to_signed(16#19#, 6), to_signed(16#1A#, 6));  -- sfix6 [52]

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL dataIn_im_signed                 : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL Delay6_reg_re                    : vector_of_signed18(0 TO 1);  -- sfix18_En15 [2]
  SIGNAL Delay6_reg_im                    : vector_of_signed18(0 TO 1);  -- sfix18_En15 [2]
  SIGNAL Delay6_out1_re                   : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL Delay6_out1_im                   : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL gradientIn_signed                : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay3_out1                      : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay3_out1_1                    : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay3_out1_2                    : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL HDL_Counter_out1_1               : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL LUT_k                            : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL LUT_out1                         : signed(5 DOWNTO 0);  -- sfix6
  SIGNAL LUT_out1_1                       : signed(5 DOWNTO 0) := to_signed(16#00#, 6);  -- sfix6
  SIGNAL LUT_out1_2                       : signed(5 DOWNTO 0);  -- sfix6
  SIGNAL delayMatch_reg                   : vector_of_signed6(0 TO 1);  -- sfix6 [2]
  SIGNAL LUT_out1_3                       : signed(5 DOWNTO 0);  -- sfix6
  SIGNAL LUT_out1_4                       : signed(5 DOWNTO 0);  -- sfix6
  SIGNAL LUT_out1_5                       : signed(5 DOWNTO 0);  -- sfix6
  SIGNAL Product_mul_temp                 : signed(28 DOWNTO 0);  -- sfix29_En20
  SIGNAL Product_out1                     : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Product_out1_1                   : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay7_bypass_reg                : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL Product_out1_2                   : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay8_reg                       : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Delay8_out1                      : std_logic;

BEGIN
  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_reg_re <= (OTHERS => to_signed(16#00000#, 18));
      Delay6_reg_im <= (OTHERS => to_signed(16#00000#, 18));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay6_reg_im(0) <= dataIn_im_signed;
        Delay6_reg_im(1) <= Delay6_reg_im(0);
        Delay6_reg_re(0) <= dataIn_re_signed;
        Delay6_reg_re(1) <= Delay6_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay6_process;

  Delay6_out1_re <= Delay6_reg_re(1);
  Delay6_out1_im <= Delay6_reg_im(1);

  dataOut_re <= std_logic_vector(Delay6_out1_re);

  dataOut_im <= std_logic_vector(Delay6_out1_im);

  gradientIn_signed <= signed(gradientIn);

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay3_out1 <= gradientIn_signed;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Delay3_out1_1 <= Delay3_out1;

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1_2 <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1_2 <= Delay3_out1_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  NOT_out1 <=  NOT dataValidIn;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 51
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF NOT_out1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#00#, 6);
        ELSIF dataValidIn = '1' THEN 
          IF HDL_Counter_out1 >= to_unsigned(16#33#, 6) THEN 
            HDL_Counter_out1 <= to_unsigned(16#00#, 6);
          ELSE 
            HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#01#, 6);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  HDL_Counter_out1_1 <= HDL_Counter_out1;

  
  LUT_k <= to_unsigned(16#00#, 6) WHEN HDL_Counter_out1_1 = to_unsigned(16#00#, 6) ELSE
      to_unsigned(16#33#, 6) WHEN HDL_Counter_out1_1 >= to_unsigned(16#33#, 6) ELSE
      HDL_Counter_out1_1;
  LUT_out1 <= LUT_data(to_integer(LUT_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        LUT_out1_1 <= LUT_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay5_output_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      LUT_out1_2 <= to_signed(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        LUT_out1_2 <= LUT_out1_1;
      END IF;
    END IF;
  END PROCESS Delay5_output_process;


  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => to_signed(16#00#, 6));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        delayMatch_reg(0) <= LUT_out1_2;
        delayMatch_reg(1) <= delayMatch_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  LUT_out1_3 <= delayMatch_reg(1);

  LUT_out1_4 <= LUT_out1_3;

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      LUT_out1_5 <= to_signed(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        LUT_out1_5 <= LUT_out1_4;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Product_mul_temp <= Delay3_out1_2 * LUT_out1_5;
  Product_out1 <= Product_mul_temp(22 DOWNTO 0);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_1 <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_out1_1 <= Product_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Delay7_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_bypass_reg <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Delay7_bypass_reg <= Product_out1_1;
      END IF;
    END IF;
  END PROCESS Delay7_bypass_process;

  
  Product_out1_2 <= Product_out1_1 WHEN enb_1_12_1 = '1' ELSE
      Delay7_bypass_reg;

  PhaseOut <= std_logic_vector(Product_out1_2);

  Delay8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay8_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay8_reg(0) <= dataValidIn;
        Delay8_reg(1) <= Delay8_reg(0);
      END IF;
    END IF;
  END PROCESS Delay8_process;

  Delay8_out1 <= Delay8_reg(1);

  dataValidOut <= Delay8_out1;

END rtl;

