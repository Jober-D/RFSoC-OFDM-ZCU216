-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_RisingEdge.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_RisingEdge
-- Source Path: OFDM_Tx_HW/OFDMTx/ControlSignalGenerator/PreamValidGen/RisingEdge
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_RisingEdge IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        In1                               :   IN    std_logic;
        Out1                              :   OUT   std_logic
        );
END ofdm_tx_src_RisingEdge;


ARCHITECTURE rtl OF ofdm_tx_src_RisingEdge IS

  -- Signals
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL Relational_Operator_relop1       : std_logic;

BEGIN
  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay_out1 <= In1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  
  Relational_Operator_relop1 <= '1' WHEN In1 > Delay_out1 ELSE
      '0';

  Out1 <= Relational_Operator_relop1;

END rtl;

