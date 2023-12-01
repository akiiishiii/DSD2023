-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Nov 29 14:56:30 2023
-- Host        : LAPTOP-F6HMT211 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top sine_rom -prefix
--               sine_rom_ sine_rom_sim_netlist.vhdl
-- Design      : sine_rom
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sine_rom_rom is
  port (
    qspo : out STD_LOGIC_VECTOR ( 7 downto 0 );
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC
  );
end sine_rom_rom;

architecture STRUCTURE of sine_rom_rom is
  signal a_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \qspo_int[0]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[0]_i_5_n_0\ : STD_LOGIC;
  signal \qspo_int[0]_i_6_n_0\ : STD_LOGIC;
  signal \qspo_int[0]_i_7_n_0\ : STD_LOGIC;
  signal \qspo_int[1]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int[1]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int[1]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int[1]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[2]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[2]_i_5_n_0\ : STD_LOGIC;
  signal \qspo_int[2]_i_6_n_0\ : STD_LOGIC;
  signal \qspo_int[2]_i_7_n_0\ : STD_LOGIC;
  signal \qspo_int[3]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[3]_i_5_n_0\ : STD_LOGIC;
  signal \qspo_int[3]_i_6_n_0\ : STD_LOGIC;
  signal \qspo_int[3]_i_7_n_0\ : STD_LOGIC;
  signal \qspo_int[4]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[4]_i_5_n_0\ : STD_LOGIC;
  signal \qspo_int[4]_i_6_n_0\ : STD_LOGIC;
  signal \qspo_int[4]_i_7_n_0\ : STD_LOGIC;
  signal \qspo_int[5]_i_4_n_0\ : STD_LOGIC;
  signal \qspo_int[5]_i_5_n_0\ : STD_LOGIC;
  signal \qspo_int[5]_i_6_n_0\ : STD_LOGIC;
  signal \qspo_int[5]_i_7_n_0\ : STD_LOGIC;
  signal \qspo_int[6]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int[6]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int[6]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int[7]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int[7]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[2]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[4]_i_3_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[5]_i_2_n_0\ : STD_LOGIC;
  signal \qspo_int_reg[5]_i_3_n_0\ : STD_LOGIC;
begin
\a_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(0),
      Q => a_reg(0),
      R => '0'
    );
\a_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(1),
      Q => a_reg(1),
      R => '0'
    );
\a_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(2),
      Q => a_reg(2),
      R => '0'
    );
\a_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(3),
      Q => a_reg(3),
      R => '0'
    );
\a_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(4),
      Q => a_reg(4),
      R => '0'
    );
\a_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(5),
      Q => a_reg(5),
      R => '0'
    );
\a_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(6),
      Q => a_reg(6),
      R => '0'
    );
\a_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(7),
      Q => a_reg(7),
      R => '0'
    );
\qspo_int[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F75F08A0A82157DF"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(1),
      I4 => a_reg(7),
      I5 => a_reg(0),
      O => \qspo_int[0]_i_4_n_0\
    );
\qspo_int[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B20C544A4DF3ABB4"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(1),
      I4 => a_reg(0),
      I5 => a_reg(7),
      O => \qspo_int[0]_i_5_n_0\
    );
\qspo_int[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"320ACDF542D7BD28"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(0),
      I3 => a_reg(2),
      I4 => a_reg(7),
      I5 => a_reg(1),
      O => \qspo_int[0]_i_6_n_0\
    );
\qspo_int[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0515EAEF1041BE"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(7),
      I4 => a_reg(0),
      I5 => a_reg(1),
      O => \qspo_int[0]_i_7_n_0\
    );
\qspo_int[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \qspo_int[1]_i_2_n_0\,
      I1 => a_reg(5),
      I2 => \qspo_int[1]_i_3_n_0\,
      I3 => a_reg(6),
      I4 => \qspo_int[1]_i_4_n_0\,
      O => \qspo_int[1]_i_1_n_0\
    );
\qspo_int[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B803DD1301BC64A8"
    )
        port map (
      I0 => a_reg(6),
      I1 => a_reg(4),
      I2 => a_reg(2),
      I3 => a_reg(1),
      I4 => a_reg(3),
      I5 => a_reg(0),
      O => \qspo_int[1]_i_2_n_0\
    );
\qspo_int[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACC662288EE4445"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(7),
      I3 => a_reg(1),
      I4 => a_reg(0),
      I5 => a_reg(2),
      O => \qspo_int[1]_i_3_n_0\
    );
\qspo_int[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C20035FF"
    )
        port map (
      I0 => a_reg(3),
      I1 => a_reg(0),
      I2 => a_reg(2),
      I3 => a_reg(4),
      I4 => a_reg(1),
      O => \qspo_int[1]_i_4_n_0\
    );
\qspo_int[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"87B8B8707087878F"
    )
        port map (
      I0 => a_reg(3),
      I1 => a_reg(4),
      I2 => a_reg(2),
      I3 => a_reg(1),
      I4 => a_reg(7),
      I5 => a_reg(0),
      O => \qspo_int[2]_i_4_n_0\
    );
\qspo_int[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"14EE22084EE055DF"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(2),
      I2 => a_reg(0),
      I3 => a_reg(1),
      I4 => a_reg(3),
      I5 => a_reg(7),
      O => \qspo_int[2]_i_5_n_0\
    );
\qspo_int[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0742B7A7485DA2C2"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(2),
      I2 => a_reg(3),
      I3 => a_reg(0),
      I4 => a_reg(7),
      I5 => a_reg(1),
      O => \qspo_int[2]_i_6_n_0\
    );
\qspo_int[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1B0EE11B0EE11B1E"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(7),
      I4 => a_reg(1),
      I5 => a_reg(0),
      O => \qspo_int[2]_i_7_n_0\
    );
\qspo_int[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"344B933CB34CCBB3"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(7),
      I4 => a_reg(1),
      I5 => a_reg(0),
      O => \qspo_int[3]_i_4_n_0\
    );
\qspo_int[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"628802AAA957FF55"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(1),
      I2 => a_reg(0),
      I3 => a_reg(2),
      I4 => a_reg(3),
      I5 => a_reg(7),
      O => \qspo_int[3]_i_5_n_0\
    );
\qspo_int[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"41505252ADADADED"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(0),
      I4 => a_reg(1),
      I5 => a_reg(7),
      O => \qspo_int[3]_i_6_n_0\
    );
\qspo_int[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C93C2CD2CD3236D3"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(7),
      I4 => a_reg(1),
      I5 => a_reg(0),
      O => \qspo_int[3]_i_7_n_0\
    );
\qspo_int[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6D6949599296A625"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(0),
      I4 => a_reg(1),
      I5 => a_reg(7),
      O => \qspo_int[4]_i_4_n_0\
    );
\qspo_int[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"76AA0000A855FFFF"
    )
        port map (
      I0 => a_reg(3),
      I1 => a_reg(1),
      I2 => a_reg(0),
      I3 => a_reg(2),
      I4 => a_reg(4),
      I5 => a_reg(7),
      O => \qspo_int[4]_i_5_n_0\
    );
\qspo_int[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"15141414EBEBEBAB"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(0),
      I4 => a_reg(1),
      I5 => a_reg(7),
      O => \qspo_int[4]_i_6_n_0\
    );
\qspo_int[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9B9A266464645999"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(1),
      I3 => a_reg(0),
      I4 => a_reg(2),
      I5 => a_reg(7),
      O => \qspo_int[4]_i_7_n_0\
    );
\qspo_int[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B9BD9D9D46426263"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(0),
      I4 => a_reg(1),
      I5 => a_reg(7),
      O => \qspo_int[5]_i_4_n_0\
    );
\qspo_int[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A00000001FFFFFFF"
    )
        port map (
      I0 => a_reg(1),
      I1 => a_reg(0),
      I2 => a_reg(2),
      I3 => a_reg(3),
      I4 => a_reg(4),
      I5 => a_reg(7),
      O => \qspo_int[5]_i_5_n_0\
    );
\qspo_int[5]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00010101FEFEFEFE"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(1),
      I4 => a_reg(0),
      I5 => a_reg(7),
      O => \qspo_int[5]_i_6_n_0\
    );
\qspo_int[5]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABBBDD55544422AA"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(2),
      I2 => a_reg(0),
      I3 => a_reg(1),
      I4 => a_reg(3),
      I5 => a_reg(7),
      O => \qspo_int[5]_i_7_n_0\
    );
\qspo_int[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8B3F8B0C"
    )
        port map (
      I0 => \qspo_int[6]_i_2_n_0\,
      I1 => a_reg(5),
      I2 => a_reg(7),
      I3 => a_reg(6),
      I4 => \qspo_int[6]_i_3_n_0\,
      O => \qspo_int[6]_i_1_n_0\
    );
\qspo_int[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEEEAAAA01115555"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(2),
      I2 => a_reg(1),
      I3 => a_reg(0),
      I4 => a_reg(3),
      I5 => a_reg(7),
      O => \qspo_int[6]_i_2_n_0\
    );
\qspo_int[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"57577777A8A88889"
    )
        port map (
      I0 => a_reg(4),
      I1 => a_reg(3),
      I2 => a_reg(2),
      I3 => a_reg(0),
      I4 => a_reg(1),
      I5 => a_reg(7),
      O => \qspo_int[6]_i_3_n_0\
    );
\qspo_int[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FF01FF00FF00FE"
    )
        port map (
      I0 => a_reg(5),
      I1 => a_reg(6),
      I2 => a_reg(4),
      I3 => a_reg(7),
      I4 => a_reg(3),
      I5 => \qspo_int[7]_i_2_n_0\,
      O => \qspo_int[7]_i_1_n_0\
    );
\qspo_int[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
        port map (
      I0 => a_reg(2),
      I1 => a_reg(1),
      I2 => a_reg(0),
      I3 => a_reg(7),
      O => \qspo_int[7]_i_2_n_0\
    );
\qspo_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int_reg[0]_i_1_n_0\,
      Q => qspo(0),
      R => '0'
    );
\qspo_int_reg[0]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \qspo_int_reg[0]_i_2_n_0\,
      I1 => \qspo_int_reg[0]_i_3_n_0\,
      O => \qspo_int_reg[0]_i_1_n_0\,
      S => a_reg(5)
    );
\qspo_int_reg[0]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[0]_i_4_n_0\,
      I1 => \qspo_int[0]_i_5_n_0\,
      O => \qspo_int_reg[0]_i_2_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[0]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[0]_i_6_n_0\,
      I1 => \qspo_int[0]_i_7_n_0\,
      O => \qspo_int_reg[0]_i_3_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int[1]_i_1_n_0\,
      Q => qspo(1),
      R => '0'
    );
\qspo_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int_reg[2]_i_1_n_0\,
      Q => qspo(2),
      R => '0'
    );
\qspo_int_reg[2]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \qspo_int_reg[2]_i_2_n_0\,
      I1 => \qspo_int_reg[2]_i_3_n_0\,
      O => \qspo_int_reg[2]_i_1_n_0\,
      S => a_reg(5)
    );
\qspo_int_reg[2]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[2]_i_4_n_0\,
      I1 => \qspo_int[2]_i_5_n_0\,
      O => \qspo_int_reg[2]_i_2_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[2]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[2]_i_6_n_0\,
      I1 => \qspo_int[2]_i_7_n_0\,
      O => \qspo_int_reg[2]_i_3_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int_reg[3]_i_1_n_0\,
      Q => qspo(3),
      R => '0'
    );
\qspo_int_reg[3]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \qspo_int_reg[3]_i_2_n_0\,
      I1 => \qspo_int_reg[3]_i_3_n_0\,
      O => \qspo_int_reg[3]_i_1_n_0\,
      S => a_reg(5)
    );
\qspo_int_reg[3]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[3]_i_4_n_0\,
      I1 => \qspo_int[3]_i_5_n_0\,
      O => \qspo_int_reg[3]_i_2_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[3]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[3]_i_6_n_0\,
      I1 => \qspo_int[3]_i_7_n_0\,
      O => \qspo_int_reg[3]_i_3_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int_reg[4]_i_1_n_0\,
      Q => qspo(4),
      R => '0'
    );
\qspo_int_reg[4]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \qspo_int_reg[4]_i_2_n_0\,
      I1 => \qspo_int_reg[4]_i_3_n_0\,
      O => \qspo_int_reg[4]_i_1_n_0\,
      S => a_reg(5)
    );
\qspo_int_reg[4]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[4]_i_4_n_0\,
      I1 => \qspo_int[4]_i_5_n_0\,
      O => \qspo_int_reg[4]_i_2_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[4]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[4]_i_6_n_0\,
      I1 => \qspo_int[4]_i_7_n_0\,
      O => \qspo_int_reg[4]_i_3_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int_reg[5]_i_1_n_0\,
      Q => qspo(5),
      R => '0'
    );
\qspo_int_reg[5]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \qspo_int_reg[5]_i_2_n_0\,
      I1 => \qspo_int_reg[5]_i_3_n_0\,
      O => \qspo_int_reg[5]_i_1_n_0\,
      S => a_reg(5)
    );
\qspo_int_reg[5]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[5]_i_4_n_0\,
      I1 => \qspo_int[5]_i_5_n_0\,
      O => \qspo_int_reg[5]_i_2_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[5]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \qspo_int[5]_i_6_n_0\,
      I1 => \qspo_int[5]_i_7_n_0\,
      O => \qspo_int_reg[5]_i_3_n_0\,
      S => a_reg(6)
    );
\qspo_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int[6]_i_1_n_0\,
      Q => qspo(6),
      R => '0'
    );
\qspo_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \qspo_int[7]_i_1_n_0\,
      Q => qspo(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sine_rom_dist_mem_gen_v8_0_12_synth is
  port (
    qspo : out STD_LOGIC_VECTOR ( 7 downto 0 );
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC
  );
end sine_rom_dist_mem_gen_v8_0_12_synth;

architecture STRUCTURE of sine_rom_dist_mem_gen_v8_0_12_synth is
begin
\gen_rom.rom_inst\: entity work.sine_rom_rom
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      qspo(7 downto 0) => qspo(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sine_rom_dist_mem_gen_v8_0_12 is
  port (
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    d : in STD_LOGIC_VECTOR ( 7 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 7 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 7 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of sine_rom_dist_mem_gen_v8_0_12 : entity is 8;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of sine_rom_dist_mem_gen_v8_0_12 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of sine_rom_dist_mem_gen_v8_0_12 : entity is 256;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of sine_rom_dist_mem_gen_v8_0_12 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of sine_rom_dist_mem_gen_v8_0_12 : entity is "artix7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of sine_rom_dist_mem_gen_v8_0_12 : entity is "sine_rom.mif";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of sine_rom_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of sine_rom_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of sine_rom_dist_mem_gen_v8_0_12 : entity is 8;
end sine_rom_dist_mem_gen_v8_0_12;

architecture STRUCTURE of sine_rom_dist_mem_gen_v8_0_12 is
  signal \<const0>\ : STD_LOGIC;
begin
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  spo(7) <= \<const0>\;
  spo(6) <= \<const0>\;
  spo(5) <= \<const0>\;
  spo(4) <= \<const0>\;
  spo(3) <= \<const0>\;
  spo(2) <= \<const0>\;
  spo(1) <= \<const0>\;
  spo(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.sine_rom_dist_mem_gen_v8_0_12_synth
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      qspo(7 downto 0) => qspo(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sine_rom is
  port (
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    qspo : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of sine_rom : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of sine_rom : entity is "sine_rom,dist_mem_gen_v8_0_12,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of sine_rom : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of sine_rom : entity is "dist_mem_gen_v8_0_12,Vivado 2018.3";
end sine_rom;

architecture STRUCTURE of sine_rom is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_spo_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 0;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of U0 : label is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 8;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 256;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_clk : integer;
  attribute c_has_clk of U0 : label is 1;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 1;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 0;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "sine_rom.mif";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 1;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 1;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 8;
begin
U0: entity work.sine_rom_dist_mem_gen_v8_0_12
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      d(7 downto 0) => B"00000000",
      dpo(7 downto 0) => NLW_U0_dpo_UNCONNECTED(7 downto 0),
      dpra(7 downto 0) => B"00000000",
      i_ce => '1',
      qdpo(7 downto 0) => NLW_U0_qdpo_UNCONNECTED(7 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(7 downto 0) => qspo(7 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(7 downto 0) => NLW_U0_spo_UNCONNECTED(7 downto 0),
      we => '0'
    );
end STRUCTURE;
