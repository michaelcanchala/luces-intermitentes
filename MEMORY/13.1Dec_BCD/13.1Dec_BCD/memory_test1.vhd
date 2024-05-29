LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory_test1 IS
    PORT (
        clock      : IN  std_logic;
        reset      : IN  std_logic;
        address    : IN  std_logic_vector(7 DOWNTO 0);
        write      : IN  std_logic;
        data_in    : IN  std_logic_vector(7 DOWNTO 0);
        display1   : OUT std_logic_vector(6 DOWNTO 0);
        display2   : OUT std_logic_vector(6 DOWNTO 0);
        display3   : OUT std_logic_vector(6 DOWNTO 0);
        display4   : OUT std_logic_vector(6 DOWNTO 0)
    );
END memory_test1;

ARCHITECTURE Behavioral OF memory_test1 IS

    -- Declaración del componente memory1
    COMPONENT memory1
        PORT (
            clock       : IN  std_logic;
            reset       : IN  std_logic;
            address     : IN  std_logic_vector(7 DOWNTO 0);
            write       : IN  std_logic;
            data_in     : IN  std_logic_vector(7 DOWNTO 0);
            data_out    : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Declaración del componente Dec_BCD
    COMPONENT Dec_BCD
        PORT (
            numero     : IN  std_logic_vector(3 DOWNTO 0);
            segmentos  : OUT std_logic_vector(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL data_out_mem : std_logic_vector(7 DOWNTO 0);
    SIGNAL bcd_signals  : std_logic_vector(15 DOWNTO 0);

BEGIN
    -- Instancia del componente memory1
    memory1_inst : memory1
        PORT MAP (
            clock    => clock,
            reset    => reset,
            address  => address,
            write    => write,
            data_in  => data_in,
            data_out => data_out_mem
        );

    -- Extender data_out_mem a 16 bits
    bcd_signals <= "0000" & data_out_mem; -- Aquí se agregan 4 ceros delante de data_out_mem para formar un vector de 16 bits

    -- Instancia del componente Dec_BCD para display1
    Dec_BCD_inst1 : Dec_BCD
        PORT MAP (
            numero    => bcd_signals(15 DOWNTO 12),
            segmentos => display1
        );

    -- Instancia del componente Dec_BCD para display2
    Dec_BCD_inst2 : Dec_BCD
        PORT MAP (
            numero    => bcd_signals(11 DOWNTO 8),
            segmentos => display2
        );

    -- Instancia del componente Dec_BCD para display3
    Dec_BCD_inst3 : Dec_BCD
        PORT MAP (
            numero    => bcd_signals(7 DOWNTO 4),
            segmentos => display3
        );

    -- Instancia del componente Dec_BCD para display4
    Dec_BCD_inst4 : Dec_BCD
        PORT MAP (
            numero    => bcd_signals(3 DOWNTO 0),
            segmentos => display4
        );

END Behavioral;
