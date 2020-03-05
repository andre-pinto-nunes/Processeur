library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity EXT is
	generic(
		N : positive range 1 to 31
	);

    port (
        E : IN  std_logic_vector(N downto 0);
        S : OUT std_logic_vector(31 downto 0)
    );
end entity EXT;

architecture behavioural of EXT is

begin
process(E)
begin

	if (to_integer(signed(E)) < 0) then
		S <= (others => '1');
		for i in 0 to N loop
			S(i) <= E(i);
		end loop ;
	else
		S <= (others => '0');
		for i in 0 to N loop
			S(i) <= E(i);
		end loop ;
	end if;
end process ;

end architecture behavioural;