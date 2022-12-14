-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Delay.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Delay
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/Delay
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_Delay IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        data_re                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        data_im                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        strobe                            :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        strobeOut                         :   OUT   std_logic
        );
END ofdm_rx_src_Delay;


ARCHITECTURE rtl OF ofdm_rx_src_Delay IS

  -- Signals
  SIGNAL Delay3_reg                       : std_logic_vector(0 TO 107);  -- ufix1 [108]
  SIGNAL Delay3_out1                      : std_logic;

BEGIN
  -- Delay coarse timing point from middle of L-STF 
  -- to beginning of 1st repetition of L-LTF

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay3_reg(0) <= strobe;
        Delay3_reg(1 TO 107) <= Delay3_reg(0 TO 106);
      END IF;
    END IF;
  END PROCESS Delay3_process;

  Delay3_out1 <= Delay3_reg(107);

  dataOut_re <= data_re;

  dataOut_im <= data_im;

  strobeOut <= Delay3_out1;

END rtl;

