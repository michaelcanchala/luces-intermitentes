LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
    PORT (
        address   : IN  std_logic_vector(7 DOWNTO 0);
        data_out  : OUT std_logic_vector(7 DOWNTO 0);
        clock     : IN  std_logic
    );
END rom;

ARCHITECTURE rom_ARCH OF rom IS
    
    CONSTANT LDA_IMM : std_logic_vector(7 DOWNTO 0) := x"86";
    CONSTANT LDA_DIR : std_logic_vector(7 DOWNTO 0) := x"87";
    CONSTANT LDB_IMM : std_logic_vector(7 DOWNTO 0) := x"88";
    CONSTANT LDB_DIR : std_logic_vector(7 DOWNTO 0) := x"89";
    CONSTANT STA_DIR : std_logic_vector(7 DOWNTO 0) := x"96";
    CONSTANT STB_DIR : std_logic_vector(7 DOWNTO 0) := x"97";
    CONSTANT ADD_AB  : std_logic_vector(7 DOWNTO 0) := x"42";
    CONSTANT SUB_AB  : std_logic_vector(7 DOWNTO 0) := x"43";
    CONSTANT AND_AB  : std_logic_vector(7 DOWNTO 0) := x"44";
    CONSTANT OR_AB   : std_logic_vector(7 DOWNTO 0) := x"45";
    CONSTANT INCA    : std_logic_vector(7 DOWNTO 0) := x"46";
    CONSTANT INCB    : std_logic_vector(7 DOWNTO 0) := x"47";
    CONSTANT DECA    : std_logic_vector(7 DOWNTO 0) := x"48";
    CONSTANT DECB    : std_logic_vector(7 DOWNTO 0) := x"49";
    CONSTANT BRA     : std_logic_vector(7 DOWNTO 0) := x"20";
    CONSTANT BMI     : std_logic_vector(7 DOWNTO 0) := x"21";
    CONSTANT BPL     : std_logic_vector(7 DOWNTO 0) := x"22";
    CONSTANT BEQ     : std_logic_vector(7 DOWNTO 0) := x"23";
    CONSTANT BNE     : std_logic_vector(7 DOWNTO 0) := x"24";
    CONSTANT BVS     : std_logic_vector(7 DOWNTO 0) := x"25";
    CONSTANT BVC     : std_logic_vector(7 DOWNTO 0) := x"26";
    CONSTANT BCS     : std_logic_vector(7 DOWNTO 0) := x"27";
    CONSTANT BCC     : std_logic_vector(7 DOWNTO 0) := x"28";

    TYPE rom_type IS ARRAY (0 TO 127) OF std_logic_vector(7 DOWNTO 0);

  
    CONSTANT ROM : rom_type := (
        0 => LDA_IMM,
        1 => x"AA",
        2 => STA_DIR,
        3 => x"E0",
        4 => BRA,
        5 => x"00",
        OTHERS => x"00"
    );
BEGIN
   
    memory : PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF to_integer(unsigned(address)) >= 0 AND to_integer(unsigned(address)) <= 127 THEN
                data_out <= ROM(to_integer(unsigned(address)));
            ELSE
                data_out <= (OTHERS => '0');  -- Si la dirección no es válida, se devuelve 0
            END IF;
        END IF;
    END PROCESS memory;
END ARCHITECTURE;