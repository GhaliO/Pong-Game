----------------------------------------------------------------------------
-- Entity:        Mux4to1_4bit
-- Written By:    Ghali Ouaritini
-- Date Created:  6/12/2024
-- Description:   VHDL model of a 4-bit 4 to 1 multiplexer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   Mux4to1
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1_4bit is
    port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        D2  : in  STD_LOGIC_VECTOR(3 downto 0);
        D3  : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Structural of Mux4to1_4bit is

    component Mux4to1 is
        port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            D2  : in  STD_LOGIC;
            D3  : in  STD_LOGIC;
            SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            Y   : out STD_LOGIC
        );
    end component;

begin
    mux1: Mux4to1
        port map (
            D0  => D0(0),
            D1  => D1(0),
            D2  => D2(0),
            D3  => D3(0),
            SEL => SEL,
            Y   => Y(0)
        );

    mux2: Mux4to1
        port map (
            D0  => D0(1),
            D1  => D1(1),
            D2  => D2(1),
            D3  => D3(1),
            SEL => SEL,
            Y   => Y(1)
        );

    mux3: Mux4to1
        port map (
            D0  => D0(2),
            D1  => D1(2),
            D2  => D2(2),
            D3  => D3(2),
            SEL => SEL,
            Y   => Y(2)
        );

    mux4: Mux4to1
        port map (
            D0  => D0(3),
            D1  => D1(3),
            D2  => D2(3),
            D3  => D3(3),
            SEL => SEL,
            Y   => Y(3)
        );

end architecture;
