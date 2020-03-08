library IEEE;
use IEEE.Std_logic_1164.all;

entity PROCESSEUR is
	port (
		CLK               : IN std_logic;
		RST               : IN std_logic
	);
end entity PROCESSEUR;


architecture behavioural of PROCESSEUR is
SIGNAL RegSel             : std_logic;
SIGNAL nPCsel             : std_logic;
SIGNAL Rb                 : std_logic_vector(  3 downto 0 );
SIGNAL Instruction        : std_logic_vector( 31 downto 0 );

SIGNAL Rs                 : std_logic_vector(  3 downto 0 );
SIGNAL Rm		          : std_logic_vector(  3 downto 0 );
SIGNAL Rd		          : std_logic_vector(  3 downto 0 );
SIGNAL Imm		          : std_logic_vector(  7 downto 0 );
SIGNAL Offset             : std_logic_vector( 23 downto 0 );

SIGNAL WrSrc              : std_logic;
SIGNAL ALUSrc             : std_logic;
SIGNAL ALUctr             : std_logic_vector(  1 downto 0 );	
SIGNAL MemWr              : std_logic;
SIGNAL PSREn              : std_logic;
SIGNAL flag               : std_logic;
SIGNAL VEC_flag           : std_logic_vector(  0 downto 0 );
SIGNAL RegWr              : std_logic;
SIGNAL PSRin              : std_logic_vector( 31 downto 0 );
SIGNAL PSRout             : std_logic_vector( 31 downto 0 );


begin


	Rs                    <= Instruction( 19 downto 16 );
	Rd                    <= Instruction( 15 downto 12 );
	Rm                    <= Instruction(  3 downto  0 );
	Imm                   <= Instruction(  7 downto  0 );
	Offset                <= Instruction( 23 downto  0 );

	VEC_flag(0)           <= flag;

	-- MUXrb
	with RegSel select Rb <= Rm when '0', Rd when '1', 	(others => '-') when others;
	
	UGI : entity work.UGI    port map( CLK, RST, nPCsel, Offset,                                                          Instruction);
	AUT : entity work.AUT    port map( CLK, RST, ALUSrc, WrSrc, MemWr, RegWr, Rd, Rs, Rb, ALUctr, Imm,                           flag);
	PSR : entity work.PSR    port map( PSRin, RST, CLK, PSREn,                                                                 PSRout);
	EXT : entity work.EXT    generic map(1) port map( VEC_flag,                                                                 PSRin);
	IDC : entity work.IDCU   port map( PSRout, Instruction,                nPCsel, RegWr, RegSel, ALUSrc, ALUctr, PSREn, MemWr, WrSrc);

end architecture behavioural;