LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY output_ports IS
    PORT (
        clock       : IN  std_logic;
        reset       : IN  std_logic;
        address     : IN  std_logic_vector(7 DOWNTO 0);
        write       : IN  std_logic;
        data_in     : IN  std_logic_vector(7 DOWNTO 0);
        port_out_00 : OUT std_logic_vector(7 DOWNTO 0);
        port_out_01 : OUT std_logic_vector(7 DOWNTO 0)
    );
END output_ports;

ARCHITECTURE output_ports_ARCH OF output_ports IS
BEGIN
   
    process_00 : PROCESS(clock, reset)
    BEGIN
        IF reset = '0' THEN
            port_out_00 <= x"00";
        ELSIF rising_edge(clock) THEN
            IF address = x"E0" AND write = '1' THEN
                port_out_00 <= data_in;
            END IF;
        END IF;
    END PROCESS process_00;

    
    process_01 : PROCESS(clock, reset)
    BEGIN
        IF reset = '0' THEN
            port_out_01 <= x"00";
        ELSIF rising_edge(clock) THEN
            IF address = x"E1" AND write = '1' THEN
                port_out_01 <= data_in;
            END IF;
        END IF;
    END PROCESS process_01;

END ARCHITECTURE;
