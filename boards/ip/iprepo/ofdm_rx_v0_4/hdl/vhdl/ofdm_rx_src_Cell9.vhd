-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Cell9.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Cell9
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/CordicRotate/Cell9
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_Cell9 IS
  PORT( X_in_0                            :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En15
        Y_in_0                            :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En15
        Ang_in_0                          :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
        X_out_0                           :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En15
        Y_out_0                           :   OUT   std_logic_vector(20 DOWNTO 0)  -- sfix21_En15
        );
END ofdm_rx_src_Cell9;


ARCHITECTURE rtl OF ofdm_rx_src_Cell9 IS

  -- Signals
  SIGNAL Ang_in_0_signed                  : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL X_in_0_signed                    : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Y_in_0_signed                    : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Shift_Arithmetic1_out1           : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Add1_out1                        : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Add4_out1                        : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Switch_out1                      : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL Shift_Arithmetic_out1            : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Add3_out1                        : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Add2_out1                        : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Switch1_out1                     : signed(20 DOWNTO 0);  -- sfix21_En15

BEGIN
  Ang_in_0_signed <= signed(Ang_in_0);

  
  Compare_To_Constant_out1 <= '1' WHEN Ang_in_0_signed < to_signed(16#000000#, 23) ELSE
      '0';

  X_in_0_signed <= signed(X_in_0);

  Y_in_0_signed <= signed(Y_in_0);

  Shift_Arithmetic1_out1 <= SHIFT_RIGHT(Y_in_0_signed, 9);

  Add1_out1 <= X_in_0_signed - Shift_Arithmetic1_out1;

  Add4_out1 <= X_in_0_signed + Shift_Arithmetic1_out1;

  
  Switch_out1 <= Add1_out1 WHEN Compare_To_Constant_out1 = '0' ELSE
      Add4_out1;

  X_out_0 <= std_logic_vector(Switch_out1);

  Logical_Operator1_out1 <=  NOT Compare_To_Constant_out1;

  Shift_Arithmetic_out1 <= SHIFT_RIGHT(X_in_0_signed, 9);

  Add3_out1 <= Y_in_0_signed - Shift_Arithmetic_out1;

  Add2_out1 <= Y_in_0_signed + Shift_Arithmetic_out1;

  
  Switch1_out1 <= Add3_out1 WHEN Logical_Operator1_out1 = '0' ELSE
      Add2_out1;

  Y_out_0 <= std_logic_vector(Switch1_out1);

END rtl;
