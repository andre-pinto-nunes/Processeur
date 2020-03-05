library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity reg_tb is
end entity reg_tb;

architecture Bench of reg_tb is

signal clk,rst: std_logic;
signal w: std_logic_vector(31 downto 0);
signal ra,rb,rw : std_logic_vector(3 downto 0);
signal we : std_logic;
signal a,b : std_logic_vector(31 downto 0);

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

		--lecture REG15 sur A -> 00000030
		rst <= '0';
		we <= '0';
		w <= (others => '0');
		rw <= (others => '0');
		ra <= X"F";
		rb <= X"0";
		wait for 10 ns;
		
		--lecture REG0 A et B
		ra <= X"0";
		rb <= X"0";
		wait for 10 ns;
		--lecture REG1
		ra <= X"1";
		rb <= X"1";
		wait for 10 ns;
		--lecture REG2
		ra <= X"2";
		rb <= X"2";
		wait for 10 ns;
		
		--ECRITURE 0x00000093 sur REG4
		we <= '1';
		w <= X"00000093";
		rw <= X"4";
		--lecture REG3
		ra <= X"3";
		rb <= X"3";
		wait for 10 ns;
		--lecture REG4 -> 0x00000093
		ra <= X"4";
		rb <= X"4";
		wait for 10 ns;
		--lecture REG5
		ra <= X"5";
		rb <= X"5";
		wait for 10 ns;
		--lecture REG4 + test reset asynchrone (met REG4 a 0)
		ra <= X"4";
		rb <= X"4";
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		--lecture REG7
		ra <= X"7";
		rb <= X"7";
		wait for 10 ns;
		
		--ECRITURE 0xFFFFFFFF sur REG12
		we <= '1';
		w <= X"FFFFFFFF";
		rw <= X"C";
		--lecture REG8
		ra <= X"8";
		rb <= X"8";
		wait for 10 ns;
		
		ra <= X"9";
		rb <= X"9";
		wait for 10 ns;
		ra <= X"A";
		rb <= X"A";
		wait for 10 ns;
		ra <= X"B";
		rb <= X"B";
		wait for 10 ns;
		--lecture REG12 -> 0xFFFFFFFF
		ra <= X"C";
		rb <= X"C";
		wait for 10 ns;
		ra <= X"D";
		rb <= X"D";
		wait for 10 ns;
		ra <= X"E";
		rb <= X"F";
		wait for 10 ns;
		ra <= X"2";
		rb <= X"6";
		wait for 10 ns;
		
		wait;
	
	end process;

  uut: entity work.reg port map	(clk => clk,
								 rst => rst,
								 w => w,
								 ra => ra,
								 rb => rb,
								 rw => rw,
								 we => we,
								 a => a,
								 b => b );
end architecture;