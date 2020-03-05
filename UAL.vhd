library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity UAL is
    port (
        OP  : IN  std_logic_vector(1 downto 0);
        A, B: IN  std_logic_vector(31 downto 0);
        S   : OUT std_logic_vector(31 downto 0);
        N   : OUT std_logic
    );
end entity UAL;

architecture behavioural of UAL is
signal sortie : std_logic_vector(31 downto 0);
begin

with OP select sortie <=
    std_logic_vector(to_signed(to_integer(signed(A)) + to_integer(signed(B)), 32)) when "00",
    B when "01",
    std_logic_vector(to_signed(to_integer(signed(A)) - to_integer(signed(B)), 32)) when "10",
    A when others;

N <= sortie(31);
S <= sortie;
    
end architecture behavioural;