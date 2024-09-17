----------------------------------------------------------------------------
-- Entity:        Synch
-- Written By:    Ghali Ouaritini
-- Date Created:  7/11/2024
-- Description:   VHDL model of a synchronizer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Synch is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;

architecture Structural of Synch is
    signal Q1 : STD_LOGIC;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q1 <= D;
            Q  <= Q1;
        end if;
    end process;
end architecture;
