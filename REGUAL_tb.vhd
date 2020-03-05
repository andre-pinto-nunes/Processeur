library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity regual_tb is
end entity regual_tb;

architecture Bench of regual_tb is

signal clk,rst: std_logic;
signal ra,rb,rw : std_logic_vector(3 downto 0);
signal we : std_logic;
signal op : std_logic_vector(1 downto 0);
signal n : std_logic;

begin

	clk_gen: process
    begin
		while now <= 300 NS loop
			clk <= '0';
			wait for 5 NS;
			clk <= '1';
			wait for 5 NS;
		end loop;
		wait;
    end process;
	
	sig_gen: process
	begin

		rst <= '0';
		we <= '0';
		rw <= (others => '0');
		ra <= X"F"; --busA = R(15)
		rb <= X"0"; --busB = R(0)
		op <= "11"; --busW = busA
		wait for 10 ns;
		we <= '1';
		rw <= X"1"; --ecriture de busW (=R(15)) dans R(1)
		wait for 10 ns;
		ra <= X"1";
		rb <= X"F";
		op <= "00";
		rw <= X"2";
		wait for 10 ns;
		ra <= X"1";
		rb <= X"F";
		op <= "10";
		rw <= X"3";
		wait for 10 ns;
		ra <= X"7";
		rb <= X"F";
		op <= "10";
		rw <= X"5";
		wait for 10 ns;
		
		wait;
	
	end process;

  uut: entity work.regual port map(clk => clk,
									 rst => rst,
									 ra => ra,
									 rb => rb,
									 rw => rw,
									 we => we,
									 op => op,
									 n => n );
end architecture;