library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traitement is
  port (
	clk, rst, com1, RegWr, WrEn, com2 : 	in std_logic;
	op : 									in std_logic_vector(1 downto 0) ;
	Rw, Ra, Rb : 							in std_logic_vector(3 downto 0) ;
	imm : 									in std_logic_vector(7 downto 0) ;
	flag : 									out std_logic
  ) ;
end entity ; -- traitement

architecture struct of traitement is

	signal busA, busB, busW, dataOut, aluOut, muxOut, extOut : std_logic_vector(31 downto 0) ;

begin

	reg : entity work.reg port map(clk => clk,
									rst => rst,
									w => busW,
									ra => Ra,
									rb => Rb,
									rw => Rw,
									we => RegWr,
									a => busA,
									b => busB);

	signext : entity work.ext 	generic map(7)
								port map(E => imm,
										 S => extOut);

	mux2A : entity work.mux2 	generic map(32)
							 	port map(A => busB,
							 		  	 B => extOut,
							 		  	 COM => com1,
							 		  	 S => muxOut);

	mux2B : entity work.mux2 	generic map(32)
								port map(A => aluOut,
							 		  	 B => dataOut,
							 		  	 COM => com2,
							 		  	 S => busW);

	ual : entity work.ual	port map(OP => op,
									 A => busA,
									 B => muxOut,
									 S => aluOut,
									 N => flag);

	datamem : entity work.mem port map (CLK => clk,
										WrEn => WrEn,
										Addr => aluOut(5 downto 0),
										DataIn => busB,
										DataOut => dataOut);


end architecture ; -- struct