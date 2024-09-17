----------------------------------------------------------------------------
-- Entity:        Reg_LOAD_CLR_2bit
-- Written By:    Ghali Ouaritini
-- Date Created:  6/29/2024
-- Description:   VHDL model of a 2-bit register with load and clear
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   DFF_EN_RESET
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg_LOAD_CLR_2bit is
    port (
        D    : in  STD_LOGIC_VECTOR(1 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;

architecture Structural of Reg_LOAD_CLR_2bit is
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            Q <= (others => '0');
        elsif rising_edge(CLK) then
            if LOAD = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end architecture;

