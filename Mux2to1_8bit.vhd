----------------------------------------------------------------------------
-- Entity:        Mux2to1_8bit
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of an 8-bit 2 to 1 multiplexer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Mux2to1_8bit is
    port (
        D0  : in  STD_LOGIC_VECTOR (7 downto 0);
        D1  : in  STD_LOGIC_VECTOR (7 downto 0);
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Dataflow of Mux2to1_8bit is

begin

    with SEL select
        Y <= D0 when '0',
             D1 when '1',
             "XXXXXXXX" when others;

end architecture;
