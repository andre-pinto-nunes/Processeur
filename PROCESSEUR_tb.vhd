library IEEE;
use IEEE.Std_logic_1164.all;

entity PRO_TEST is
end entity PRO_TEST;

architecture test_bench of PRO_TEST is

SIGNAL CLK     : std_logic;
SIGNAL RST     : std_logic;

begin
    PROCESSEUR        : entity work.PROCESSEUR(behavioural)        port map( CLK, RST );

	ClOk: process
	begin
		while now <= 3000 NS loop
			CLK <= '0';
			wait for 5 NS;
			CLK <= '1';
			wait for 5 NS;
		end loop;
		wait;
	end process;

	stim : process
	begin
		RST <= '1';
		wait for 10 NS;

		RST <= '0';
		wait for 10 NS;

		wait;
	end process ; -- stim


end architecture ;