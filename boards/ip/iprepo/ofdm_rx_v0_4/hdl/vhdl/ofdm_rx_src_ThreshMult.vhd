-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_ThreshMult.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_ThreshMult
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/SchmidlCoxMetric /ThreshMult
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_ThreshMult IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En30
        threshold                         :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En31
        Out1                              :   OUT   std_logic_vector(32 DOWNTO 0)  -- sfix33_En23
        );
END ofdm_rx_src_ThreshMult;


ARCHITECTURE rtl OF ofdm_rx_src_ThreshMult IS

  -- Signals
  SIGNAL threshold_unsigned               : unsigned(31 DOWNTO 0);  -- ufix32_En31
  SIGNAL threshold_1                      : unsigned(31 DOWNTO 0);  -- ufix32_En31
  SIGNAL In1_signed                       : signed(35 DOWNTO 0);  -- sfix36_En30
  SIGNAL In1_1                            : signed(35 DOWNTO 0);  -- sfix36_En30
  SIGNAL Product_cast                     : signed(32 DOWNTO 0);  -- sfix33_En31
  SIGNAL Product_mul_temp                 : signed(68 DOWNTO 0);  -- sfix69_En61
  SIGNAL Product_out1                     : signed(67 DOWNTO 0);  -- sfix68_En61
  SIGNAL Product_out1_1                   : signed(67 DOWNTO 0);  -- sfix68_En61
  SIGNAL Product_out1_2                   : signed(32 DOWNTO 0);  -- sfix33_En23

BEGIN
  threshold_unsigned <= unsigned(threshold);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      threshold_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        threshold_1 <= threshold_unsigned;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  In1_signed <= signed(In1);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In1_1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        In1_1 <= In1_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Product_cast <= signed(resize(threshold_1, 33));
  Product_mul_temp <= Product_cast * In1_1;
  Product_out1 <= Product_mul_temp(67 DOWNTO 0);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_1 <= to_signed(0, 68);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_out1_1 <= Product_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Product_out1_2 <= (resize(Product_out1_1(67 DOWNTO 38), 33)) + ('0' & (Product_out1_1(37) AND (( NOT Product_out1_1(67)) OR (Product_out1_1(36) OR Product_out1_1(35) OR Product_out1_1(34) OR Product_out1_1(33) OR Product_out1_1(32) OR Product_out1_1(31) OR Product_out1_1(30) OR Product_out1_1(29) OR Product_out1_1(28) OR Product_out1_1(27) OR Product_out1_1(26) OR Product_out1_1(25) OR Product_out1_1(24) OR Product_out1_1(23) OR Product_out1_1(22) OR Product_out1_1(21) OR Product_out1_1(20) OR Product_out1_1(19) OR Product_out1_1(18) OR Product_out1_1(17) OR Product_out1_1(16) OR Product_out1_1(15) OR Product_out1_1(14) OR Product_out1_1(13) OR Product_out1_1(12) OR Product_out1_1(11) OR Product_out1_1(10) OR Product_out1_1(9) OR Product_out1_1(8) OR Product_out1_1(7) OR Product_out1_1(6) OR Product_out1_1(5) OR Product_out1_1(4) OR Product_out1_1(3) OR Product_out1_1(2) OR Product_out1_1(1) OR Product_out1_1(0)))));

  Out1 <= std_logic_vector(Product_out1_2);

END rtl;

