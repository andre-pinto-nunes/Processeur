library IEEE;
use IEEE.Std_logic_1164.all;

entity AUT_TEST is
end entity AUT_TEST;

architecture test_bench of AUT_TEST is

SIGNAL CLK   : std_logic;
SIGNAL RST   : std_logic;
SIGNAL COM1  : std_logic;
SIGNAL COM2  : std_logic;
SIGNAL WrEn  : std_logic;
SIGNAL RegWr : std_logic;
SIGNAL Rw    : std_logic_vector(3 downto 0);
SIGNAL Ra    : std_logic_vector(3 downto 0);
SIGNAL Rb    : std_logic_vector(3 downto 0);
SIGNAL OP    : std_logic_vector(1 downto 0);
SIGNAL Imm   : std_logic_vector(7 downto 0);


begin
	AUT  : entity work.AUT(behavioural) port map( CLK, RST, COM1, COM2, WrEn, RegWr , Rw, Ra, Rb, OP, Imm);

	ClOk: process
	begin
		while now <= 200 NS loop
			CLK <= '0';
			wait for 5 NS;
			CLK <= '1';
			wait for 5 NS;
		end loop;
		wait;
	end process;

	test : process
	begin
		-- INIT
		RST    <= '1';
		OP     <= "00";
		Imm    <= "00000000";
		COM1   <= '0';
		COM2   <= '0';
		WrEn   <= '0';
		RegWr  <= '0';
		Rw     <= "0000";
		Ra     <= "0000";
		Rb     <= "0000";
		wait for 10 ns;	

		-- DEBUT ADDITION DE 2 REGISTRES $T1 = $T2 + $T3

		RST    <= '0';
		RegWr  <= '1';										 -- allow writing
		Rw     <= "0011";									 -- write address 3
		Ra     <= "0011";									 -- read  address 3
		Imm    <= "00000010";								 -- write 2
		COM1   <= '1';										 -- Imm
		OP     <= "01";										 -- copy Imm
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;		-- li $t3, 2

		Rw     <= "0010";									 -- write address 2
		Rb     <= "0010";									 -- read  address 2
		Imm    <= "00101000";								 -- write 40
		COM1   <= '1';										 -- Imm
		OP     <= "01";										 -- copy Imm
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;		-- li $t2, 2


		Rw     <= "0001";									 -- write address 1
		COM1   <= '0';										 -- busB
		OP     <= "00";										 -- somme Rb($t2) , Ra($t3)
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;

		-- add $t1, $t2, $t3
		-- T1 = 40 + 2 = 42

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN ADDITION DE 2 REGISTRES $T1 = $T2 + $T3

		--

		-- DEBUT ADDITION D'UN REGISTRE AVEC UN IMMEDIATE $T1 = $T1 + Imm

		RegWr  <= '1';										 -- allow writing
		Ra     <= "0001";									 -- read  address 1
		Rw     <= "0001";									 -- write address 1
		Imm    <= "00001000";								 -- write 8
		COM1   <= '1';										 -- Imm
		OP     <= "00";										 -- somme Ra($t1) , Imm
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;		

		-- add $t1, $t1, Imm
		-- T1 = 42 + 8 = 50

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN ADDITION D'UN REGISTRE AVEC UN IMMEDIATE $T1 = $T1 + Imm

		--

		-- DEBUT SOUSTRACTION DE 2 REGISTRES $T4 = $T2 - $T3

		RegWr  <= '1';										 -- allow writing
		Rw     <= "0100";									 -- write address 4
		Ra     <= "0010";									 -- read  address 2 (= 40)
		Rb     <= "0011";									 -- read  address 3 (=  2)
		COM1   <= '0';										 -- busB
		OP     <= "10";										 -- sub Ra($t2) , Rb($t3)
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;

		-- sub $t4, $t2, $t3
		-- T4 = 40 - 2 = 38

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN SOUSTRACTION DE 2 REGISTRES $T4 = $T2 - $T3

		--

		-- DEBUT SOUSTRACTION REGISTRE IMMEDIAT $T4 = $T4 - I

		RegWr  <= '1';										 -- allow writing
		Rw     <= "0100";									 -- write address 4
		Ra     <= "0100";									 -- read  address 4 (= 40)
		Imm    <= "00010010";								 -- 18
		COM1   <= '1';										 -- Imm
		OP     <= "10";										 -- sub Ra($t4) , Imm
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;

		-- subi $t4, $t4, 18
		-- T4 = 38 - 18 = 20

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN SOUSTRACTION REGISTRE IMMEDIAT $T4 = $T4 - I   

		--

		-- DEBUT COPIE REGISTRE $T5 = $T4

		RegWr  <= '1';										 -- allow writing
		Rw     <= "0101";									 -- write address 5
		Ra     <= "0100";									 -- read  address 4
		Rb     <= "0101";									 -- read  address 5 (juste pour voir dans la simulation)
		OP     <= "11";										 -- copy Ra($t4)
		COM2   <= '0';										 -- ALUout
		wait for 10 ns;

		-- mv $t5, $t4
		-- T5 = T4 = 20

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN COPIE REGISTRE $T5 = $T4

		--

		-- DEBUT ECRITURE D'UN REGISTRE DANS LA MEMOIRE

		RegWr  <= '0';										 -- DOOOOOOOOOOOOOn't allow writing
		WrEn   <= '1';										 -- allow writing RAM
		Ra     <= "0011";									 -- read  address 3
		Rb     <= "0100";									 -- read  address 4
		COM1   <= '1';										 -- Imm
		Imm    <= "00000011";								 -- 3
		OP     <= "00";										 -- add Ra($t3), Imm
		COM2   <= '1';										 -- RAM
		wait for 10 ns;

		-- sw $t4, Imm($t3)

		RegWr  <= '0';
		wait for 10 ns;

		-- FIN ECRITURE D'UN REGISTRE DANS LA MEMOIRE

		--

		-- DEBUT LECTURE D'UN REGISTRE DANS LA MEMOIRE

		RegWr  <= '1';										 -- allow writing
		WrEn   <= '0';										 -- don't allow writing RAM
		Rw     <= "0101";									 -- write address 3 (on met la valeur dans l'adresse lue par Ra pour etre surs que tout s'est bien passe)
		Rb     <= "0100";									 -- read  address 4
		Imm    <= "00000101";								 -- 5
		COM1   <= '1';										 -- Imm
		OP     <= "01";										 -- copy Imm
		COM2   <= '1';										 -- RAM
		wait for 10 ns;

		-- lw $t5, Imm()

		RegWr  <= '0';
		wait for 10 ns;

		Ra     <= "0101";									 -- read  address 5 (=20)
		wait for 10 ns;

		-- FIN LECTURE D'UN REGISTRE DANS LA MEMOIRE

		wait;

	end process ; -- test


end architecture test_bench;