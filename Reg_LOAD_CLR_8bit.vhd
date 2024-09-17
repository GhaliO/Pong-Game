----------------------------------------------------------------------------
-- Entity:        Reg_LOAD_CLR_8bit
-- Written By:    E. George Walters
-- Date Created:  17 Sep 13
-- Last Modified: 27 Sep 14
-- Description:   VHDL model of an n-bit register with synchronous load and clear.
--
-- Revision History (date, initials, description):
-- 	27 Sep 14, egw100, Changed name to Reg
--
-- Dependencies:
-- 	(none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Reg_LOAD_CLR_8bit is
    port (
        D    : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of Reg_LOAD_CLR_8bit is

begin

    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (CLR = '1') then
                Q <= (OTHERS => '0');
            elsif (LOAD = '1') then
                Q <= D;
            end if;
        end if;
    end process;

end architecture;

