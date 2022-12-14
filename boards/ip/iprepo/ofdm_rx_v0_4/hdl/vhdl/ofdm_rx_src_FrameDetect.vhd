-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_FrameDetect.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_FrameDetect
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/FrameDetect
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_FrameDetect IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        leftIn                            :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
        rightIn                           :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33_En23
        phaseIn                           :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En22
        frameDet                          :   OUT   std_logic;
        phaseOut                          :   OUT   std_logic_vector(24 DOWNTO 0)  -- sfix25_En22
        );
END ofdm_rx_src_FrameDetect;


ARCHITECTURE rtl OF ofdm_rx_src_FrameDetect IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_RsingEdge_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          In1                             :   IN    std_logic;
          Out1                            :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_RsingEdge_block
    USE ENTITY work.ofdm_rx_src_RsingEdge_block(rtl);

  -- Signals
  SIGNAL leftIn_signed                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay2_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL rightIn_signed                   : signed(32 DOWNTO 0);  -- sfix33_En23
  SIGNAL Relational_Operator_1_cast       : signed(41 DOWNTO 0);  -- sfix42_En32
  SIGNAL Relational_Operator_1_cast_1     : signed(41 DOWNTO 0);  -- sfix42_En32
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL RsingEdge_out1                   : std_logic;
  SIGNAL phaseIn_signed                   : signed(24 DOWNTO 0);  -- sfix25_En22
  SIGNAL Delay4_out1                      : signed(24 DOWNTO 0);  -- sfix25_En22
  SIGNAL Delay_out1                       : signed(24 DOWNTO 0);  -- sfix25_En22

BEGIN
  -- The frame is detected when the timing metric exceeds the threshold for 30 successive samples. This 
  -- corresponds to the coarse timing point, which should occur in the middle of the L-STF.  

  u_RsingEdge : ofdm_rx_src_RsingEdge_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              In1 => Compare_To_Constant_out1,
              Out1 => RsingEdge_out1
              );

  leftIn_signed <= signed(leftIn);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_out1 <= leftIn_signed;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  rightIn_signed <= signed(rightIn);

  Relational_Operator_1_cast <= resize(Delay2_out1, 42);
  Relational_Operator_1_cast_1 <= rightIn_signed & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
  
  Relational_Operator_relop1 <= '1' WHEN Relational_Operator_1_cast > Relational_Operator_1_cast_1 ELSE
      '0';

  Logical_Operator1_out1 <=  NOT Relational_Operator_relop1;

  Logical_Operator_out1 <= Compare_To_Constant_out1 OR Logical_Operator1_out1;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 29
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#00#, 5);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF Logical_Operator_out1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#00#, 5);
        ELSIF Relational_Operator_relop1 = '1' THEN 
          IF HDL_Counter_out1 >= to_unsigned(16#1D#, 5) THEN 
            HDL_Counter_out1 <= to_unsigned(16#00#, 5);
          ELSE 
            HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#01#, 5);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Constant_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(16#1D#, 5) ELSE
      '0';

  phaseIn_signed <= signed(phaseIn);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay4_out1 <= phaseIn_signed;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay_out1 <= Delay4_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  phaseOut <= std_logic_vector(Delay_out1);

  frameDet <= RsingEdge_out1;

END rtl;

