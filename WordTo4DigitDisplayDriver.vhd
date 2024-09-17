----------------------------------------------------------------------------
-- Entity:        WordTo4DigitDisplayDriver
-- Written By:    Ghali Ouaritini
-- Date Created:  6/29/2024
-- Description:   VHDL model of a word to 4-digit 7-segment display driver
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WordTo4DigitDisplayDriver is
    port (
        WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
        PULSE   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Structural of WordTo4DigitDisplayDriver is
  component HexTo7SegDecoder is
      port (
          HEX     : in  STD_LOGIC_VECTOR(3 downto 0);
          SEGMENT : out STD_LOGIC_VECTOR(0 to 6)
      );
  end component;
  
  component Decoder2to4_ALO is
      port (
          A : in  STD_LOGIC_VECTOR(1 downto 0);
          Y : out STD_LOGIC_VECTOR(3 downto 0)
      );
  end component;
  
    component Counter_2bit is
        port (
            EN   : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            CLR  : in  STD_LOGIC;
            ROLL : out STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    component Mux4to1_4bit is
        port (
            D0  : in  STD_LOGIC_VECTOR(3 downto 0);
            D1  : in  STD_LOGIC_VECTOR(3 downto 0);
            D2  : in  STD_LOGIC_VECTOR(3 downto 0);
            D3  : in  STD_LOGIC_VECTOR(3 downto 0);
            SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            Y   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal curDigit : STD_LOGIC_VECTOR(3 downto 0); 
    signal digitSelect : STD_LOGIC_VECTOR(1 downto 0); 
    signal rollHolder : STD_LOGIC; 


begin

    hex7Decoder: HexTo7SegDecoder
        port map (
            HEX => curDigit,
            SEGMENT => SEGMENT(0 to 6)
        );
        
    decoder2to4ALO: Decoder2to4_ALO
        port map (
            A => digitSelect,
            Y => ANODE
        );
        
    counter2Bit: Counter_2bit
        port map (
            EN  => PULSE,
            CLK  => CLK,
            CLR => '0',
            ROLL  => rollHolder,
            Q => digitSelect
        );
        
    mux4to1: Mux4to1_4bit
        port map (
            D0 => WORD(3 downto 0),
            D1 => WORD(7 downto 4),
            D2 => WORD(11 downto 8),
            D3 => WORD(15 downto 12),
            SEL => digitSelect,
            Y   => curDigit 
        );
   
end architecture;