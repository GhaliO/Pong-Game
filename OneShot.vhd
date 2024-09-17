----------------------------------------------------------------------------
-- Entity:        OneShot
-- Written By:    Ghali Ouaritini
-- Date Created:  7/11/2024
-- Description:   VHDL model of a one-shot (rising edge detector)
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;

architecture Behavioral of OneShot is
    signal current_state, next_state : STD_LOGIC := '0';
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    process (current_state, D)
    begin
        if current_state = '0' and D = '1' then
            next_state <= '1';
        else
            next_state <= '0';
        end if;
    end process;

    Q <= '1' when (current_state = '0' and D = '1') else '0';
end architecture;


