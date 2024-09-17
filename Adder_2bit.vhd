----------------------------------------------------------------------------
-- Entity:        Adder_2bit
-- Written By:    Ghali Ouaritini
-- Date Created:  6/29/2024
-- Description:   VHDL model of a 2-bit ripple-carry adder
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder_2bit is
    port (
        A  : in  STD_LOGIC_VECTOR (1 downto 0);
        B  : in  STD_LOGIC_VECTOR (1 downto 0);
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC_VECTOR (1 downto 0)
    );
end entity;

architecture Structural of Adder_2bit is

    component FullAdder is
        port (
            A  : in  STD_LOGIC;
            B  : in  STD_LOGIC;
            Ci : in  STD_LOGIC;
            Co : out STD_LOGIC;
            S  : out STD_LOGIC
        );
        end component;
    
    signal C0 : STD_LOGIC;    
    signal C1 : STD_LOGIC; 
    signal C2 : STD_LOGIC; 

begin

    C0 <= Ci; 

    FullAdder1: FullAdder
    port map (
        A => A(1),
        B => B(1),
        Ci => C1,
        Co => C2,
        S => S(1)
    );
    
    FullAdder0: FullAdder
    port map (
        A => A(0),
        B => B(0),
        Ci => C0,
        Co => C1,
        S => S(0)
    );
    
    Co <= C2; 


end architecture;