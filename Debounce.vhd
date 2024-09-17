----------------------------------------------------------------------------
-- Entity:        Debounce
-- Written By:    Ghali Ouaritini
-- Date Created:  7/11/2024
-- Description:   VHDL model of a debouncer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;

architecture Structural of Debounce is
    signal Q1, Q2 : STD_LOGIC;
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if PULSE = '1' then
                Q1 <= D;
            end if;
            Q2 <= Q1;
        end if;
    end process;

    Q <= Q1 and not Q2;
end architecture;


