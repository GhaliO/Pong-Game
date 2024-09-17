----------------------------------------------------------------------------
-- Entity:        ScoreBoardDatapath
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of the score board datapath for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoardDatapath is
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
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoardDatapath is

    component Reg_LOAD_CLR_8bit is
        port (
            D    : in  STD_LOGIC_VECTOR(7 downto 0);
            CLK  : in  STD_LOGIC;
            LOAD : in  STD_LOGIC;
            CLR  : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component Mux2to1_8bit is
        port (
            D0  : in  STD_LOGIC_VECTOR (7 downto 0);
            D1  : in  STD_LOGIC_VECTOR (7 downto 0);
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component Adder_8bit is
        port (
            A   : in  STD_LOGIC_VECTOR (7 downto 0);
            B   : in  STD_LOGIC_VECTOR (7 downto 0);
            SUM : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component CompareEQU_4bit is
        port (
            A   : in  STD_LOGIC_VECTOR(3 downto 0);
            B   : in  STD_LOGIC_VECTOR(3 downto 0);
            EQU : out STD_LOGIC
        );
    end component;

    signal P1SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
    signal P2SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
    signal mux_p1_or_p2_int : STD_LOGIC_VECTOR(7 downto 0);
    signal mux_add_1_or_6_int : STD_LOGIC_VECTOR(7 downto 0);
    signal adder_output_int : STD_LOGIC_VECTOR(7 downto 0);

begin

    P1SCORE <= P1SCORE_int;
    P2SCORE <= P2SCORE_int;

        register_8bit_1: Reg_LOAD_CLR_8bit
        port map (
            D => adder_output_int,
            CLK => CLK,
            LOAD => LOADP1,
            CLR => RESET, 
            Q => P1SCORE_int
        );
        
        register_8bit_2: Reg_LOAD_CLR_8bit
        port map (
            D => adder_output_int,
            CLK => CLK,
            LOAD => LOADP2,
            CLR => RESET, 
            Q => P2SCORE_int
        );
        
                adder_8bit_1: Adder_8bit
        port map (
            A => mux_add_1_or_6_int,
            B => mux_p1_or_p2_int,
            SUM => adder_output_int
        );
        
        compare_4bit_1: CompareEQU_4bit
        port map (
            A => mux_p1_or_p2_int(3 downto 0),
            B => "1010",
            EQU => EQU10
        );

        
        mux2to1_8bit_p1_or_p2: Mux2to1_8bit
        port map (
            D0 => P1SCORE_int,
            D1 => P2SCORE_int,
            SEL => P1ORP2,
            Y => mux_p1_or_p2_int
        );
        
        mux2to1_8bit_one_or_six: Mux2to1_8bit
        port map (
            D0 => "00000001",
            D1 => "00000110",
            SEL => ADD1OR6,
            Y => mux_add_1_or_6_int
        );
        

end architecture;