----------------------------------------------------------------------------
-- Entity:        Counter_2bit
-- Written By:    Ghali Ouaritini
-- Date Created:  6/29/2024
-- Description:   VHDL model of a 2-bit counter with enable and clear
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   Adder_4bit
--   Counter_4bit
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_2bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR (1 downto 0)
    );
end entity;

architecture Structural of Counter_2bit is

    component Adder_2bit is
        port (
            A  : in  STD_LOGIC_VECTOR (1 downto 0);
            B  : in  STD_LOGIC_VECTOR (1 downto 0);
            Ci : in  STD_LOGIC;
            Co : out STD_LOGIC;
            S  : out STD_LOGIC_VECTOR (1 downto 0)
    );
    end component;

    component Reg_LOAD_CLR_2bit is
        port (
            D    : in  STD_LOGIC_VECTOR(1 downto 0);
            CLK  : in  STD_LOGIC;
            LOAD : in  STD_LOGIC;
            CLR  : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;
    
    signal nextCount : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal Q_int : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin
  Register_2bit_1: Reg_LOAD_CLR_2bit
    port map (
        D => nextCount,
        CLK => CLK,
        LOAD => EN,
        CLR => CLR,
         Q => Q_int
        );

  Adder_2bit_1: Adder_2bit
    port map (
        A => "01",
        B => Q_int,
        Ci => '0',
        Co => ROLL,
        S => nextCount
    );
    
Q <= Q_int; 

end architecture;
