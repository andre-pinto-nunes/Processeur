library IEEE;
use IEEE.Std_logic_1164.all;

entity EXT_TEST is
end entity EXT_TEST;

architecture test_bench of EXT_TEST is

signal E : std_logic_vector(15 downto 0);
signal S : std_logic_vector(31 downto 0);

begin

	test : process
	begin
		E  <= "0000000000000000";
		wait for 5 ns;
		
		E  <= "1010001010010101";
		wait for 5 ns;
		
		E  <= "0110101001001001";
		wait for 5 ns;
		
		E  <= "0101111110011110";
		wait for 5 ns;

		wait;

	end process ; -- test

	EXT: entity work.EXT(behavioural) generic map (15) port map (E, S);

end architecture test_bench;