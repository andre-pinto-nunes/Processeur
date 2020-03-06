library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGN is
  generic (
  	N : positive range 1 to 32
  );
  port (
	clk, rst : in std_logic;
	dataIn : in std_logic_vector(N-1 downto 0) ;
	dataOut : out std_logic_vector(N-1 downto 0)
  ) ;
end entity ; -- REGN

architecture behav of REGN is

	signal q : std_logic_vector(N-1 downto 0) ;

begin

	dataOut <= q;

	PCreg : process( clk, rst )
	begin
	  if( rst = '1' ) then
	  	q <= (others => '0');
	  elsif( rising_edge(clk) ) then
		q <= dataIn;
	  end if ;
	end process ; -- PCreg

end architecture ; -- behav