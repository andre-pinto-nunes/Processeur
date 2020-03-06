library IEEE;
use IEEE.Std_logic_1164.all;

entity AUT is
    port (
        CLK   : IN   std_logic;
        RST   : IN   std_logic;
        COM1  : IN   std_logic;
        COM2  : IN   std_logic;
        WrEn  : IN   std_logic;
        RegWr : IN   std_logic;
        Rw    : IN   std_logic_vector(3 downto 0);
        Ra    : IN   std_logic_vector(3 downto 0);
        Rb    : IN   std_logic_vector(3 downto 0);
        OP    : IN   std_logic_vector(1 downto 0);
        Imm   : IN   std_logic_vector(7 downto 0)
    );
end entity AUT;

architecture behavioural of AUT is

SIGNAL BusA    : std_logic_vector(31 downto 0);
SIGNAL BusB    : std_logic_vector(31 downto 0);
SIGNAL BusW    : std_logic_vector(31 downto 0);
SIGNAL ImmEx   : std_logic_vector(31 downto 0);
SIGNAL SMUX1   : std_logic_vector(31 downto 0);
SIGNAL ALUout  : std_logic_vector(31 downto 0);
SIGNAL DataOut : std_logic_vector(31 downto 0);
SIGNAL Flag    : std_logic;

begin
	
	EXT  : entity work.EXT(behavioural)      generic map(8) port map( Imm, ImmEx );
	
	REG  : entity work.REG(Behaviour) port map( CLK, RST, BusW, Ra, Rb, Rw, RegWr, BusA, BusB);

	MUX1 : entity work.MUX2(behavioural)     generic map(32) port map( BusB, ImmEx, COM1, SMUX1 );

	UAL  : entity work.UAL(behavioural)      port map( OP, BusA, SMUX1, ALUout, Flag );

	MEM  : entity work.MEM(behavioural)      port map( CLK, WrEn, ALUout(5 downto 0), BusB, DataOut);

	MUX2 : entity work.MUX2(behavioural)     generic map(32) port map( ALUout, DataOut, COM2, BusW );

end architecture behavioural;