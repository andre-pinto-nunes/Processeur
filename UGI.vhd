library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UGI is
  port (
  	clk, reset, nPCsel : in std_logic ;
  	offset : in std_logic_vector(23 downto 0) ;
  	instr : out std_logic_vector(31 downto 0)
  ) ;
end entity ;

architecture struct of UGI is

	signal PCin, PcOut, extOffset : std_logic_vector(31 downto 0) ;

begin

	instructionMem : entity work.MEM port map(CLK => '0',
									          WrEn => '0',
									          Addr => PcOut(5 downto 0),
									          DataIn => (others => '0'),
									          DataOut => instr);

	signExt : entity work.EXT generic map(24)
							  port map(E => offset,
									   S => extOffset);

	--registre PC
	PCreg : entity work.REGN 	generic map(32)
								port map(clk => clk,
										 rst => reset,
										 DataIn => PCin,
										 DataOut => PCout);

	--mise à jour PC
	--majPC : entity work.MUX2	generic map(32)
	--							port map(A => std_logic_vector(unsigned(PC)+1),
	--									 B => std_logic_vector(unsigned(PC)+1+unsigned(extOffset)),
	--									 COM => nPCsel,
	--									 S => PCin);

	PCin <= std_logic_vector(unsigned(PcOut)+1) when nPCsel = '0' else
		  std_logic_vector(unsigned(PcOut)+unsigned(extOffset)) when nPCsel = '0' else
		  (others => '-');

end architecture ;