----------------------------------------------------------------------------
-- Entity:        HexTo7SegDecoder
-- Written By:    Ghali Ouaritini
-- Date Created:  6/12/2024
-- Description:   VHDL model of a hex digit to 7-segment display decoder
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HexTo7SegDecoder is
    port (
        HEX     : in  STD_LOGIC_VECTOR(3 downto 0);
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6)
    );
end entity;

architecture Structural of HexTo7SegDecoder is
    alias A : STD_LOGIC is HEX(3);
    alias B : STD_LOGIC is HEX(2);
    alias C : STD_LOGIC is HEX(1);
    alias D : STD_LOGIC is HEX(0);

    alias Y1 : STD_LOGIC is SEGMENT(0);
    alias Y2 : STD_LOGIC is SEGMENT(1);
    alias Y3 : STD_LOGIC is SEGMENT(2);
    alias Y4 : STD_LOGIC is SEGMENT(3);
    alias Y5 : STD_LOGIC is SEGMENT(4);
    alias Y6 : STD_LOGIC is SEGMENT(5);
    alias Y7 : STD_LOGIC is SEGMENT(6);
	
	signal m0  : STD_LOGIC;
	signal m1  : STD_LOGIC;
	signal m2  : STD_LOGIC;
	signal m3  : STD_LOGIC;
	signal m4  : STD_LOGIC;
	signal m5  : STD_LOGIC;
	signal m6  : STD_LOGIC;
	signal m7  : STD_LOGIC;
	signal m9  : STD_LOGIC;
	signal m10 : STD_LOGIC;
	signal m11 : STD_LOGIC;
	signal m12 : STD_LOGIC;
	signal m13 : STD_LOGIC;
	signal m14 : STD_LOGIC;
	signal m15 : STD_LOGIC;

begin

    m0 <= not A and not B and not C and not D; 
    m1 <= not A and not B and not C and D; 
    m2 <= not A and not B and C and not D; 
    m3 <= not A and not B and C and D; 
    m4 <= not A and B and not C and not D; 
    m5 <= not A and B and not C and D; 
    m6 <= not A and B and C and not D; 
    m7 <= not A and B and C and D;
    m9 <= A and not B and not C and D; 
    m10 <= A and not B and C and not D; 
    m11 <= A and not B and C and D; 
    m12 <= A and B and not C and not D; 
    m13 <= A and B and not C and D; 
    m14 <= A and B and C and not D; 
    m15 <= A and B and C and D; 
    
    Y1 <= m1 or m4 or m11 or m13;
    Y2 <= m5 or m6 or m11 or m12 or m14 or m15;
    Y3 <= m2 or m12 or m14 or m15;
    Y4 <= m1 or m4 or m7 or m9 or m10 or m15;
    Y5 <= m1 or m3 or m4 or m5 or m7 or m9;
    Y6 <= m1 or m2 or m3 or m7 or m13;
    Y7 <= m0 or m1 or m7 or m12;
    
end architecture;