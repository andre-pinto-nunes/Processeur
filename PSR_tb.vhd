library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-----------------------------------------------------------

entity PSRTEST is
end entity ;

-----------------------------------------------------------

architecture testbench of PSRTEST is

SIGNAL RST     : std_logic;
SIGNAL CLK     : std_logic;
SIGNAL WE      : std_logic;
SIGNAL DATAIN  : std_logic_vector(31 downto 0) ;
SIGNAL DATAOUT : std_logic_vector(31 downto 0) ;

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	ClOk: process
	begin
		while now <= 100 NS loop
			CLK <= '0';
			wait for 5 NS;
			CLK <= '1';
			wait for 5 NS;
		end loop;
		wait;
	end process;


	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	stim : process
	begin
		RST <= '1';
		WE  <= '0';
		DATAIN <= "00000000000000000000000000000000";
		wait for 10 ns;

		RST <= '0';
		DATAIN <= "01011111010101111111010101011100";
		wait for 10 ns;

		WE     <= '1';
		wait for 10 ns;

		DATAIN <= "01011111010101111111010101011100";
		wait for 10 ns;

		DATAIN <= "11100100111111111000000001001001";
		wait for 10 ns;
		
		WE     <= '0';
		DATAIN <= "01011111010101111111010101011100";
		wait for 10 ns;		
		
		WE     <= '1';
		wait for 10 ns;		
		
		RST <= '1';
		wait for 10 ns;
		

		wait;	
	end process ; -- stim

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------

	PSR : entity work.PSR(behavioural) port map (DATAIN, RST, CLK, WE, DATAOUT);

end architecture testbench;