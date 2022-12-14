-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_QAM16_Generator.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_QAM16_Generator
-- Source Path: OFDM_Tx_HW/OFDMTx/DataGenerator/RF Signal Generator/Variable Modulator/QAM16 Generator
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_QAM16_Generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        Data                              :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        Reset_1                           :   IN    std_logic;
        Enable                            :   IN    std_logic;
        I_symbols                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        Q_symbols                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END ofdm_tx_src_QAM16_Generator;


ARCHITECTURE rtl OF ofdm_tx_src_QAM16_Generator IS

  -- Signals
  SIGNAL reduced_reg                      : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Reset_2                          : std_logic;
  SIGNAL Data_unsigned                    : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL Bit_Slice2_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Constant1_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant2_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant3_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant4_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch_out1            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_iv                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_delOut                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_ectrl                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_toDelay                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_bypassIn                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_last_value                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Bit_Slice1_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Multiport_Switch1_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_iv                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_delOut                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_ectrl                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_toDelay                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_bypassIn                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_out1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_last_value                : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        reduced_reg(0) <= Reset_1;
        reduced_reg(1) <= reduced_reg(0);
      END IF;
    END IF;
  END PROCESS reduced_process;

  Reset_2 <= reduced_reg(1);

  Data_unsigned <= unsigned(Data);

  Bit_Slice2_out1 <= Data_unsigned(1 DOWNTO 0);

  Constant1_out1 <= to_signed(16#4333#, 16);

  Constant2_out1 <= to_signed(16#1666#, 16);

  Constant3_out1 <= to_signed(-16#1666#, 16);

  Constant4_out1 <= to_signed(-16#4333#, 16);

  
  Multiport_Switch_out1 <= Constant1_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#0#, 2) ELSE
      Constant2_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#1#, 2) ELSE
      Constant3_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#2#, 2) ELSE
      Constant4_out1;

  Delay1_iv <= to_signed(16#0000#, 16);

  
  Delay1_ectrl <= Delay1_delOut WHEN Enable = '0' ELSE
      Multiport_Switch_out1;

  
  Delay1_toDelay <= Delay1_ectrl WHEN Reset_2 = '0' ELSE
      Delay1_iv;

  Delay1_lowered_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_delOut <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay1_delOut <= Delay1_toDelay;
      END IF;
    END IF;
  END PROCESS Delay1_lowered_process;


  
  Delay1_bypassIn <= Delay1_delOut WHEN Reset_2 = '0' ELSE
      Delay1_iv;

  Delay1_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_last_value <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay1_last_value <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_bypass_process;


  
  Delay1_out1 <= Delay1_last_value WHEN Enable = '0' ELSE
      Delay1_bypassIn;

  I_symbols <= std_logic_vector(Delay1_out1);

  Bit_Slice1_out1 <= Data_unsigned(3 DOWNTO 2);

  
  Multiport_Switch1_out1 <= Constant1_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#0#, 2) ELSE
      Constant2_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#1#, 2) ELSE
      Constant3_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#2#, 2) ELSE
      Constant4_out1;

  Delay2_iv <= to_signed(16#0000#, 16);

  
  Delay2_ectrl <= Delay2_delOut WHEN Enable = '0' ELSE
      Multiport_Switch1_out1;

  
  Delay2_toDelay <= Delay2_ectrl WHEN Reset_2 = '0' ELSE
      Delay2_iv;

  Delay2_lowered_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_delOut <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_delOut <= Delay2_toDelay;
      END IF;
    END IF;
  END PROCESS Delay2_lowered_process;


  
  Delay2_bypassIn <= Delay2_delOut WHEN Reset_2 = '0' ELSE
      Delay2_iv;

  Delay2_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_last_value <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_last_value <= Delay2_out1;
      END IF;
    END IF;
  END PROCESS Delay2_bypass_process;


  
  Delay2_out1 <= Delay2_last_value WHEN Enable = '0' ELSE
      Delay2_bypassIn;

  Q_symbols <= std_logic_vector(Delay2_out1);

END rtl;

