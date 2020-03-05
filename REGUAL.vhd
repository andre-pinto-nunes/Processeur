library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity regual is
	port 	(clk,rst:	in std_logic;
			 ra,rb,rw : in std_logic_vector(3 downto 0);
			 we : 		in std_logic;
			 op :		in std_logic_vector(1 downto 0);
			 n :		out std_logic);
end entity;

architecture struct of regual is

signal a,b,w : std_logic_vector(31 downto 0);

begin

	reg : entity work.reg port map(clk => clk,
										 rst => rst,
										 w => w,
										 ra => ra,
										 rb => rb,
										 rw => rw,
										 we => we,
										 a => a,
										 b => b);
    ual : entity work.ual port map(op,a,b,w,n);
	
end architecture;  