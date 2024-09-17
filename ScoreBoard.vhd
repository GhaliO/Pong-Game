----------------------------------------------------------------------------
-- Entity:        ScoreBoard
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of the score board for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoard is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoard is

    component ScoreBoardFSM is
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
    end component;
    
    component ScoreBoardDatapath is
        port (
            LOADP1  : in  STD_LOGIC;
            LOADP2  : in  STD_LOGIC;
            P1ORP2  : in  STD_LOGIC;
            ADD1OR6 : in  STD_LOGIC;
            CLK     : in  STD_LOGIC;
            RESET   : in  STD_LOGIC;
            P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
            P2SCORE : out STD_LOGIC_VECTOR(7 downto 0);
            EQU10   : out STD_LOGIC
        );
    end component;
    
    signal load_p1_int : STD_LOGIC; 
    signal load_p2_int : STD_LOGIC; 
    signal p1_or_p2_int : STD_LOGIC; 
    signal add_1_or_6_int : STD_LOGIC; 
    signal equ_10_int : STD_LOGIC; 

begin

        score_board_FSM_1: ScoreBoardFSM
        port map (
            P1POINT => P1POINT,
            P2POINT => P2POINT,
            EQU10 => equ_10_int,
            CLK => CLK,
            RESET => RESET,
            LOADP1 => load_p1_int,
            LOADP2 => load_p2_int, 
            P1ORP2 => p1_or_p2_int,
            ADD1OR6 => add_1_or_6_int
        );
        
        score_board_datapath_1: ScoreBoardDatapath
        port map (
            LOADP1 => load_p1_int,
            LOADP2 => load_p2_int, 
            P1ORP2 => p1_or_p2_int,
            ADD1OR6 => add_1_or_6_int,
            CLK => CLK,
            RESET => RESET,
            P1SCORE => P1SCORE,
            P2SCORE => P2SCORE,
            EQU10 => equ_10_int
        );


end architecture;