library IEEE;
use IEEE.Std_logic_1164.all;

entity MEM_TEST is
end entity MEM_TEST;

architecture test_bench of MEM_TEST is

SIGNAL CLK     : std_logic;
SIGNAL WrEn    : std_logic;
SIGNAL Addr    : std_logic_vector(5 downto 0);
SIGNAL DataIn  : std_logic_vector(31 downto 0);
SIGNAL DataOut : std_logic_vector(31 downto 0);

begin

	ClOk: process
	begin
		while now <= 50 NS loop
			CLK <= '0';
			wait for 5 NS;
			CLK <= '1';
			wait for 5 NS;
		end loop;
		wait;
	end process;

	test : process
	begin

		-- INIT
		WrEn   <= '0';
		Addr   <= "000000";
		DataIn <= "00000000000000000000000000000000";
		wait for 10 ns;	

		WrEn   <= '0';
		Addr   <= "000100";
		DataIn <= "00000000000000000000000000001010";
		wait for 10 ns;		-- nothing

		WrEn   <= '1';
		Addr   <= "000100";
		DataIn <= "00000000000000000000000000001010";
		wait for 10 ns;		-- must be 10 in addr 8

		WrEn   <= '1';
		Addr   <= "000101";
		DataIn <= "00000000000000000000000000000001";
		wait for 10 ns;		-- must be 10 in addr 8

		WrEn   <= '1';
		Addr   <= "111111";
		DataIn <= "11111111111111111111111111111111";
		wait for 10 ns;		-- must be 111...111 in addr 111111


		wait;

	end process ; -- test

	MEM: entity work.MEM(behavioural) port map (CLK, WrEn, Addr, DataIn, DataOut);

end architecture test_bench;