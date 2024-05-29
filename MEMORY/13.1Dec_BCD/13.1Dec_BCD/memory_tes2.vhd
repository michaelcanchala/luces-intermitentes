LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory_tes2 IS
    PORT (
        clock       : IN  std_logic;
        reset       : IN  std_logic;
        address     : IN  std_logic_vector(7 DOWNTO 0);
        write       : IN  std_logic;
        data_in     : IN  std_logic_vector(7 DOWNTO 0);
        data_out    : OUT std_logic_vector(7 DOWNTO 0);
        segmentos_0 : OUT std_logic_vector(6 DOWNTO 0); 
        segmentos_1 : OUT std_logic_vector(6 DOWNTO 0);
        segmentos_2 : OUT std_logic_vector(6 DOWNTO 0); 
        segmentos_3 : OUT std_logic_vector(6 DOWNTO 0)  
    );
END memory_tes2;

ARCHITECTURE memory_tes2_ARCH OF memory_tes2 IS

    COMPONENT memory1 IS
        PORT (
            clock       : IN  std_logic;
            reset       : IN  std_logic;
            address     : IN  std_logic_vector(7 DOWNTO 0);
            write       : IN  std_logic;
            data_in     : IN  std_logic_vector(7 DOWNTO 0);
            data_out    : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Dec_BCD IS
        PORT (
            numero    : IN std_logic_vector(3 DOWNTO 0);
            segmentos : OUT std_logic_vector(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL memory_data_out : std_logic_vector(7 DOWNTO 0);
    SIGNAL bcd_input_0     : std_logic_vector(3 DOWNTO 0);
    SIGNAL bcd_input_1     : std_logic_vector(3 DOWNTO 0);
    SIGNAL bcd_input_2     : std_logic_vector(3 DOWNTO 0);
    SIGNAL bcd_input_3     : std_logic_vector(3 DOWNTO 0);
    SIGNAL segmentos_int_0 : std_logic_vector(6 DOWNTO 0);
    SIGNAL segmentos_int_1 : std_logic_vector(6 DOWNTO 0);
    SIGNAL segmentos_int_2 : std_logic_vector(6 DOWNTO 0);
    SIGNAL segmentos_int_3 : std_logic_vector(6 DOWNTO 0);

BEGIN

    memory1_inst : memory1
        PORT MAP (
            clock       => clock,
            reset       => reset,
            address     => address,
            write       => write,
            data_in     => data_in,
            data_out    => memory_data_out
        );

    Dec_BCD_0_inst : Dec_BCD
        PORT MAP (
            numero    => bcd_input_0,
            segmentos => segmentos_int_0
        );

    Dec_BCD_1_inst : Dec_BCD
        PORT MAP (
            numero    => bcd_input_1,
            segmentos => segmentos_int_1
        );

    Dec_BCD_2_inst : Dec_BCD
        PORT MAP (
            numero    => bcd_input_2,
            segmentos => segmentos_int_2
        );

    Dec_BCD_3_inst : Dec_BCD
        PORT MAP (
            numero    => bcd_input_3,
            segmentos => segmentos_int_3
        );

    segmentos_0 <= segmentos_int_0;
    segmentos_1 <= segmentos_int_1;
    segmentos_2 <= segmentos_int_2;
    segmentos_3 <= segmentos_int_3;

    bcd_input_0 <= memory_data_out(3 DOWNTO 0);  
    bcd_input_1 <= memory_data_out(7 DOWNTO 4);  
    bcd_input_2 <= "0000";  
    bcd_input_3 <= "0000";  
END ARCHITECTURE;
