library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UGI_tb is
end entity ; -- UGI_tb

architecture Bench of UGI_tb is

signal clk,rst,nPCsel : std_logic;
signal offset : std_logic_vector(23 downto 0);
signal instr : std_logic_vector(31 downto 0);

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
		nPCsel <= '0';
		offset <= (others => '0');
		wait for 10 ns;

		rst <= '1';
		nPCsel <= '0';
		offset <= (others => '0');
		wait for 10 ns;

		rst <= '0';
		nPCsel <= '1';
		offset <= X"000023";
		wait for 10 ns;

		rst <= '0';
		nPCsel <= '0';
		offset <= (others => '0');
		wait for 10 ns;
		
		wait;
	
	end process;

  uut: entity work.UGI port map(clk => clk,
								 reset => rst,
								 nPCsel => nPCsel,
								 offset => offset,
								 instr => instr);
end architecture;