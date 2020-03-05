library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity UAL_TEST is
end entity UAL_TEST;

architecture test_bench of UAL_TEST is

signal OP  : std_logic_vector(1 downto 0);
signal A, B: std_logic_vector(31 downto 0);
signal S   : std_logic_vector(31 downto 0);
signal N   : std_logic;

begin

	test : process
	begin
		OP <= "00";
		A  <= "00000000000000000000000000000000";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be "0"

		OP <= "00";
		A  <= "00000000000100000000000100001000";
		B  <= "00000100000000000100000000100000";
		wait for 5 ns;  -- must be "a + b"

		OP <= "00";
		A  <= "00000000000000000001111110000000";
		B  <= "00000000000000000000011111110000";
		wait for 5 ns;	-- must be "a + b"

		OP <= "00";
		A  <= "11111111111111111100000000000000";
		B  <= "00000000000011111111111100000000";
		wait for 5 ns;	-- must be "a + b"

		OP <= "01";
		A  <= "00000000000000000000000000000000";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be "b"

		OP <= "01";
		A  <= "00000000000000000000000000000000";
		B  <= "00000000111111111110000000000000";
		wait for 5 ns;	-- must be "b"

		OP <= "10";
		A  <= "00000000001111111111111111111111";
		B  <= "00000000001111111111111111111110";
		wait for 5 ns;	-- must be "a - b"

		OP <= "10";
		A  <= "00000000011111111111111111111110";
		B  <= "00000000111111111111111111111111";
		wait for 5 ns;	-- must be "a - b"
		
		OP <= "11";
		A  <= "00000000000000000000000000000000";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be "a"

		OP <= "11";
		A  <= "10000000000000000111111111111111";
		B  <= "00000000000000000000000000000000";
		wait for 5 ns;	-- must be "a"

		wait;

	end process ; -- test

	UAL: entity work.UAL(behavioural) port map (OP, A, B, S, N);

end architecture test_bench;