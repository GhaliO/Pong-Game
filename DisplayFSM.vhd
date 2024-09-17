----------------------------------------------------------------------------
-- Entity:        DisplayFSM
-- Written By:    Ghali Ouaritini
-- Date Created:  8/2/2024
-- Description:   VHDL model of the display FSM for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DisplayFSM is
    port (
        MOVELEFT  : in  STD_LOGIC;
        MOVERIGHT : in  STD_LOGIC;
        P1RTS     : in  STD_LOGIC;
        P1POINT   : in  STD_LOGIC;
        P2RTS     : in  STD_LOGIC;
        P2POINT   : in  STD_LOGIC;
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        POS       : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of DisplayFSM is

    -- State enumeration and state register
    type STATE_TYPE is (ResetState, P15, P14, P13, P12, P11, P10, P9, P8, 
            P7, P6, P5, P4, P3, P2, P1, P0);
    signal currentState, nextState : STATE_TYPE;
    
begin

    -- State register
    process (CLK) is
    begin
        if (rising_edge(CLK)) then
            if (RESET = '1') then
                currentState <= ResetState;
            elsif (P1RTS = '1' or P2POINT = '1') then
                currentState <= P15;
            elsif (P2RTS = '1' or P1POINT = '1') then
                currentState <= P0;
            else
                currentState <= nextState;
            end if;
        end if;
    end process;

	-- Next state logic
	process (currentState, MOVELEFT, MOVERIGHT, RESET) is
	begin
		case currentState is

			when ResetState => 
				POS <= "0000000000000000";
				if (RESET = '0') then
				    nextState <= P15;
                else
                    nextState <= ResetState;
                end if;

			when P15 => 
				POS <= "1000000000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P14;
                else
                    nextState <= P15;
                end if;

			when P14 => 
				POS <= "0100000000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P13;
                elsif (MOVELEFT = '1') then
                    nextState <= P15;
                else
                    nextState <= P14;
                end if;

			when P13 => 
				POS <= "0010000000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P12;
                elsif (MOVELEFT = '1') then
                    nextState <= P14;
                else
                    nextState <= P13;
                end if;

			when P12 => 
				POS <= "0001000000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P11;
                elsif (MOVELEFT = '1') then
                    nextState <= P13;
                else
                    nextState <= P12;
                end if;

			when P11 => 
				POS <= "0000100000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P10;
                elsif (MOVELEFT = '1') then
                    nextState <= P12;
                else
                    nextState <= P11;
                end if;

			when P10 => 
				POS <= "0000010000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P9;
                elsif (MOVELEFT = '1') then
                    nextState <= P11;
                else
                    nextState <= P10;
                end if;

			when P9 => 
				POS <= "0000001000000000";
                if (MOVERIGHT = '1') then
                    nextState <= P8;
                elsif (MOVELEFT = '1') then
                    nextState <= P10;
                else
                    nextState <= P9;
                end if;

			when P8 => 
				POS <= "0000000100000000";
                if (MOVERIGHT = '1') then
                    nextState <= P7;
                elsif (MOVELEFT = '1') then
                    nextState <= P9;
                else
                    nextState <= P8;
                end if;

			when P7 => 
				POS <= "0000000010000000";
                if (MOVERIGHT = '1') then
                    nextState <= P6;
                elsif (MOVELEFT = '1') then
                    nextState <= P8;
                else
                    nextState <= P7;
                end if;

			when P6 => 
				POS <= "0000000001000000";
                if (MOVERIGHT = '1') then
                    nextState <= P5;
                elsif (MOVELEFT = '1') then
                    nextState <= P7;
                else
                    nextState <= P6;
                end if;

			when P5 => 
				POS <= "0000000000100000";
                if (MOVERIGHT = '1') then
                    nextState <= P4; -- Corrected to P4
                elsif (MOVELEFT = '1') then
                    nextState <= P6;
                else
                    nextState <= P5;
                end if;

			when P4 => 
				POS <= "0000000000010000";
                if (MOVERIGHT = '1') then
                    nextState <= P3;
                elsif (MOVELEFT = '1') then
                    nextState <= P5;
                else
                    nextState <= P4;
                end if;

			when P3 => 
				POS <= "0000000000001000";
                if (MOVERIGHT = '1') then
                    nextState <= P2;
                elsif (MOVELEFT = '1') then
                    nextState <= P4;
                else
                    nextState <= P3;
                end if;

			when P2 => 
				POS <= "0000000000000100";
                if (MOVERIGHT = '1') then
                    nextState <= P1;
                elsif (MOVELEFT = '1') then
                    nextState <= P3;
                else
                    nextState <= P2;
                end if;

			when P1 => 
				POS <= "0000000000000010";
                if (MOVERIGHT = '1') then
                    nextState <= P0;
                elsif (MOVELEFT = '1') then
                    nextState <= P2;
                else
                    nextState <= P1;
                end if;

			when P0 => 
				POS <= "0000000000000001";
                if (MOVELEFT = '1') then
                    nextState <= P1;
                else
                    nextState <= P0;
                end if;

			when others => 
				POS <= "0000000000000000";
				nextState <= ResetState;

		end case;

	end process;
end architecture;
