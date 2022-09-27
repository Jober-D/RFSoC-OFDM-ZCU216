-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_RisingEdge.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_RisingEdge
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/ControlSigGen/PreambleValidGen/RisingEdge
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_RisingEdge IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        ValidIn                           :   IN    std_logic;
        Out1                              :   OUT   std_logic
        );
END ofdm_rx_src_RisingEdge;


ARCHITECTURE rtl OF ofdm_rx_src_RisingEdge IS

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
        Delay_out1 <= ValidIn;
      END IF;
    END IF;
  END PROCESS Delay_process;


  
  Relational_Operator_relop1 <= '1' WHEN ValidIn > Delay_out1 ELSE
      '0';

  Out1 <= Relational_Operator_relop1;

END rtl;
