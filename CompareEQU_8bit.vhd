----------------------------------------------------------------------------
-- Entity:        CompareEQU_8bit
-- Written By:    Ghali Ouaritini
-- Date Created:  7/24/2024
-- Description:   VHDL model of an 8-bit equality comparitor
--
-- Revision History (date, initials, description):
--
-- Dependencies:
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity CompareEQU_4bit is
    port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        EQU : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of CompareEQU_4bit is
    
begin

EQU <= not(A(0) xor B(0)) and not(A(1) xor B(1)) and not(A(2) xor B(2)) and not(A(3) xor B(3)); 

end architecture;