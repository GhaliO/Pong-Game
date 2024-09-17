----------------------------------------------------------------------------
-- Entity:        FullAdder
-- Written By:    E. George Walters
-- Date Created:  30 Sep 18
-- Description:   VHDL model of a full adder.  Adds three bits, producing
--   a sum and a carry-out bit
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Ci : in  STD_LOGIC;
        S  : out STD_LOGIC;
        Co : out STD_LOGIC
    );
end entity;

architecture Behavioral of FullAdder is
begin
    process(A, B, Ci)
    begin
    S <= A xor B xor Ci; 
    Co <= (A and B) or (A and Ci) or (B and Ci); 
    end process;
end Behavioral;

