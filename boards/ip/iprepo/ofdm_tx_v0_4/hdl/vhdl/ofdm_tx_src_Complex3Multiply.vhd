-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_Complex3Multiply.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_Complex3Multiply
-- Source Path: OFDM_Tx_HW/OFDMTx/IFFT/IFFT HDL Optimized/RADIX22FFT_SDF1_3/Complex3Multiply
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_Complex3Multiply IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        din_3_1_re_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_3_1_im_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_3_vld_dly                     :   IN    std_logic;
        twdl_3_1_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_3_1_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        softReset                         :   IN    std_logic;
        dinXTwdl_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dinXTwdl_im                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dinXTwdl_3_1_vld                  :   OUT   std_logic
        );
END ofdm_tx_src_Complex3Multiply;


ARCHITECTURE rtl OF ofdm_tx_src_Complex3Multiply IS

  -- Signals
  SIGNAL din_3_1_re_dly_signed            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL din_re_reg                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL din_3_1_im_dly_signed            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL din_im_reg                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL adder_add_cast                   : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL adder_add_cast_1                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL din_sum                          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL twdl_3_1_re_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_re_reg                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_3_1_im_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_im_reg                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL adder_add_cast_2                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL adder_add_cast_3                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL twdl_sum                         : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex3Multiply_din1_re_pipe1   : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL Complex3Multiply_din1_im_pipe1   : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL Complex3Multiply_din1_sum_pipe1  : signed(16 DOWNTO 0) := to_signed(16#00000#, 17);  -- sfix17
  SIGNAL Complex3Multiply_prodOfRe_pipe1  : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL Complex3Multiply_ProdOfIm_pipe1  : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL Complex3Multiply_prodOfSum_pipe1 : signed(33 DOWNTO 0) := to_signed(0, 34);  -- sfix34
  SIGNAL Complex3Multiply_twiddle_re_pipe1 : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL Complex3Multiply_twiddle_im_pipe1 : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL Complex3Multiply_twiddle_sum_pipe1 : signed(16 DOWNTO 0) := to_signed(16#00000#, 17);  -- sfix17
  SIGNAL prodOfRe                         : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32_En28
  SIGNAL prodOfIm                         : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32_En28
  SIGNAL prodOfSum                        : signed(33 DOWNTO 0) := to_signed(0, 34);  -- sfix34_En28
  SIGNAL din_vld_dly1                     : std_logic;
  SIGNAL din_vld_dly2                     : std_logic;
  SIGNAL din_vld_dly3                     : std_logic;
  SIGNAL prod_vld                         : std_logic;
  SIGNAL Complex3Add_tmpResult_reg        : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Complex3Add_multRes_re_reg1      : signed(32 DOWNTO 0);  -- sfix33
  SIGNAL Complex3Add_multRes_re_reg2      : signed(32 DOWNTO 0);  -- sfix33
  SIGNAL Complex3Add_multRes_im_reg       : signed(34 DOWNTO 0);  -- sfix35
  SIGNAL Complex3Add_prod_vld_reg1        : std_logic;
  SIGNAL Complex3Add_prodOfSum_reg        : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Complex3Add_tmpResult_reg_next   : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Complex3Add_multRes_re_reg1_next : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_multRes_re_reg2_next : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_multRes_im_reg_next  : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Complex3Add_sub_cast             : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_sub_cast_1           : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_sub_cast_2           : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Complex3Add_sub_cast_3           : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Complex3Add_add_cast             : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_add_cast_1           : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Complex3Add_add_temp             : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL multResFP_re                     : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL multResFP_im                     : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL dinXTwdl_re_tmp                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinXTwdl_im_tmp                  : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  din_3_1_re_dly_signed <= signed(din_3_1_re_dly);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_re_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF softReset = '1' THEN
          din_re_reg <= to_signed(16#0000#, 16);
        ELSE 
          din_re_reg <= din_3_1_re_dly_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  din_3_1_im_dly_signed <= signed(din_3_1_im_dly);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_im_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF softReset = '1' THEN
          din_im_reg <= to_signed(16#0000#, 16);
        ELSE 
          din_im_reg <= din_3_1_im_dly_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  adder_add_cast <= resize(din_re_reg, 17);
  adder_add_cast_1 <= resize(din_im_reg, 17);
  din_sum <= adder_add_cast + adder_add_cast_1;

  twdl_3_1_re_signed <= signed(twdl_3_1_re);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_re_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF softReset = '1' THEN
          twdl_re_reg <= to_signed(16#0000#, 16);
        ELSE 
          twdl_re_reg <= twdl_3_1_re_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


  twdl_3_1_im_signed <= signed(twdl_3_1_im);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_im_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        IF softReset = '1' THEN
          twdl_im_reg <= to_signed(16#0000#, 16);
        ELSE 
          twdl_im_reg <= twdl_3_1_im_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;


  adder_add_cast_2 <= resize(twdl_re_reg, 17);
  adder_add_cast_3 <= resize(twdl_im_reg, 17);
  twdl_sum <= adder_add_cast_2 + adder_add_cast_3;

  -- Complex3Multiply
  Complex3Multiply_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        prodOfRe <= Complex3Multiply_prodOfRe_pipe1;
        prodOfIm <= Complex3Multiply_ProdOfIm_pipe1;
        prodOfSum <= Complex3Multiply_prodOfSum_pipe1;
        Complex3Multiply_prodOfRe_pipe1 <= Complex3Multiply_din1_re_pipe1 * Complex3Multiply_twiddle_re_pipe1;
        Complex3Multiply_ProdOfIm_pipe1 <= Complex3Multiply_din1_im_pipe1 * Complex3Multiply_twiddle_im_pipe1;
        Complex3Multiply_prodOfSum_pipe1 <= Complex3Multiply_din1_sum_pipe1 * Complex3Multiply_twiddle_sum_pipe1;
        Complex3Multiply_twiddle_re_pipe1 <= twdl_re_reg;
        Complex3Multiply_twiddle_im_pipe1 <= twdl_im_reg;
        Complex3Multiply_twiddle_sum_pipe1 <= twdl_sum;
        Complex3Multiply_din1_re_pipe1 <= din_re_reg;
        Complex3Multiply_din1_im_pipe1 <= din_im_reg;
        Complex3Multiply_din1_sum_pipe1 <= din_sum;
      END IF;
    END IF;
  END PROCESS Complex3Multiply_process;


  intdelay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        din_vld_dly1 <= din_3_vld_dly;
      END IF;
    END IF;
  END PROCESS intdelay_4_process;


  intdelay_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        din_vld_dly2 <= din_vld_dly1;
      END IF;
    END IF;
  END PROCESS intdelay_5_process;


  intdelay_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        din_vld_dly3 <= din_vld_dly2;
      END IF;
    END IF;
  END PROCESS intdelay_6_process;


  intdelay_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      prod_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        prod_vld <= din_vld_dly3;
      END IF;
    END IF;
  END PROCESS intdelay_7_process;


  -- Complex3Add
  Complex3Add_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex3Add_prodOfSum_reg <= to_signed(0, 34);
      Complex3Add_tmpResult_reg <= to_signed(0, 34);
      Complex3Add_multRes_re_reg1 <= to_signed(0, 33);
      Complex3Add_multRes_re_reg2 <= to_signed(0, 33);
      Complex3Add_multRes_im_reg <= to_signed(0, 35);
      Complex3Add_prod_vld_reg1 <= '0';
      dinXTwdl_3_1_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_12_0 = '1' THEN
        Complex3Add_tmpResult_reg <= Complex3Add_tmpResult_reg_next;
        Complex3Add_multRes_re_reg1 <= Complex3Add_multRes_re_reg1_next;
        Complex3Add_multRes_re_reg2 <= Complex3Add_multRes_re_reg2_next;
        Complex3Add_multRes_im_reg <= Complex3Add_multRes_im_reg_next;
        Complex3Add_prodOfSum_reg <= prodOfSum;
        dinXTwdl_3_1_vld <= Complex3Add_prod_vld_reg1;
        Complex3Add_prod_vld_reg1 <= prod_vld;
      END IF;
    END IF;
  END PROCESS Complex3Add_process;

  Complex3Add_multRes_re_reg2_next <= Complex3Add_multRes_re_reg1;
  Complex3Add_sub_cast <= resize(prodOfRe, 33);
  Complex3Add_sub_cast_1 <= resize(prodOfIm, 33);
  Complex3Add_multRes_re_reg1_next <= Complex3Add_sub_cast - Complex3Add_sub_cast_1;
  Complex3Add_sub_cast_2 <= resize(Complex3Add_prodOfSum_reg, 35);
  Complex3Add_sub_cast_3 <= resize(Complex3Add_tmpResult_reg, 35);
  Complex3Add_multRes_im_reg_next <= Complex3Add_sub_cast_2 - Complex3Add_sub_cast_3;
  Complex3Add_add_cast <= resize(prodOfRe, 33);
  Complex3Add_add_cast_1 <= resize(prodOfIm, 33);
  Complex3Add_add_temp <= Complex3Add_add_cast + Complex3Add_add_cast_1;
  Complex3Add_tmpResult_reg_next <= resize(Complex3Add_add_temp, 34);
  multResFP_re <= Complex3Add_multRes_re_reg2;
  multResFP_im <= Complex3Add_multRes_im_reg;

  dinXTwdl_re_tmp <= multResFP_re(29 DOWNTO 14);

  dinXTwdl_re <= std_logic_vector(dinXTwdl_re_tmp);

  dinXTwdl_im_tmp <= multResFP_im(29 DOWNTO 14);

  dinXTwdl_im <= std_logic_vector(dinXTwdl_im_tmp);

END rtl;

