library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEM is
    port (
        CLK     : IN   std_logic;
        WrEn    : IN   std_logic;
        Addr    : IN   std_logic_vector(5 downto 0);
        DataIn  : IN   std_logic_vector(31 downto 0);
        DataOut : OUT  std_logic_vector(31 downto 0)
    );
end entity MEM;

architecture behavioural of MEM is

type table is array (63 downto 0) of std_logic_vector(31 downto 0);

function init_banc return table is
variable res : table;
begin
	for i in 62 downto 0 loop
		res(i) := (others=>'0');
	end loop;
	res(63) := X"00000030";
	return res;
end init_banc;

signal Banc : table:=init_banc;

begin

DataOut <= Banc(to_integer(unsigned(Addr))) when to_integer(unsigned(Addr)) >= 0 and to_integer(unsigned(Addr)) <= 63 else
		   (others => '-');

lecture : process(CLK)
begin
	if Rising_edge(CLK) then
		if WrEn = '1' then
			Banc(to_integer(unsigned(Addr))) <= DataIn;
		end if ;
	end if ;
end process ; -- lecture

end architecture behavioural;

