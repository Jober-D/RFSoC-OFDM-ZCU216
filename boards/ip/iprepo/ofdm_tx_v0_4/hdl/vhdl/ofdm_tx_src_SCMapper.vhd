-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_SCMapper.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_SCMapper
-- Source Path: OFDM_Tx_HW/OFDMTx/SCMapper
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_SCMapper IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        enb_1_12_1                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        preambValid                       :   IN    std_logic;
        dataValid                         :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        preambValidOut                    :   OUT   std_logic;
        dataValidOut                      :   OUT   std_logic
        );
END ofdm_tx_src_SCMapper;


ARCHITECTURE rtl OF ofdm_tx_src_SCMapper IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_PremableMapper
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          enb_1_12_1                      :   IN    std_logic;
          enb                             :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambVal                       :   IN    std_logic;
          preambleShiftOut_re             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambleShiftOut_im             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambValOut                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_DataMapper
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          enb_1_12_1                      :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataValid                       :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataValidOut                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_Mux2_block
    PORT( preamb_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preamb_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambVal                       :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataVal                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_PremableMapper
    USE ENTITY work.ofdm_tx_src_PremableMapper(rtl);

  FOR ALL : ofdm_tx_src_DataMapper
    USE ENTITY work.ofdm_tx_src_DataMapper(rtl);

  FOR ALL : ofdm_tx_src_Mux2_block
    USE ENTITY work.ofdm_tx_src_Mux2_block(rtl);

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Dual_Port_RAM_bypass_reg_re      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Dual_Port_RAM_bypass_reg_im      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_2                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_2                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL preambValid_1                    : std_logic;
  SIGNAL PremableMapper_out1_re           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL PremableMapper_out1_im           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL PremableMapper_out2              : std_logic;
  SIGNAL Dual_Port_RAM2_bypass_reg_re     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Dual_Port_RAM2_bypass_reg_im     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_3                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_3                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataValid_1                      : std_logic;
  SIGNAL DataMapper_out1_re               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataMapper_out1_im               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataMapper_out2                  : std_logic;
  SIGNAL PremableMapper_out1_re_1         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL PremableMapper_out1_im_1         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL PremableMapper_out2_1            : std_logic;
  SIGNAL DataMapper_out1_re_1             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataMapper_out1_im_1             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataMapper_out2_1                : std_logic;
  SIGNAL dataOut_re_1                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dataOut_im_1                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dataOut_re_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_im_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_re_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_im_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL PremableMapper_out2_2            : std_logic;
  SIGNAL PremableMapper_out2_3            : std_logic;
  SIGNAL DataMapper_out2_2                : std_logic;
  SIGNAL DataMapper_out2_3                : std_logic;

BEGIN
  u_PremableMapper : ofdm_tx_src_PremableMapper
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              enb_1_12_1 => enb_1_12_1,
              enb => enb,
              data_re => std_logic_vector(dataIn_re_2),  -- sfix16_En14
              data_im => std_logic_vector(dataIn_im_2),  -- sfix16_En14
              preambVal => preambValid_1,
              preambleShiftOut_re => PremableMapper_out1_re,  -- sfix16_En14
              preambleShiftOut_im => PremableMapper_out1_im,  -- sfix16_En14
              preambValOut => PremableMapper_out2
              );

  u_DataMapper : ofdm_tx_src_DataMapper
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              enb_1_12_1 => enb_1_12_1,
              enb => enb,
              dataIn_re => std_logic_vector(dataIn_re_3),  -- sfix16_En14
              dataIn_im => std_logic_vector(dataIn_im_3),  -- sfix16_En14
              dataValid => dataValid_1,
              dataOut_re => DataMapper_out1_re,  -- sfix16_En14
              dataOut_im => DataMapper_out1_im,  -- sfix16_En14
              dataValidOut => DataMapper_out2
              );

  u_Mux2 : ofdm_tx_src_Mux2_block
    PORT MAP( preamb_re => PremableMapper_out1_re_1,  -- sfix16_En14
              preamb_im => PremableMapper_out1_im_1,  -- sfix16_En14
              preambVal => PremableMapper_out2_1,
              data_re => DataMapper_out1_re_1,  -- sfix16_En14
              data_im => DataMapper_out1_im_1,  -- sfix16_En14
              dataVal => DataMapper_out2_1,
              dataOut_re => dataOut_re_1,  -- sfix16_En14
              dataOut_im => dataOut_im_1  -- sfix16_En14
              );

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  in_0_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataIn_re_1 <= to_signed(16#0000#, 16);
      dataIn_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dataIn_re_1 <= dataIn_re_signed;
        dataIn_im_1 <= dataIn_im_signed;
      END IF;
    END IF;
  END PROCESS in_0_pipe_in_pipe_process;


  Dual_Port_RAM_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Dual_Port_RAM_bypass_reg_re <= to_signed(16#0000#, 16);
      Dual_Port_RAM_bypass_reg_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Dual_Port_RAM_bypass_reg_im <= dataIn_im_1;
        Dual_Port_RAM_bypass_reg_re <= dataIn_re_1;
      END IF;
    END IF;
  END PROCESS Dual_Port_RAM_bypass_process;

  
  dataIn_re_2 <= dataIn_re_1 WHEN enb_1_12_1 = '1' ELSE
      Dual_Port_RAM_bypass_reg_re;
  
  dataIn_im_2 <= dataIn_im_1 WHEN enb_1_12_1 = '1' ELSE
      Dual_Port_RAM_bypass_reg_im;

  in_1_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      preambValid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        preambValid_1 <= preambValid;
      END IF;
    END IF;
  END PROCESS in_1_pipe_in_pipe_process;


  Dual_Port_RAM2_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Dual_Port_RAM2_bypass_reg_re <= to_signed(16#0000#, 16);
      Dual_Port_RAM2_bypass_reg_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_1 = '1' THEN
        Dual_Port_RAM2_bypass_reg_im <= dataIn_im_1;
        Dual_Port_RAM2_bypass_reg_re <= dataIn_re_1;
      END IF;
    END IF;
  END PROCESS Dual_Port_RAM2_bypass_process;

  
  dataIn_re_3 <= dataIn_re_1 WHEN enb_1_12_1 = '1' ELSE
      Dual_Port_RAM2_bypass_reg_re;
  
  dataIn_im_3 <= dataIn_im_1 WHEN enb_1_12_1 = '1' ELSE
      Dual_Port_RAM2_bypass_reg_im;

  in_2_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataValid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        dataValid_1 <= dataValid;
      END IF;
    END IF;
  END PROCESS in_2_pipe_in_pipe_process;


  PremableMapper_out1_re_1 <= std_logic_vector(signed(PremableMapper_out1_re));

  PremableMapper_out1_im_1 <= std_logic_vector(signed(PremableMapper_out1_im));

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      PremableMapper_out2_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        PremableMapper_out2_1 <= PremableMapper_out2;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  DataMapper_out1_re_1 <= std_logic_vector(signed(DataMapper_out1_re));

  DataMapper_out1_im_1 <= std_logic_vector(signed(DataMapper_out1_im));

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      DataMapper_out2_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        DataMapper_out2_1 <= DataMapper_out2;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  dataOut_re_signed <= signed(dataOut_re_1);

  dataOut_im_signed <= signed(dataOut_im_1);

  out_0_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOut_re_tmp <= to_signed(16#0000#, 16);
      dataOut_im_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dataOut_re_tmp <= dataOut_re_signed;
        dataOut_im_tmp <= dataOut_im_signed;
      END IF;
    END IF;
  END PROCESS out_0_pipe_in_pipe_process;


  dataOut_re <= std_logic_vector(dataOut_re_tmp);

  dataOut_im <= std_logic_vector(dataOut_im_tmp);

  PremableMapper_out2_2 <= PremableMapper_out2;

  out_1_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      PremableMapper_out2_3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        PremableMapper_out2_3 <= PremableMapper_out2_2;
      END IF;
    END IF;
  END PROCESS out_1_pipe_in_pipe_process;


  DataMapper_out2_2 <= DataMapper_out2;

  out_2_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      DataMapper_out2_3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        DataMapper_out2_3 <= DataMapper_out2_2;
      END IF;
    END IF;
  END PROCESS out_2_pipe_in_pipe_process;


  preambValidOut <= PremableMapper_out2_3;

  dataValidOut <= DataMapper_out2_3;

END rtl;

