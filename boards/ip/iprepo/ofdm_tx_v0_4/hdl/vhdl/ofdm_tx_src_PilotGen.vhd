-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_PilotGen.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_PilotGen
-- Source Path: OFDM_Tx_HW/OFDMTx/DataGenerator/PilotGen
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_tx_src_OFDMTx_pkg.ALL;

ENTITY ofdm_tx_src_PilotGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataValidIn                       :   IN    std_logic;
        pilotValidIn                      :   IN    std_logic;
        pilotOut_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        pilotOut_im                       :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END ofdm_tx_src_PilotGen;


ARCHITECTURE rtl OF ofdm_tx_src_PilotGen IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_ToComplex1
    PORT( In1                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          PilotOut_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          PilotOut_im                     :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_ToComplex1
    USE ENTITY work.ofdm_tx_src_ToComplex1(rtl);

  -- Constants
  CONSTANT Polarity_LUT_data              : vector_of_signed2(0 TO 126) := 
    (to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2), to_signed(-16#1#, 2),
     to_signed(-16#1#, 2), to_signed(-16#1#, 2));  -- sfix2 [127]
  CONSTANT PilotValue_LUT_data            : vector_of_signed2(0 TO 3) := 
    (to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(16#1#, 2), to_signed(-16#1#, 2));  -- sfix2 [4]

  -- Signals
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL HDL_Counter1_out1                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL HDL_Counter2_out1                : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL HDL_Counter2_out1_1              : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Polarity_LUT_k                   : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Polarity_LUT_out1                : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Polarity_LUT_out1_1              : signed(1 DOWNTO 0) := to_signed(16#0#, 2);  -- sfix2
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL pilotValidIn_1                   : std_logic;
  SIGNAL reduced_reg                      : std_logic_vector(0 TO 8);  -- ufix1 [9]
  SIGNAL pilotValidIn_2                   : std_logic;
  SIGNAL Constant_out1                    : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL RateTransition_bypass_reg        : std_logic;  -- ufix1
  SIGNAL pilotValidIn_3                   : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL HDL_Counter_out1_1               : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL PilotValue_LUT_k                 : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL PilotValue_LUT_out1              : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL PilotValue_LUT_out1_1            : signed(1 DOWNTO 0) := to_signed(16#0#, 2);  -- sfix2
  SIGNAL Switch1_out1                     : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Unary_Minus_in0                  : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Unary_Minus_out1                 : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Switch_out1                      : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Data_Type_Conversion1_out1       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL ToComplex1_out1_re               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ToComplex1_out1_im               : std_logic_vector(15 DOWNTO 0);  -- ufix16

BEGIN
  u_ToComplex1 : ofdm_tx_src_ToComplex1
    PORT MAP( In1 => std_logic_vector(Data_Type_Conversion1_out1),  -- sfix16_En14
              PilotOut_re => ToComplex1_out1_re,  -- sfix16_En14
              PilotOut_im => ToComplex1_out1_im  -- sfix16_En14
              );

  NOT_out1 <=  NOT dataValidIn;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 79
  HDL_Counter1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter1_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF NOT_out1 = '1' THEN 
          HDL_Counter1_out1 <= to_unsigned(16#00#, 8);
        ELSIF dataValidIn = '1' THEN 
          IF HDL_Counter1_out1 >= to_unsigned(16#4F#, 8) THEN 
            HDL_Counter1_out1 <= to_unsigned(16#00#, 8);
          ELSE 
            HDL_Counter1_out1 <= HDL_Counter1_out1 + to_unsigned(16#01#, 8);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter1_process;


  
  Compare_To_Constant1_out1 <= '1' WHEN HDL_Counter1_out1 = to_unsigned(16#4F#, 8) ELSE
      '0';

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 126
  HDL_Counter2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter2_out1 <= to_unsigned(16#00#, 7);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF NOT_out1 = '1' THEN 
          HDL_Counter2_out1 <= to_unsigned(16#00#, 7);
        ELSIF Compare_To_Constant1_out1 = '1' THEN 
          IF HDL_Counter2_out1 >= to_unsigned(16#7E#, 7) THEN 
            HDL_Counter2_out1 <= to_unsigned(16#00#, 7);
          ELSE 
            HDL_Counter2_out1 <= HDL_Counter2_out1 + to_unsigned(16#01#, 7);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter2_process;


  HDL_Counter2_out1_1 <= HDL_Counter2_out1;

  
  Polarity_LUT_k <= to_unsigned(16#00#, 7) WHEN HDL_Counter2_out1_1 = to_unsigned(16#00#, 7) ELSE
      to_unsigned(16#7E#, 7) WHEN HDL_Counter2_out1_1 >= to_unsigned(16#7E#, 7) ELSE
      HDL_Counter2_out1_1;
  Polarity_LUT_out1 <= Polarity_LUT_data(to_integer(Polarity_LUT_k));

  PipelineRegister1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Polarity_LUT_out1_1 <= Polarity_LUT_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  
  Compare_To_Constant_out1 <= '1' WHEN Polarity_LUT_out1_1 > to_signed(16#0#, 2) ELSE
      '0';

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      pilotValidIn_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        pilotValidIn_1 <= pilotValidIn;
      END IF;
    END IF;
  END PROCESS reduced_process;


  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        reduced_reg(0) <= pilotValidIn_1;
        reduced_reg(1 TO 8) <= reduced_reg(0 TO 7);
      END IF;
    END IF;
  END PROCESS reduced_1_process;

  pilotValidIn_2 <= reduced_reg(8);

  Constant_out1 <= to_signed(16#0#, 2);

  RateTransition_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      RateTransition_bypass_reg <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        RateTransition_bypass_reg <= pilotValidIn_1;
      END IF;
    END IF;
  END PROCESS RateTransition_bypass_process;

  
  pilotValidIn_3 <= pilotValidIn_1 WHEN enb_1_12_1 = '1' ELSE
      RateTransition_bypass_reg;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 3
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' AND pilotValidIn_3 = '1' THEN
        HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#1#, 2);
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  HDL_Counter_out1_1 <= HDL_Counter_out1;

  
  PilotValue_LUT_k <= to_unsigned(16#0#, 2) WHEN HDL_Counter_out1_1 = to_unsigned(16#0#, 2) ELSE
      to_unsigned(16#3#, 2) WHEN HDL_Counter_out1_1 = to_unsigned(16#3#, 2) ELSE
      HDL_Counter_out1_1;
  PilotValue_LUT_out1 <= PilotValue_LUT_data(to_integer(PilotValue_LUT_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        PilotValue_LUT_out1_1 <= PilotValue_LUT_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  
  Switch1_out1 <= Constant_out1 WHEN pilotValidIn_2 = '0' ELSE
      PilotValue_LUT_out1_1;

  Unary_Minus_in0 <=  - (resize(Switch1_out1, 3));
  Unary_Minus_out1 <= Unary_Minus_in0(1 DOWNTO 0);

  
  Switch_out1 <= Unary_Minus_out1 WHEN Compare_To_Constant_out1 = '0' ELSE
      Switch1_out1;

  Data_Type_Conversion1_out1 <= Switch_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';

  pilotOut_re <= ToComplex1_out1_re;

  pilotOut_im <= ToComplex1_out1_im;

END rtl;

