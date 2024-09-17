----------------------------------------------------------------------------
-- Entity:        ScoreBoardFSM
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of the score board FSM for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoardFSM is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        EQU10   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        LOADP1  : out STD_LOGIC;
        LOADP2  : out STD_LOGIC;
        P1ORP2  : out STD_LOGIC;
        ADD1OR6 : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoardFSM is

    -- State enumeration and state register
    type STATE_TYPE is (ResetState, Ready, P1_Add1, P1_Check10, P1_Add6, 
			P2_Add1, P2_Check10, P2_Add6, WaitForServe);
    signal currentState, nextState : STATE_TYPE;
    
    
begin

    -- State register
    process (clk) is
    begin
        if (rising_edge(CLK)) then
            if (RESET = '1') then
                currentState <= ResetState;
            else
                currentState <= nextState;
            end if;
        end if;
    end process;

	-- Next state logic
	process (currentState, P1POINT, P2POINT, EQU10) is
	begin
		case currentState is

			when ResetState => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
				if (RESET = '0') then
				    nextState <= Ready;
                else
                    nextState <= ResetState;
                end if;

			when Ready => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
				if (P1POINT = '1') then
				    nextState <= P1_Add1;
				elsif (P2POINT = '1') then
					nextState <= P2_Add1;
                else
                    nextState <= Ready;
                end if;

			when P1_Add1 => 
				LOADP1  <= '1';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
                nextState <= P1_CHECK10;

			when P1_Check10 => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
				if (EQU10 = '1') then
				    nextState <= P1_Add6;
                else
                    nextState <= WaitForServe;
                end if;

			when P1_Add6 => 
				LOADP1  <= '1';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '1';
                nextState <= WaitForServe;

			when P2_Add1 => 
				LOADP1  <= '0';
				LOADP2  <= '1';
				P1ORP2  <= '1';
				ADD1OR6 <= '0';
                nextState <= P2_Check10;

			when P2_Check10 => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '1';
				ADD1OR6 <= '0';
				if (EQU10 = '1') then
				    nextState <= P2_Add6;
                else
                    nextState <= WaitForServe;
                end if;

			when P2_Add6 => 
				LOADP1  <= '0';
				LOADP2  <= '1';
				P1ORP2  <= '1';
				ADD1OR6 <= '1';
                nextState <= WaitForServe;

			when WaitForServe => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
				if (P1POINT = '0' and P2POINT = '0') then
				    nextState <= Ready;
                else
                    nextState <= WaitForServe;
                end if;

			when others => 
				LOADP1  <= '0';
				LOADP2  <= '0';
				P1ORP2  <= '0';
				ADD1OR6 <= '0';
				nextState <= ResetState;

		end case;

	end process;

end architecture;
