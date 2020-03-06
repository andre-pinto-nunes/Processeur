library IEEE;
use IEEE.Std_logic_1164.all;

entity REGCOM is
    port (
        DATAIN : IN  std_logic_vector(31 downto 0) ;
        RST    : IN  std_logic;
        CLK    : IN  std_logic;
        WE     : IN  std_logic;
        DATAOUT: OUT std_logic_vector(31 downto 0) 
    );
end entity REGCOM;

architecture behavioural of REGCOM is

SIGNAL MEM : std_logic_vector(31 downto 0);

begin

process( CLK, RST )
begin
    if (RST = '1') then
        DATAOUT <= X"00000000";
    else
        if (rising_edge(CLK)) then
            if (WE = '1') then
                MEM <= DATAIN;
            else
                MEM <= MEM;
            end if;
        end if;
    end if;
end process ;
end architecture behavioural;