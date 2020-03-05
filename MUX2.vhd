library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX2 is
	generic(
		N : positive range 1 to 32
	);

    port (
        A, B: IN  std_logic_vector(N-1 downto 0);
        COM  : IN  std_logic;
        S   : OUT std_logic_vector(N-1 downto 0)
    );
end entity MUX2;

architecture behavioural of MUX2 is

begin

with COM select S <= 
	A when '0', 
	B when others;

end architecture behavioural;