----------------------------------------------------------------------------
-- Entity:        DFF_EN_RESET
-- Written By:    E. George Walters
-- Date Created:  9 Feb 19
-- Description:   VHDL model of a D flip-flop with enable and reset
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DFF_EN_RESET is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of DFF_EN_RESET is
    component DFF is
        port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC
        );
    end component;

    component Mux2to1 is
        port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;

    signal n1, n2, Q_int : STD_LOGIC;

begin
    mux1: Mux2to1
        port map (
            D0  => Q_int,
            D1  => D,
            SEL => EN,
            Y   => n1
        );

    n2 <= n1 and not RESET;

    dff1: DFF
        port map (
            D    => n2,
            CLK  => CLK,
            Q    => Q_int
        );

    Q <= Q_int;

end architecture;
