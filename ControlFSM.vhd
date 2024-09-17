----------------------------------------------------------------------------
-- Entity:        ControlFSM
-- Written By:    Ghali Ouaritini
-- Date Created:  8/2/2024
-- Description:   VHDL model of the control FSM for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ControlFSM is
    port (
        BTNU      : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;
        POS       : in  STD_LOGIC_VECTOR(15 downto 0);
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        MOVELEFT  : out STD_LOGIC;
        MOVERIGHT : out STD_LOGIC;
        P1RTS     : out STD_LOGIC;
        P1POINT   : out STD_LOGIC;
        P2RTS     : out STD_LOGIC;
        P2POINT   : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ControlFSM is

    -- State enumeration and state register
    type STATE_TYPE is (ResetState, P1_ReadyToServe, BallMovingRight, P1_Point, 
			P2_ReadyToServe, BallMovingLeft, P2_Point);
    signal currentState, nextState : STATE_TYPE;
    
    signal p1GoodHit  : STD_LOGIC;
    signal p1BadSwing : STD_LOGIC;
    signal p2GoodHit  : STD_LOGIC;
    signal p2BadSwing : STD_LOGIC;
    
begin

    p1GoodHit  <= BTNL and (POS(14) or POS(13) or POS(12));
    p1BadSwing <= POS(15) or (BTNL and not(POS(14) or POS(13) or POS(12)));
    p2GoodHit  <= BTNR and (POS(3) or POS(2) or POS(1));
    p2BadSwing <= POS(0) or (BTNR and not(POS(3) or POS(2) or POS(1)));

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
	process (currentState, p1GoodHit, p1BadSwing, p2GoodHit, p2BadSwing) is
	begin
		case currentState is

			when ResetState => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '0';
				P1RTS     <= '0';
				P1POINT   <= '0';
				P2RTS     <= '0';
				P2POINT   <= '0';
				if (RESET = '0' and BTNU = '1') then
				    nextState <= P1_ReadyToServe;
                else
                    nextState <= ResetState;
                end if;

			when P1_ReadyToServe => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '0';
				P1RTS     <= '1';
				P1POINT   <= '0';
				P2RTS     <= '0';
				P2POINT   <= '0';
				if (BTNU = '0') then
				    nextState <= BallMovingRight;
                else
                    nextState <= P1_ReadyToServe;
                end if;

			when BallMovingRight => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '1';
				P1RTS     <= '0';
				P1POINT   <= '0';
				P2RTS     <= '0';
				P2POINT   <= '0';
				if (p2BadSwing = '1') then
				    nextState <= P1_Point;
                elsif (p2GoodHit = '1') then 
                    nextState <= BallMovingLeft;
                else
                    nextState <= BallMovingRight;
                end if;

			when P1_Point => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '0';
				P1RTS     <= '0';
				P1POINT   <= '1';
				P2RTS     <= '0';
				P2POINT   <= '0';
				if (BTNU = '1') then
				    nextState <= P1_ReadyToServe;
                else
                    nextState <= P1_Point;
                end if;

			when P2_ReadyToServe => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '0';
				P1RTS     <= '0';
				P1POINT   <= '0';
				P2RTS     <= '1';
				P2POINT   <= '0';
				if (BTNU = '0') then
				    nextState <= BallMovingLeft;
                else
                    nextState <= P2_ReadyToServe;
                end if;

			when BallMovingLeft => 
				MOVELEFT  <= '1';
				MOVERIGHT <= '0';
				P1RTS     <= '0';
				P1POINT   <= '0';
				P2RTS     <= '0';
				P2POINT   <= '0';
				if (p1BadSwing = '1') then
				    nextState <= P2_Point;
                elsif (p1GoodHit = '1') then 
                    nextState <= BallMovingRight;
                else
                    nextState <= BallMovingLeft;
                end if;

			when P2_Point => 
				MOVELEFT  <= '0';
				MOVERIGHT <= '0';
				P1RTS     <= '0';
				P1POINT   <= '0';
				P2RTS     <= '0';
				P2POINT   <= '1';
				if (BTNU = '1') then
				    nextState <= P2_ReadyToServe;
                else
                    nextState <= P2_Point;
                end if;

			when others => 
				MOVELEFT  <= '0';
                MOVERIGHT <= '0';
                P1RTS     <= '0';
                P1POINT   <= '0';
                P2RTS     <= '0';
                P2POINT   <= '0';
				nextState <= ResetState;

		end case;

	end process;

end architecture;