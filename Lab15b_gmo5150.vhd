--------------------------------------------------------------------------------
-- Entity:        Lab15a_StartingVHDL
-- Written By:    Ghali Ouaritini
-- Date Created:  8/2/2024
-- Description:   CMPEN 270 Lab #15a starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab15b_gmo5150 is
    port (
        SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
        BTNL    : in  STD_LOGIC;
        BTNR    : in  STD_LOGIC;
        BTNU    : in  STD_LOGIC;
        BTND    : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        LED     : out STD_LOGIC_VECTOR(15 downto 0);
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Structural of Lab15b_gmo5150 is
    component Synch is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component Debounce is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;

component PulseGenerator_125ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;

component ControlFSM is
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
end component;

component DisplayFSM is
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
end component;

    component WordTo4DigitDisplayDriver is
     port (
         WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
         PULSE   : in  STD_LOGIC;
         CLK     : in  STD_LOGIC;
         SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
         ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

   component ScoreBoard is
        port (
            P1POINT : in  STD_LOGIC;
            P2POINT : in  STD_LOGIC;
            CLK     : in  STD_LOGIC;
            RESET   : in  STD_LOGIC;
            P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
            P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
signal displayWord: STD_LOGIC_VECTOR(15 downto 0);     
signal sync_1_out: STD_LOGIC; 
signal sync_2_out: STD_LOGIC;
signal debounce_1_out: STD_LOGIC; 
signal debounce_2_out: STD_LOGIC;
signal pulse_1ms_out: STD_LOGIC;
signal pulse_125ms_out: STD_LOGIC;
signal move_left_and_125_pulse_out: STD_LOGIC;
signal move_right_and_125_pulse_out: STD_LOGIC;
signal one_shot_1_out: STD_LOGIC;
signal one_shot_2_out: STD_LOGIC;
signal move_left_out: STD_LOGIC;
signal move_right_out: STD_LOGIC;
signal p1_rts_out: STD_LOGIC;
signal p1_point_out: STD_LOGIC;
signal p2_rts_out: STD_LOGIC;
signal p2_point_out: STD_LOGIC;
signal pos_out: STD_LOGIC_VECTOR(15 downto 0);

begin

move_left_and_125_pulse_out <= move_left_out and pulse_125ms_out; 
move_right_and_125_pulse_out <= move_right_out and pulse_125ms_out; 

        synch_1: Synch
        port map (
            D => BTNL,
            CLK => CLK,
            Q => sync_1_out
        );
        
        synch_2: Synch
        port map (
            D => BTNR,
            CLK => CLK,
            Q => sync_2_out
        );
        
        pulse_1ms: PulseGenerator_1ms
        port map (
            CLK => CLK,
            PULSE => pulse_1ms_out
        );
    
        pulse_125ms: PulseGenerator_125ms
        port map (
            CLK => CLK,
            PULSE => pulse_125ms_out
        );
        
        debounce_1: Debounce
        port map (
            D => sync_1_out,
            CLK => CLK,
            PULSE => pulse_1ms_out, 
            Q => debounce_1_out
        );
        
        debounce_2: Debounce
        port map (
            D => sync_2_out,
            CLK => CLK,
            PULSE => pulse_1ms_out,
            Q => debounce_2_out
        );
        
        oneshot_1: OneShot
        port map (
            D => debounce_1_out,
            CLK => CLK,
            Q => one_shot_1_out
        );
        
        oneshot_2: OneShot
        port map (
            D => debounce_2_out,
            CLK => CLK,
            Q => one_shot_2_out
        );
        
        controlFSM_1: ControlFSM
        port map (
            BTNU => BTNU,
            BTNL => one_shot_1_out,
            BTNR => one_shot_2_out,
            POS => pos_out,
            CLK => CLK,
            RESET => BTND,
            MOVELEFT => move_left_out,
            MOVERIGHT => move_right_out,
            P1RTS => p1_rts_out, 
            P1POINT => p1_point_out,
            P2RTS => p2_rts_out,
            P2POINT => p2_point_out
        );
        
        displayFSM_1: DisplayFSM
        port map (
            MOVELEFT => move_left_and_125_pulse_out,
            MOVERIGHT => move_right_and_125_pulse_out,
            P1RTS => p1_rts_out, 
            P1POINT => p1_point_out,
            P2RTS => p2_rts_out,
            P2POINT => p2_point_out, 
            CLK => CLK,
            RESET => BTND,
            POS => pos_out
        );
 
        word_to_display_1: WordTo4DigitDisplayDriver
        port map (
            WORD => displayWord,
            PULSE => pulse_1ms_out, 
            CLK => CLK,
            SEGMENT => SEGMENT(0 to 6),
            ANODE => ANODE(3 downto 0)
        );
               
        score_board_1: ScoreBoard
        port map (
            P1POINT => p1_point_out,
            P2POINT => p2_point_out, 
            CLK => CLK,
            RESET => BTND,
            P1SCORE => displayWord(15 downto 8),
            P2SCORE => displayWord(7 downto 0)
        );
        
        LED <= pos_out; 

        end architecture;