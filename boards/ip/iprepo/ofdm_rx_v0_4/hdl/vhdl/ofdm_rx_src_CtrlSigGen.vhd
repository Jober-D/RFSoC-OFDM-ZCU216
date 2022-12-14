-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_CtrlSigGen.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_CtrlSigGen
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/PilotCtrlGen/CtrlSigGen
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_CtrlSigGen IS
  PORT( valid                             :   IN    std_logic;
        sampleCount                       :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        dataValid                         :   OUT   std_logic;
        pilotEnd                          :   OUT   std_logic
        );
END ofdm_rx_src_CtrlSigGen;


ARCHITECTURE rtl OF ofdm_rx_src_CtrlSigGen IS

  -- Signals
  SIGNAL sampleCount_unsigned             : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Logical_Operator5_out1           : std_logic;

BEGIN
  sampleCount_unsigned <= unsigned(sampleCount);

  
  Compare_To_Constant1_out1 <= '1' WHEN sampleCount_unsigned = to_unsigned(16#03#, 6) ELSE
      '0';

  Logical_Operator5_out1 <= valid AND Compare_To_Constant1_out1;

  dataValid <= valid;

  pilotEnd <= Logical_Operator5_out1;

END rtl;

