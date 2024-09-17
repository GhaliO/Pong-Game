----------------------------------------------------------------------------
-- Entity:        Adder_8bit
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of an 8-bit adder
--    and clear.
--
-- Revision History (date, initials, description):
--   (none)

-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.all;
use     IEEE.NUMERIC_STD.all;

----------------------------------------------------------------------------
entity Adder_8bit is
    port (
        A   : in  STD_LOGIC_VECTOR (7 downto 0);
        B   : in  STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of Adder_8bit is

begin

    SUM <= std_logic_vector(unsigned(A) + unsigned(B));
    
end architecture;

