library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity registres is
	port 	(clk,rst:	in Std_logic;
			 w: 		in std_logic_vector(31 downto 0);
			 ra,rb,rw : in std_logic_vector(3 downto 0);
			 we : 		in std_logic;
			 a,b : 		out std_logic_vector(31 downto 0));
end entity;

architecture Behaviour of registres is

	type table is array (15 downto 0) of std_logic_vector(31 downto 0);

	function init_banc return table is
	variable res : table;
	begin
		for i in 14 downto 0 loop
			res(i) := (others=>'0');
		end loop;
		res(15) := X"00000030";
		return res;
	end init_banc;

	signal Banc : table:=init_banc;

begin

	--LECTURE
	process(ra,rb,banc)
	begin
		a <= (others => '-');
		b <= (others => '-');
		if (to_integer(unsigned(ra)) >= 0) and (to_integer(unsigned(ra)) <= 15) then
			a <= banc(to_integer(unsigned(ra)));
		end if;
		if (to_integer(unsigned(rb)) >= 0) and (to_integer(unsigned(rb)) <= 15) then
			b <= banc(to_integer(unsigned(rb)));
		end if;
	end process;
	
	--ECRITURE
	process(clk,rst)
	begin
		if rst = '1' then
			if (to_integer(unsigned(rw)) >= 0) and (to_integer(unsigned(rw)) <= 15) then
				banc(to_integer(unsigned(rw))) <= X"00000000";
			end if;
		elsif Rising_edge(clk) then
			if we = '1' then
				if (to_integer(unsigned(rw)) >= 0) and (to_integer(unsigned(rw)) <= 15) then
					banc(to_integer(unsigned(rw))) <= w;
				end if;
			end if;
		end if;
	end process;
	
end architecture;
