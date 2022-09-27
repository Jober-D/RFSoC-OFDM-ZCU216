-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_dataValidGen.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_dataValidGen
-- Source Path: OFDM_Tx_HW/OFDMTx/ControlSignalGenerator/dataValidGen
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_dataValidGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        y                                 :   IN    std_logic;
        enable                            :   IN    std_logic;
        valOut                            :   OUT   std_logic
        );
END ofdm_tx_src_dataValidGen;


ARCHITECTURE rtl OF ofdm_tx_src_dataValidGen IS

  -- Signals
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL AND_out1                         : std_logic;

BEGIN
  NOT_out1 <=  NOT y;

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay_out1 <= enable;
      END IF;
    END IF;
  END PROCESS Delay_process;


  AND_out1 <= NOT_out1 AND Delay_out1;

  valOut <= AND_out1;

END rtl;

