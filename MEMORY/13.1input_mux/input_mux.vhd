LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY input_mux IS
    PORT (
        address     : IN  std_logic_vector(7 DOWNTO 0);
        rom_data_out : IN  std_logic_vector(7 DOWNTO 0);
        ram_data_out : IN  std_logic_vector(7 DOWNTO 0);
        port_in_00  : IN  std_logic_vector(7 DOWNTO 0);
        port_in_01  : IN  std_logic_vector(7 DOWNTO 0);
        data_out    : OUT std_logic_vector(7 DOWNTO 0)
    );
END input_mux;

ARCHITECTURE input_mux_ARCH OF input_mux IS
BEGIN
    MUX1 : PROCESS (address, rom_data_out, ram_data_out, 
                    port_in_00, port_in_01)
    BEGIN
        IF (to_integer(unsigned(address)) >= 0 AND 
            to_integer(unsigned(address)) <= 127) THEN
            data_out <= rom_data_out;
        ELSIF (to_integer(unsigned(address)) >= 128 AND 
               to_integer(unsigned(address)) <= 223) THEN
            data_out <= ram_data_out;
        ELSIF (address = x"F0") THEN
            data_out <= port_in_00;
        ELSIF (address = x"F1") THEN
            data_out <= port_in_01;
        ELSE
            data_out <= (OTHERS => '0');
        END IF;
    END PROCESS MUX1;
END ARCHITECTURE;
