library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity IDCU is
    port (
        PSR   : IN  std_logic_vector(31 downto 0);
        INSTR : IN  std_logic_vector(31 downto 0);
        nPCsel: OUT std_logic;
        RegWr : OUT std_logic;
        RegSel: OUT std_logic;
        AluSrc: OUT std_logic;
        AluCtr: OUT std_logic_vector(1 downto 0);
        PSRen : OUT std_logic;
        MemWr : OUT std_logic;
        WrSrc : OUT std_logic
    );
end entity IDCU;

architecture behavioural of IDCU is

type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);

signal instr_cour : enum_instruction;

begin

    --decodeur d'instruction
    defInstrCour : process( instr )
    begin
        --assignation par defaut
        instr_cour <= MOV;

        if    (instr(27 downto 26) = "00") then  -- ADD, MOV, CMP

            if instr(24 downto 21) = "1101" then     -- MOV
                instr_cour <= MOV;

            elsif instr(24 downto 21) = "0100" then -- ADD

                --immediat
                if instr(25) = '1' then
                    instr_cour <= ADDi;              -- ADDi
                elsif instr(25) = '0' then
                    instr_cour <= ADDr;              -- ADDR
                end if ;

            --CMP
            elsif instr(24 downto 21) = "1010" then  -- CMP
                instr_cour <= CMP;
            end if;

        elsif (instr(27 downto 26) = "01") then  -- LDR, STR

            --load ou store
            if instr(20) = '1' then
                instr_cour <= LDR;                   --LDR
            elsif instr(20) = '0' then
                instr_cour <= STR;                   --STR
            end if ;

        elsif (instr(27 downto 26) = "10") then        -- BLT, B

            --branch "always" ou "if less than"
            if instr(31 downto 28) = "1110" then     -- condition field to always
                instr_cour <= BAL;
            elsif instr(31 downto 28) = "1011" then
                instr_cour <= BLT;
            end if ;

        end if;

    end process ; -- defInstrCour

    --unite de controle
    commandGen : process( instr_cour, PSR )
    begin
        nPCsel <= '-';
        RegWr <= '-';
        RegSel <= '-';
        AluSrc <= '-';
        AluCtr <= (others => '-');
        PSRen <= '-';
        MemWr <= '-';
        WrSrc <= '-';

        --nPCsel : 1=offset pc -> branch
        if instr_cour = BAL then
            nPCsel <= '1';
        elsif instr_cour = BLT then
            nPCsel <= PSR(0);
        else
            nPCsel <= '0';
        end if ;

        --RegWr : ecrire dans Rd
        if instr_cour = ADDi
            or instr_cour = ADDr
            or instr_cour = LDR
            or instr_cour = MOV then

            RegWr <= '1';
        else
            RegWr <= '0';
        end if ;

        --AluSrc : toujours immediat (ou offset) sauf pour ADDr
        if instr_cour = ADDr then
            AluSrc <= '0';
        else
            AluSrc <= '1';
        end if ;

        --AluCtr
        if instr_cour = ADDi
            or instr_cour = ADDr 
            or instr_cour = LDR 
            or instr_cour = STR then

            AluCtr <= "00"; --ADD
        elsif instr_cour = CMP then
            AluCtr <= "10"; --SUB
        elsif instr_cour = MOV then
            AluCtr <= "01"; --B            
        end if ;

        --PSRen : 1 si BLT(si resultat de CMP negatif=>flag) ou CMP(memoriser flag)
        if instr_cour = BLT or instr_cour = CMP then
            PSRen <= '1';
        else
            PSRen <= '0';
        end if ;

        --MemWr : ecriture memoire que lors d'un "store"
        if instr_cour = STR then
            MemWr <= '1';
        else
            MemWr <= '0';
        end if ;

        --WrSrc : lecture memoire que lors d'un "load" ou d'un "store"
        if instr_cour = LDR or instr_cour = STR then
            WrSrc <= '1';
        else
            WrSrc <= '0';
        end if ;

        --RegSel : pas tres important sauf pour ADDr (on a besoin de Rm)
        if instr_cour = ADDr then
            RegSel <= '0';
        else
            RegSel <= '1';
        end if ;

    end process ; -- commandGen
    
end architecture;