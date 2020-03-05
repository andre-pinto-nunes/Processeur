library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity regual_tb is
end entity regual_tb;

architecture Bench of regual_tb is

signal clk,rst,regWr,com1,com2,wren,flag : std_logic;
signal op : std_logic_vector(1 downto 0);
signal ra,rb,rw : std_logic_vector(3 downto 0);
signal imm : std_logic_vector(7 downto 0) ;

begin

	clk_gen: process
    begin
		while now <= 300 NS loop
			clk <= '0';
			wait for 5 NS;
			clk <= '1';
			wait for 5 NS;
		end loop;
		wait;
    end process;
	
	sig_gen: process
	begin

--reg+reg
--reg+imm
--reg-reg
--reg-imm
--reg2 <= reg1
--mem to reg
--reg to mem

		rst <= '1';
		com1 <= '0';
		com2 <= '0';
		regWr <= '0';
		wren <= '0';
		imm <= X"00";
		rw <= X"0";
		ra <= X"F";
		rb <= X"0";
		op <= "11";
		wait for 10 ns;
		rst <= '0';
		--REG1=REG0+REG12
		ra <= X"0"; --REG0
		rb <= X"C"; --REG12
		rw <= X"1"; --REG1
		regWr <= '1';
		com1 <= '0'; --selectionne busB = REG12
		op <= "00"; --ADD
		com2 <= '0'; --aluOut pour busW
		wait for 10 ns;
		--REG2=REG7+IMM11
		ra <= X"7"; --REG7
		rb <= X"F"; --REG15 mais peu importe
		rw <= X"2"; --REG2
		imm <= X"0B"; --IMM11
		com1 <= '1'; --selectionne immediat
		op <= "00"; --ADD
		com2 <= '0'; --aluOut pour busW
		wait for 10 ns;
		--REG3=REG2-REG0
		ra <= X"2"; --REG2
		rb <= X"0"; --REG0
		com1 <= '0'; --selectionne registre
		rw <= x"3";
		op <= "10"; --SUB
		com2 <= '0'; --aluOut pour busW
		wait for 10 ns;
		--REG4=REG2-IMM7
		ra <= X"2"; --REG2
		rb <= X"F"; --REG15 mais peu importe
		rw <= X"4"; --REG4
		imm <= X"07"; --IMM7
		com1 <= '1'; --selectionne immediat
		op <= "10"; --SUB
		com2 <= '0'; --aluOut pour busW
		wait for 10 ns;
		--REG5=REG4 + ecrit REG4 dans MEM4
		ra <= X"8"; --REG8 peu importe
		rb <= X"4"; --REG4
		rw <= X"1"; --REG5
		regWr <= '1';
		wren <= '1';
		com1 <= '0'; --selectionne busB = REG4
		op <= "01"; --B
		com2 <= '0'; --aluOut pour busW
		wait for 10 ns;
		--REG12=MEM63
		ra <= X"9"; --REG9 = 0
		rb <= X"6"; --REG6 peu importe
		rw <= X"C"; --REG12
		imm <= "00111111"; --IMM63
		regWr <= '1';
		wren <= '0';
		com1 <= '1'; --selectionne IMM63
		op <= "00"; --aluOut = REG9+63 = 0+63
		com2 <= '1'; --dataOut pour busW
		wait for 10 ns;
		--MEM1=REG2
		ra <= X"1"; --REG1 Addr
		rb <= X"2"; --REG2 dataIn
		regWr <= '0';
		wren <= '1';
		com1 <= '0'; --selectionne busB = REG4
		op <= "01"; --aluOut = A
		com2 <= '1'; --dataOut pour busW
		wait for 10 ns;
		
		wait;
	
	end process;

  uut: entity work.traitement port map(clk => clk,
									 rst => rst,
									 com1 => com1,
									 regWr => regWr,
									 wren => wren,
									 com2 => com2,
									 op => op,
									 rw => rw,
									 ra => ra,
									 rb => rb,
									 imm => imm,
									 flag => flag );
end architecture;