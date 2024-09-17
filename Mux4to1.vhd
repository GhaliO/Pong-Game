----------------------------------------------------------------------------
-- Entity:        Mux4to1
-- Written By:    Ghali Ouaritini
-- Date Created:  6/12/2024
-- Description:   VHDL model of a 4 to 1 multiplexer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   Mux2to1
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1 is
    port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        D2  : in  STD_LOGIC;
        D3  : in  STD_LOGIC;
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC
    );
end entity;

architecture Structural of Mux4to1 is

    component Mux2to1 is
        port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;

    signal n1 : STD_LOGIC;
    signal n2 : STD_LOGIC;

begin

    mux1: Mux2to1
        port map (
            D0  => D0,
            D1  => D1,
            SEL => SEL(0),
            Y   => n1
        );

    mux2: Mux2to1
        port map (
            D0  => D2,
            D1  => D3,
            SEL => SEL(0),
            Y   => n2
        );

    mux3: Mux2to1
        port map (
            D0  => n1,
            D1  => n2,
            SEL => SEL(1),
            Y   => Y
        );

end architecture;

