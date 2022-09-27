-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_STFExtend.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_STFExtend
-- Source Path: OFDM_Tx_HW/OFDMTx/CPAdd/STFExtend
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_tx_src_OFDMTx_pkg.ALL;

ENTITY ofdm_tx_src_STFExtend IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        data_re                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        data_im                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        preambVal                         :   IN    std_logic;
        STFExtendOut_re                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        STFExtendOut_im                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        STFValidOut                       :   OUT   std_logic
        );
END ofdm_tx_src_STFExtend;


ARCHITECTURE rtl OF ofdm_tx_src_STFExtend IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_STFValidGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          In1                             :   IN    std_logic;
          Out1                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_READ_CTRL_block
    PORT( In1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          In2                             :   IN    std_logic;
          Out1                            :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_DualPortRAM_generic
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
  FOR ALL : ofdm_tx_src_STFValidGen
    USE ENTITY work.ofdm_tx_src_STFValidGen(rtl);

  FOR ALL : ofdm_tx_src_READ_CTRL_block
    USE ENTITY work.ofdm_tx_src_READ_CTRL_block(rtl);

  FOR ALL : ofdm_tx_src_DualPortRAM_generic
    USE ENTITY work.ofdm_tx_src_DualPortRAM_generic(rtl);

  -- Constants
  CONSTANT readaddr_data                  : vector_of_unsigned8(0 TO 159) := 
    (to_unsigned(16#60#, 8), to_unsigned(16#61#, 8), to_unsigned(16#62#, 8), to_unsigned(16#63#, 8),
     to_unsigned(16#64#, 8), to_unsigned(16#65#, 8), to_unsigned(16#66#, 8), to_unsigned(16#67#, 8),
     to_unsigned(16#68#, 8), to_unsigned(16#69#, 8), to_unsigned(16#6A#, 8), to_unsigned(16#6B#, 8),
     to_unsigned(16#6C#, 8), to_unsigned(16#6D#, 8), to_unsigned(16#6E#, 8), to_unsigned(16#6F#, 8),
     to_unsigned(16#70#, 8), to_unsigned(16#71#, 8), to_unsigned(16#72#, 8), to_unsigned(16#73#, 8),
     to_unsigned(16#74#, 8), to_unsigned(16#75#, 8), to_unsigned(16#76#, 8), to_unsigned(16#77#, 8),
     to_unsigned(16#78#, 8), to_unsigned(16#79#, 8), to_unsigned(16#7A#, 8), to_unsigned(16#7B#, 8),
     to_unsigned(16#7C#, 8), to_unsigned(16#7D#, 8), to_unsigned(16#7E#, 8), to_unsigned(16#7F#, 8),
     to_unsigned(16#60#, 8), to_unsigned(16#61#, 8), to_unsigned(16#62#, 8), to_unsigned(16#63#, 8),
     to_unsigned(16#64#, 8), to_unsigned(16#65#, 8), to_unsigned(16#66#, 8), to_unsigned(16#67#, 8),
     to_unsigned(16#68#, 8), to_unsigned(16#69#, 8), to_unsigned(16#6A#, 8), to_unsigned(16#6B#, 8),
     to_unsigned(16#6C#, 8), to_unsigned(16#6D#, 8), to_unsigned(16#6E#, 8), to_unsigned(16#6F#, 8),
     to_unsigned(16#70#, 8), to_unsigned(16#71#, 8), to_unsigned(16#72#, 8), to_unsigned(16#73#, 8),
     to_unsigned(16#74#, 8), to_unsigned(16#75#, 8), to_unsigned(16#76#, 8), to_unsigned(16#77#, 8),
     to_unsigned(16#78#, 8), to_unsigned(16#79#, 8), to_unsigned(16#7A#, 8), to_unsigned(16#7B#, 8),
     to_unsigned(16#7C#, 8), to_unsigned(16#7D#, 8), to_unsigned(16#7E#, 8), to_unsigned(16#7F#, 8),
     to_unsigned(16#80#, 8), to_unsigned(16#81#, 8), to_unsigned(16#82#, 8), to_unsigned(16#83#, 8),
     to_unsigned(16#84#, 8), to_unsigned(16#85#, 8), to_unsigned(16#86#, 8), to_unsigned(16#87#, 8),
     to_unsigned(16#88#, 8), to_unsigned(16#89#, 8), to_unsigned(16#8A#, 8), to_unsigned(16#8B#, 8),
     to_unsigned(16#8C#, 8), to_unsigned(16#8D#, 8), to_unsigned(16#8E#, 8), to_unsigned(16#8F#, 8),
     to_unsigned(16#90#, 8), to_unsigned(16#91#, 8), to_unsigned(16#92#, 8), to_unsigned(16#93#, 8),
     to_unsigned(16#94#, 8), to_unsigned(16#95#, 8), to_unsigned(16#96#, 8), to_unsigned(16#97#, 8),
     to_unsigned(16#98#, 8), to_unsigned(16#99#, 8), to_unsigned(16#9A#, 8), to_unsigned(16#9B#, 8),
     to_unsigned(16#9C#, 8), to_unsigned(16#9D#, 8), to_unsigned(16#9E#, 8), to_unsigned(16#9F#, 8),
     to_unsigned(16#60#, 8), to_unsigned(16#61#, 8), to_unsigned(16#62#, 8), to_unsigned(16#63#, 8),
     to_unsigned(16#64#, 8), to_unsigned(16#65#, 8), to_unsigned(16#66#, 8), to_unsigned(16#67#, 8),
     to_unsigned(16#68#, 8), to_unsigned(16#69#, 8), to_unsigned(16#6A#, 8), to_unsigned(16#6B#, 8),
     to_unsigned(16#6C#, 8), to_unsigned(16#6D#, 8), to_unsigned(16#6E#, 8), to_unsigned(16#6F#, 8),
     to_unsigned(16#70#, 8), to_unsigned(16#71#, 8), to_unsigned(16#72#, 8), to_unsigned(16#73#, 8),
     to_unsigned(16#74#, 8), to_unsigned(16#75#, 8), to_unsigned(16#76#, 8), to_unsigned(16#77#, 8),
     to_unsigned(16#78#, 8), to_unsigned(16#79#, 8), to_unsigned(16#7A#, 8), to_unsigned(16#7B#, 8),
     to_unsigned(16#7C#, 8), to_unsigned(16#7D#, 8), to_unsigned(16#7E#, 8), to_unsigned(16#7F#, 8),
     to_unsigned(16#80#, 8), to_unsigned(16#81#, 8), to_unsigned(16#82#, 8), to_unsigned(16#83#, 8),
     to_unsigned(16#84#, 8), to_unsigned(16#85#, 8), to_unsigned(16#86#, 8), to_unsigned(16#87#, 8),
     to_unsigned(16#88#, 8), to_unsigned(16#89#, 8), to_unsigned(16#8A#, 8), to_unsigned(16#8B#, 8),
     to_unsigned(16#8C#, 8), to_unsigned(16#8D#, 8), to_unsigned(16#8E#, 8), to_unsigned(16#8F#, 8),
     to_unsigned(16#90#, 8), to_unsigned(16#91#, 8), to_unsigned(16#92#, 8), to_unsigned(16#93#, 8),
     to_unsigned(16#94#, 8), to_unsigned(16#95#, 8), to_unsigned(16#96#, 8), to_unsigned(16#97#, 8),
     to_unsigned(16#98#, 8), to_unsigned(16#99#, 8), to_unsigned(16#9A#, 8), to_unsigned(16#9B#, 8),
     to_unsigned(16#9C#, 8), to_unsigned(16#9D#, 8), to_unsigned(16#9E#, 8), to_unsigned(16#9F#, 8));  -- ufix8 [160]

  -- Signals
  SIGNAL STFValidGen_out1                 : std_logic;
  SIGNAL HDL_Counter3_out1                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL delayMatch1_reg                  : vector_of_unsigned8(0 TO 1);  -- ufix8 [2]
  SIGNAL HDL_Counter3_out1_1              : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reduced_reg                      : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL STFValidGen_out1_1               : std_logic;
  SIGNAL reduced_reg_1                    : std_logic_vector(0 TO 157);  -- ufix1 [158]
  SIGNAL STFValidGen_out1_2               : std_logic;
  SIGNAL HDL_Counter2_out1                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL HDL_Counter2_out1_1              : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL readaddr_k                       : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL readaddr_out1                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL readaddr_out1_1                  : unsigned(7 DOWNTO 0) := to_unsigned(16#00#, 8);  -- uint8
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL Delay_out1_1                     : std_logic;
  SIGNAL READ_CTRL_out1                   : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL READ_CTRL_out1_unsigned          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL READ_CTRL_out1_1                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL READ_CTRL_out1_2                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Dual_Port_RAM_out1_re            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Dual_Port_RAM_out1_im            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Dual_Port_RAM_out2_re            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Dual_Port_RAM_out2_im            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Delay12_out1                     : std_logic;

BEGIN
  u_STFValidGen : ofdm_tx_src_STFValidGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              In1 => preambVal,
              Out1 => STFValidGen_out1
              );

  u_READ_CTRL : ofdm_tx_src_READ_CTRL_block
    PORT MAP( In1 => std_logic_vector(readaddr_out1_1),  -- uint8
              In2 => Delay_out1_1,
              Out1 => READ_CTRL_out1  -- uint8
              );

  u_Dual_Port_RAM : ofdm_tx_src_DualPortRAM_generic
    GENERIC MAP( AddrWidth => 8,
                 DataWidth => 16
                 )
    PORT MAP( clk => clk,
              enb_1_12_0 => enb_1_12_0,
              wr_din_re => data_re,
              wr_din_im => data_im,
              wr_addr => std_logic_vector(HDL_Counter3_out1_1),
              wr_en => STFValidGen_out1_1,
              rd_addr => std_logic_vector(READ_CTRL_out1_2),
              wr_dout_re => Dual_Port_RAM_out1_re,
              wr_dout_im => Dual_Port_RAM_out1_im,
              rd_dout_re => Dual_Port_RAM_out2_re,
              rd_dout_im => Dual_Port_RAM_out2_im
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 159
  HDL_Counter3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter3_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF STFValidGen_out1 = '1' THEN 
          IF HDL_Counter3_out1 >= to_unsigned(16#9F#, 8) THEN 
            HDL_Counter3_out1 <= to_unsigned(16#00#, 8);
          ELSE 
            HDL_Counter3_out1 <= HDL_Counter3_out1 + to_unsigned(16#01#, 8);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter3_process;


  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => to_unsigned(16#00#, 8));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        delayMatch1_reg(0) <= HDL_Counter3_out1;
        delayMatch1_reg(1) <= delayMatch1_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  HDL_Counter3_out1_1 <= delayMatch1_reg(1);

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        reduced_reg(0) <= STFValidGen_out1;
        reduced_reg(1) <= reduced_reg(0);
      END IF;
    END IF;
  END PROCESS reduced_process;

  STFValidGen_out1_1 <= reduced_reg(1);

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg_1 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        reduced_reg_1(0) <= STFValidGen_out1_1;
        reduced_reg_1(1 TO 157) <= reduced_reg_1(0 TO 156);
      END IF;
    END IF;
  END PROCESS reduced_1_process;

  STFValidGen_out1_2 <= reduced_reg_1(157);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 159
  HDL_Counter2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter2_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF STFValidGen_out1_2 = '1' THEN 
          IF HDL_Counter2_out1 >= to_unsigned(16#9F#, 8) THEN 
            HDL_Counter2_out1 <= to_unsigned(16#00#, 8);
          ELSE 
            HDL_Counter2_out1 <= HDL_Counter2_out1 + to_unsigned(16#01#, 8);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter2_process;


  HDL_Counter2_out1_1 <= HDL_Counter2_out1;

  
  readaddr_k <= to_unsigned(16#00#, 8) WHEN HDL_Counter2_out1_1 = to_unsigned(16#00#, 8) ELSE
      to_unsigned(16#9F#, 8) WHEN HDL_Counter2_out1_1 >= to_unsigned(16#9F#, 8) ELSE
      HDL_Counter2_out1_1;
  readaddr_out1 <= readaddr_data(to_integer(readaddr_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        readaddr_out1_1 <= readaddr_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay_out1 <= STFValidGen_out1_2;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1_1 <= Delay_out1;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  READ_CTRL_out1_unsigned <= unsigned(READ_CTRL_out1);

  Dual_Port_RAM1_output_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      READ_CTRL_out1_1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        READ_CTRL_out1_1 <= READ_CTRL_out1_unsigned;
      END IF;
    END IF;
  END PROCESS Dual_Port_RAM1_output_process;


  delayMatch3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      READ_CTRL_out1_2 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        READ_CTRL_out1_2 <= READ_CTRL_out1_1;
      END IF;
    END IF;
  END PROCESS delayMatch3_process;


  Delay12_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay12_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Delay12_out1 <= STFValidGen_out1_2;
      END IF;
    END IF;
  END PROCESS Delay12_process;


  STFExtendOut_re <= Dual_Port_RAM_out2_re;

  STFExtendOut_im <= Dual_Port_RAM_out2_im;

  STFValidOut <= Delay12_out1;

END rtl;

