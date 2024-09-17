----------------------------------------------------------------------------
-- Entity:        Mux2to1
-- Written By:    Ghali Ouaritini
-- Date Created:  6/12/2024
-- Description:   VHDL model of a 2 to 1 multiplexer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1 is
    port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC
    );
end entity;

architecture Behavioral of Mux2to1 is
begin
    process(D0, D1, SEL)
    begin
        if SEL = '0' then
            Y <= D0;
        else
            Y <= D1;
        end if;
    end process;
end architecture;
