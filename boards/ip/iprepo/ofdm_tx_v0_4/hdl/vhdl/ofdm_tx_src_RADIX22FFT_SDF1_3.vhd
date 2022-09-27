-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_RADIX22FFT_SDF1_3.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_RADIX22FFT_SDF1_3
-- Source Path: OFDM_Tx_HW/OFDMTx/IFFT/IFFT HDL Optimized/RADIX22FFT_SDF1_3
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_RADIX22FFT_SDF1_3 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        din_3_1_re_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_3_1_im_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_3_vld_dly                     :   IN    std_logic;
        rd_3_Addr                         :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        rd_3_Enb                          :   IN    std_logic;
        twdl_3_1_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_3_1_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_3_1_vld                      :   IN    std_logic;
        proc_3_enb                        :   IN    std_logic;
        softReset                         :   IN    std_logic;
        dout_3_1_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dout_3_1_im                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dout_3_1_vld                      :   OUT   std_logic;
        dinXTwdl_3_1_vld                  :   OUT   std_logic
        );
END ofdm_tx_src_RADIX22FFT_SDF1_3;


ARCHITECTURE rtl OF ofdm_tx_src_RADIX22FFT_SDF1_3 IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_Complex3Multiply
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          din_3_1_re_dly                  :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          din_3_1_im_dly                  :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          din_3_vld_dly                   :   IN    std_logic;
          twdl_3_1_re                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_3_1_im                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          softReset                       :   IN    std_logic;
          dinXTwdl_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dinXTwdl_im                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dinXTwdl_3_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_SDFCommutator3
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          din_3_vld_dly                   :   IN    std_logic;
          xf_re                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          xf_im                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          xf_vld                          :   IN    std_logic;
          dinXTwdlf_re                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dinXTwdlf_im                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dinxTwdlf_vld                   :   IN    std_logic;
          btf1_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          btf1_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          btf2_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          btf2_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          btf_vld                         :   IN    std_logic;
          softReset                       :   IN    std_logic;
          wrData_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          wrData_im                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          wrAddr                          :   OUT   std_logic_vector(2 DOWNTO 0);  -- ufix3
          wrEnb                           :   OUT   std_logic;
          dout_3_1_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dout_3_1_im                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dout_3_1_vld                    :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_Complex3Multiply
    USE ENTITY work.ofdm_tx_src_Complex3Multiply(rtl);

  FOR ALL : ofdm_tx_src_SimpleDualPortRAM_generic
    USE ENTITY work.ofdm_tx_src_SimpleDualPortRAM_generic(rtl);

  FOR ALL : ofdm_tx_src_SDFCommutator3
    USE ENTITY work.ofdm_tx_src_SDFCommutator3(rtl);

  -- Signals
  SIGNAL dinXTwdl_re                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dinXTwdl_im                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dinXTwdl_3_1_vld_1               : std_logic;
  SIGNAL dinXTwdl_re_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinXTwdl_im_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL x_vld                            : std_logic;
  SIGNAL btf2_im                          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL btf2_re                          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL btf1_im                          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL btf1_re                          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinXTwdlf_im                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinXTwdlf_re                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL xf_im                            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL wrData_im                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL wrAddr                           : std_logic_vector(2 DOWNTO 0);  -- ufix3
  SIGNAL wrEnb                            : std_logic;
  SIGNAL x_im                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL x_im_signed                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL wrData_re                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL x_re                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL x_re_signed                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Radix22ButterflyG1_btf1_re_reg   : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_btf1_im_reg   : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_btf2_re_reg   : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_btf2_im_reg   : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_x_re_dly1     : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_x_im_dly1     : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_x_vld_dly1    : std_logic;
  SIGNAL Radix22ButterflyG1_dinXtwdl_re_dly1 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_dinXtwdl_im_dly1 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_dinXtwdl_re_dly2 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_dinXtwdl_im_dly2 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Radix22ButterflyG1_dinXtwdl_vld_dly1 : std_logic;
  SIGNAL Radix22ButterflyG1_dinXtwdl_vld_dly2 : std_logic;
  SIGNAL Radix22ButterflyG1_btf1_re_reg_next : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_btf1_im_reg_next : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_btf2_re_reg_next : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_btf2_im_reg_next : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_add_cast      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_add_cast_1    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sub_cast      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sub_cast_1    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_add_cast_2    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_add_cast_3    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sub_cast_2    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sub_cast_3    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sra_temp      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sra_temp_1    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sra_temp_2    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_sra_temp_3    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL xf_re                            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL xf_vld                           : std_logic;
  SIGNAL dinxTwdlf_vld                    : std_logic;
  SIGNAL btf_vld                          : std_logic;
  SIGNAL dout_3_1_re_tmp                  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dout_3_1_im_tmp                  : std_logic_vector(15 DOWNTO 0);  -- ufix16

BEGIN
  u_MUL3 : ofdm_tx_src_Complex3Multiply
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              din_3_1_re_dly => din_3_1_re_dly,  -- sfix16_En14
              din_3_1_im_dly => din_3_1_im_dly,  -- sfix16_En14
              din_3_vld_dly => din_3_vld_dly,
              twdl_3_1_re => twdl_3_1_re,  -- sfix16_En14
              twdl_3_1_im => twdl_3_1_im,  -- sfix16_En14
              softReset => softReset,
              dinXTwdl_re => dinXTwdl_re,  -- sfix16_En14
              dinXTwdl_im => dinXTwdl_im,  -- sfix16_En14
              dinXTwdl_3_1_vld => dinXTwdl_3_1_vld_1
              );

  u_dataMEM_im_0_3 : ofdm_tx_src_SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 3,
                 DataWidth => 16
                 )
    PORT MAP( clk => clk,
              enb_1_12_0 => enb_1_12_0,
              wr_din => wrData_im,
              wr_addr => wrAddr,
              wr_en => wrEnb,
              rd_addr => rd_3_Addr,
              rd_dout => x_im
              );

  u_dataMEM_re_0_3 : ofdm_tx_src_SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 3,
                 DataWidth => 16
                 )
    PORT MAP( clk => clk,
              enb_1_12_0 => enb_1_12_0,
              wr_din => wrData_re,
              wr_addr => wrAddr,
              wr_en => wrEnb,
              rd_addr => rd_3_Addr,
              rd_dout => x_re
              );

  u_SDFCOMMUTATOR_3 : ofdm_tx_src_SDFCommutator3
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              din_3_vld_dly => din_3_vld_dly,
              xf_re => std_logic_vector(xf_re),  -- sfix16_En14
              xf_im => std_logic_vector(xf_im),  -- sfix16_En14
              xf_vld => xf_vld,
              dinXTwdlf_re => std_logic_vector(dinXTwdlf_re),  -- sfix16_En14
              dinXTwdlf_im => std_logic_vector(dinXTwdlf_im),  -- sfix16_En14
              dinxTwdlf_vld => dinxTwdlf_vld,
              btf1_re => std_logic_vector(btf1_re),  -- sfix16_En14
              btf1_im => std_logic_vector(btf1_im),  -- sfix16_En14
              btf2_re => std_logic_vector(btf2_re),  -- sfix16_En14
              btf2_im => std_logic_vector(btf2_im),  -- sfix16_En14
              btf_vld => btf_vld,
              softReset => softReset,
              wrData_re => wrData_re,  -- sfix16_En14
              wrData_im => wrData_im,  -- sfix16_En14
              wrAddr => wrAddr,  -- ufix3
              wrEnb => wrEnb,
              dout_3_1_re => dout_3_1_re_tmp,  -- sfix16_En14
              dout_3_1_im => dout_3_1_im_tmp,  -- sfix16_En14
              dout_3_1_vld => dout_3_1_vld
              );

  dinXTwdl_re_signed <= signed(dinXTwdl_re);

  dinXTwdl_im_signed <= signed(dinXTwdl_im);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        x_vld <= rd_3_Enb;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  x_im_signed <= signed(x_im);

  x_re_signed <= signed(x_re);

  -- Radix22ButterflyG1
  Radix22ButterflyG1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Radix22ButterflyG1_btf1_re_reg <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_btf1_im_reg <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_btf2_re_reg <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_btf2_im_reg <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_x_re_dly1 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_x_im_dly1 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_x_vld_dly1 <= '0';
      xf_re <= to_signed(16#0000#, 16);
      xf_im <= to_signed(16#0000#, 16);
      xf_vld <= '0';
      Radix22ButterflyG1_dinXtwdl_re_dly1 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_dinXtwdl_im_dly1 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_dinXtwdl_re_dly2 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_dinXtwdl_im_dly2 <= to_signed(16#0000#, 16);
      Radix22ButterflyG1_dinXtwdl_vld_dly1 <= '0';
      Radix22ButterflyG1_dinXtwdl_vld_dly2 <= '0';
      btf_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Radix22ButterflyG1_btf1_re_reg <= Radix22ButterflyG1_btf1_re_reg_next;
        Radix22ButterflyG1_btf1_im_reg <= Radix22ButterflyG1_btf1_im_reg_next;
        Radix22ButterflyG1_btf2_re_reg <= Radix22ButterflyG1_btf2_re_reg_next;
        Radix22ButterflyG1_btf2_im_reg <= Radix22ButterflyG1_btf2_im_reg_next;
        xf_re <= Radix22ButterflyG1_x_re_dly1;
        xf_im <= Radix22ButterflyG1_x_im_dly1;
        xf_vld <= Radix22ButterflyG1_x_vld_dly1;
        btf_vld <= Radix22ButterflyG1_dinXtwdl_vld_dly2;
        Radix22ButterflyG1_dinXtwdl_vld_dly2 <= Radix22ButterflyG1_dinXtwdl_vld_dly1;
        Radix22ButterflyG1_dinXtwdl_re_dly2 <= Radix22ButterflyG1_dinXtwdl_re_dly1;
        Radix22ButterflyG1_dinXtwdl_im_dly2 <= Radix22ButterflyG1_dinXtwdl_im_dly1;
        Radix22ButterflyG1_dinXtwdl_re_dly1 <= dinXTwdl_re_signed;
        Radix22ButterflyG1_dinXtwdl_im_dly1 <= dinXTwdl_im_signed;
        Radix22ButterflyG1_x_re_dly1 <= x_re_signed;
        Radix22ButterflyG1_x_im_dly1 <= x_im_signed;
        Radix22ButterflyG1_x_vld_dly1 <= x_vld;
        Radix22ButterflyG1_dinXtwdl_vld_dly1 <= proc_3_enb AND dinXTwdl_3_1_vld_1;
      END IF;
    END IF;
  END PROCESS Radix22ButterflyG1_process;

  dinxTwdlf_vld <= ( NOT proc_3_enb) AND dinXTwdl_3_1_vld_1;
  Radix22ButterflyG1_add_cast <= resize(Radix22ButterflyG1_x_re_dly1, 17);
  Radix22ButterflyG1_add_cast_1 <= resize(Radix22ButterflyG1_dinXtwdl_re_dly2, 17);
  Radix22ButterflyG1_btf1_re_reg_next <= Radix22ButterflyG1_add_cast + Radix22ButterflyG1_add_cast_1;
  Radix22ButterflyG1_sub_cast <= resize(Radix22ButterflyG1_x_re_dly1, 17);
  Radix22ButterflyG1_sub_cast_1 <= resize(Radix22ButterflyG1_dinXtwdl_re_dly2, 17);
  Radix22ButterflyG1_btf2_re_reg_next <= Radix22ButterflyG1_sub_cast - Radix22ButterflyG1_sub_cast_1;
  Radix22ButterflyG1_add_cast_2 <= resize(Radix22ButterflyG1_x_im_dly1, 17);
  Radix22ButterflyG1_add_cast_3 <= resize(Radix22ButterflyG1_dinXtwdl_im_dly2, 17);
  Radix22ButterflyG1_btf1_im_reg_next <= Radix22ButterflyG1_add_cast_2 + Radix22ButterflyG1_add_cast_3;
  Radix22ButterflyG1_sub_cast_2 <= resize(Radix22ButterflyG1_x_im_dly1, 17);
  Radix22ButterflyG1_sub_cast_3 <= resize(Radix22ButterflyG1_dinXtwdl_im_dly2, 17);
  Radix22ButterflyG1_btf2_im_reg_next <= Radix22ButterflyG1_sub_cast_2 - Radix22ButterflyG1_sub_cast_3;
  dinXTwdlf_re <= dinXTwdl_re_signed;
  dinXTwdlf_im <= dinXTwdl_im_signed;
  Radix22ButterflyG1_sra_temp <= SHIFT_RIGHT(Radix22ButterflyG1_btf1_re_reg, 1);
  btf1_re <= Radix22ButterflyG1_sra_temp(15 DOWNTO 0);
  Radix22ButterflyG1_sra_temp_1 <= SHIFT_RIGHT(Radix22ButterflyG1_btf1_im_reg, 1);
  btf1_im <= Radix22ButterflyG1_sra_temp_1(15 DOWNTO 0);
  Radix22ButterflyG1_sra_temp_2 <= SHIFT_RIGHT(Radix22ButterflyG1_btf2_re_reg, 1);
  btf2_re <= Radix22ButterflyG1_sra_temp_2(15 DOWNTO 0);
  Radix22ButterflyG1_sra_temp_3 <= SHIFT_RIGHT(Radix22ButterflyG1_btf2_im_reg, 1);
  btf2_im <= Radix22ButterflyG1_sra_temp_3(15 DOWNTO 0);

  dout_3_1_re <= dout_3_1_re_tmp;

  dout_3_1_im <= dout_3_1_im_tmp;

  dinXTwdl_3_1_vld <= dinXTwdl_3_1_vld_1;

END rtl;

