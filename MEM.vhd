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

DataOut <= Banc(to_integer(unsigned(Addr)));

lecture : process( WrEn, Addr, CLK, DataIn )
begin
	if (WrEn = '1' and Rising_edge(CLK)) then
		Banc(to_integer(unsigned(Addr))) <= DataIn;
	else
		Banc(to_integer(unsigned(Addr))) <= Banc(to_integer(unsigned(Addr)));
	end if;
end process ; -- lecture

end architecture behavioural;

