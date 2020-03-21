library IEEE;
use IEEE.Std_logic_1164.all;

entity MUX2_TEST is
end entity MUX2_TEST;

architecture test_bench of MUX2_TEST is

signal COM : std_logic;
signal A, B: std_logic_vector(31 downto 0);
signal S   : std_logic_vector(31 downto 0);

begin

	test : process
	begin
		COM <= '0';
		A  <= "00000000000000000000000000000000";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be 0
		COM <= '0';
		A  <= "00000000111111000111001010100100";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be A
		COM <= '0';
		A  <= "00101010101010101111010101100101";
		B  <= "01111111111111111111111111111111";
		wait for 5 ns;	-- must be A
		COM <= '1';
		A  <= "00101010101010101111010101100101";
		B  <= "01111111111111111111111111111111";
		wait for 5 ns;	-- must be B
		COM <= '1';
		A  <= "00000000000000000000000000000000";
		B  <= "01111111111111111111111111111111";
		wait for 5 ns;	-- must be B
		COM <= '1';
		A  <= "00000000000000000000000000000000";
		B  <= "00101100001010111101010010010100";
		wait for 5 ns;	-- must be B
		COM <= '1';
		A  <= "00000000000000000000000000000000";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be 0
		wait;

	end process ; -- test

	MUX2: entity work.MUX2(behavioural) generic map (32) port map (A, B, COM, S);

end architecture test_bench;