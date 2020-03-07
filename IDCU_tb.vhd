library IEEE;
use IEEE.Std_logic_1164.all;

entity IDCU_tb is
end entity IDCU_tb;

architecture test_bench of IDCU_tb is

SIGNAL PSR   : std_logic_vector(31 downto 0);  
SIGNAL INSTR : std_logic_vector(31 downto 0);  
SIGNAL nPCsel: std_logic;                      
SIGNAL RegWr : std_logic;                      
SIGNAL RegSel: std_logic;                      
SIGNAL AluSrc: std_logic;                      
SIGNAL AluCtr: std_logic_vector(1 downto 0);   
SIGNAL PSRen : std_logic;                      
SIGNAL MemWr : std_logic;                      
SIGNAL WrSrc : std_logic;                       

begin
	uut  : entity work.IDCU(behavioural) port map( PSR    => PSR    , 
												   INSTR  => INSTR  , 
												   nPCsel => nPCsel , 
												   RegWr  => RegWr  , 
												   RegSel => RegSel , 
												   AluSrc => AluSrc , 
												   AluCtr => AluCtr , 
												   PSRen  => PSRen  , 
												   MemWr  => MemWr  , 
												   WrSrc  => WrSrc  );
	sigGen : process
	begin
		-- INIT
		PSR    <= (others => '0');
		INSTR  <= (others => '0');
		wait for 10 ns;	

		-- TEST INSTRUCTION INCONNUE (must return MOV values)

		PSR    <= (others => '0');
		INSTR  <= X"FFF55555";
		wait for 10 ns;

		-- TEST MOV : MOV R1, #0x20

		PSR    <= (others => '0');
		INSTR  <= B"1110001110100000_0001_0000_00010100"; --syntax : MOVSpecificValues_RD_rot_IMM
		wait for 10 ns;

		-- TEST ADDi : ADD R1, R1, #1

		PSR    <= (others => '0');
		INSTR  <= B"1110_00_1_0100_0_0001_0001_0000_00000001"; --cond_00_imm_opcode_0_RN_RD_rot_IMM
		wait for 10 ns;

		-- TEST ADDr : ADD R2, R2, R0

		PSR    <= (others => '0');
		INSTR  <= B"1110_00_0_0100_0_0010_0010_00000000_0000"; --cond_00_imm_opcode_0_RN_RD_shift_RM
		wait for 10 ns;

		-- TEST CMP : CMP R1, 0x2A

		PSR    <= (others => '0'); --flag inititalement a 0
		INSTR  <= B"1110_00_1_1010_1_0001_0000_0000_00101010"; --cond_00_imm_opcode_0_RN_0000_rot_IMM
		wait for 10 ns;

		-- TEST LDR : LDR R0, 0(R1)

		PSR    <= (others => '0');
		INSTR  <= B"1110_00_1_0100_0_0001_0001_0000_00000001"; --cond_01_imm_PUBW_load/store_RN_RD_rot_IMM
		wait for 10 ns;

		-- TEST STR : STR R2; 0(R1)

		PSR    <= (others => '0');
		INSTR  <= X"FFF55555"; --cond_01_imm_PUBW_load/store_RN_RD_rot_IMM
		wait for 10 ns;

		-- TEST BAL : BAL main (offset -8 => BAL #-8)

		PSR    <= (others => '0');
		INSTR  <= B"1110_101_0_111111111111111111111000"; --cond_101_link_offset
		wait for 10 ns;

		-- TEST BLT flag : BLT loop (offset -4 => BLT #-4)

		PSR    <= X"00000001"; --flag a 1 pour autoriser le branchement
		INSTR  <= B"1011_101_0_111111111111111111111100"; --cond_101_link_offset
		wait for 10 ns;

		-- TEST BLT no flag : BLT loop (offset -4 => BLT #-4)

		PSR    <= X"00000000"; --flag a 0 pas de branchement
		INSTR  <= B"1011_101_0_111111111111111111111100"; --cond_101_link_offset
		wait for 10 ns;

		wait;

	end process ; -- test


end architecture test_bench;