-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_GAIN_CORR_block.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_GAIN_CORR_block
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_2/CordicRotate/GAIN_CORR
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_GAIN_CORR_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        XIN                               :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En15
        XOUT                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END ofdm_rx_src_GAIN_CORR_block;


ARCHITECTURE rtl OF ofdm_rx_src_GAIN_CORR_block IS

  -- Signals
  SIGNAL Constant_out1                    : signed(17 DOWNTO 0);  -- sfix18_En17
  SIGNAL Constant_out1_1                  : signed(17 DOWNTO 0);  -- sfix18_En17
  SIGNAL XIN_signed                       : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL XIN_1                            : signed(20 DOWNTO 0);  -- sfix21_En15
  SIGNAL Product_mul_temp                 : signed(38 DOWNTO 0);  -- sfix39_En32
  SIGNAL Product_out1                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_out1_1                   : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  Constant_out1 <= to_signed(16#136EA#, 18);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Constant_out1_1 <= to_signed(16#00000#, 18);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Constant_out1_1 <= Constant_out1;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  XIN_signed <= signed(XIN);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      XIN_1 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        XIN_1 <= XIN_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Product_mul_temp <= Constant_out1_1 * XIN_1;
  Product_out1 <= Product_mul_temp(33 DOWNTO 18);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_out1_1 <= Product_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  XOUT <= std_logic_vector(Product_out1_1);

END rtl;

