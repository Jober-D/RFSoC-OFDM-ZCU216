-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_ChannelEstimate.vhd
-- Created: 2022-03-24 22:06:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_ChannelEstimate
-- Source Path: OFDM_Rx_HW/OFDMRx/ChannelEstEq/ChannelEstimate
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_ChannelEstimate IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        dataIn_im                         :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        preambleValid                     :   IN    std_logic;
        dataValidIn                       :   IN    std_logic;
        chEstOut_re                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        chEstOut_im                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        dataValidOut                      :   OUT   std_logic
        );
END ofdm_rx_src_ChannelEstimate;


ARCHITECTURE rtl OF ofdm_rx_src_ChannelEstimate IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_ChanEst
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_12_1                      :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          ChanEstIn_re                    :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          ChanEstIn_im                    :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          PreambValidIn                   :   IN    std_logic;
          ChEstOut_re                     :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          ChEstOut_im                     :   OUT   std_logic_vector(16 DOWNTO 0)  -- sfix17_En14
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_WriteEnbAddrGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          In1                             :   IN    std_logic;
          Out1                            :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
          Out2                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_DualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          wr_din_re                       :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_din_im                       :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_dout_re                      :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_dout_im                      :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          rd_dout_re                      :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          rd_dout_im                      :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_ChanEst
    USE ENTITY work.ofdm_rx_src_ChanEst(rtl);

  FOR ALL : ofdm_rx_src_WriteEnbAddrGen
    USE ENTITY work.ofdm_rx_src_WriteEnbAddrGen(rtl);

  FOR ALL : ofdm_rx_src_DualPortRAM_generic
    USE ENTITY work.ofdm_rx_src_DualPortRAM_generic(rtl);

  -- Signals
  SIGNAL ChanEst_out1_re                  : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL ChanEst_out1_im                  : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Delay_reg                        : std_logic_vector(0 TO 4);  -- ufix1 [5]
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL WriteEnbAddrGen_out1             : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL WriteEnbAddrGen_out2             : std_logic;
  SIGNAL Delay1_reg                       : std_logic_vector(0 TO 4);  -- ufix1 [5]
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL HDL_Counter3_out1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Dual_Port_RAM1_out1_re           : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Dual_Port_RAM1_out1_im           : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Dual_Port_RAM1_out2_re           : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Dual_Port_RAM1_out2_im           : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Delay2_out1                      : std_logic;

BEGIN
  -- Note the preamble symbols do not pass this point. 
  -- 
  -- Write averaged channel estimate to RAM and read out when data is valid 
  -- for equalisation of successive OFDM symbols. 
  -- 
  -- Get and store the channel estimate using the two 
  -- repetitions of the L-LTF 

  u_ChanEst : ofdm_rx_src_ChanEst
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_12_1 => enb_1_12_1,
              enb_1_12_0 => enb_1_12_0,
              ChanEstIn_re => dataIn_re,  -- sfix22_En14
              ChanEstIn_im => dataIn_im,  -- sfix22_En14
              PreambValidIn => preambleValid,
              ChEstOut_re => ChanEst_out1_re,  -- sfix17_En14
              ChEstOut_im => ChanEst_out1_im  -- sfix17_En14
              );

  u_WriteEnbAddrGen : ofdm_rx_src_WriteEnbAddrGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              In1 => Delay_out1,
              Out1 => WriteEnbAddrGen_out1,  -- ufix6
              Out2 => WriteEnbAddrGen_out2
              );

  u_Dual_Port_RAM1 : ofdm_rx_src_DualPortRAM_generic
    GENERIC MAP( AddrWidth => 6,
                 DataWidth => 17
                 )
    PORT MAP( clk => clk,
              enb_1_12_0 => enb_1_12_0,
              wr_din_re => ChanEst_out1_re,
              wr_din_im => ChanEst_out1_im,
              wr_addr => WriteEnbAddrGen_out1,
              wr_en => WriteEnbAddrGen_out2,
              rd_addr => std_logic_vector(HDL_Counter3_out1),
              wr_dout_re => Dual_Port_RAM1_out1_re,
              wr_dout_im => Dual_Port_RAM1_out1_im,
              rd_dout_re => Dual_Port_RAM1_out2_re,
              rd_dout_im => Dual_Port_RAM1_out2_im
              );

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay_reg(0) <= preambleValid;
        Delay_reg(1 TO 4) <= Delay_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1 <= Delay_reg(4);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay1_reg(0) <= dataValidIn;
        Delay1_reg(1 TO 4) <= Delay1_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1 <= Delay1_reg(4);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 63
  HDL_Counter3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter3_out1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' AND Delay1_out1 = '1' THEN
        HDL_Counter3_out1 <= HDL_Counter3_out1 + to_unsigned(16#01#, 6);
      END IF;
    END IF;
  END PROCESS HDL_Counter3_process;


  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay2_out1 <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  chEstOut_re <= Dual_Port_RAM1_out2_re;

  chEstOut_im <= Dual_Port_RAM1_out2_im;

  dataValidOut <= Delay2_out1;

END rtl;

