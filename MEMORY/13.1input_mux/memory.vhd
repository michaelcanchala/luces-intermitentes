LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory IS
    PORT (
        clock       : IN  std_logic;
        reset       : IN  std_logic;
        address     : IN  std_logic_vector(7 DOWNTO 0);
        write       : IN  std_logic;
        data_in     : IN  std_logic_vector(7 DOWNTO 0);
        data_out    : OUT std_logic_vector(7 DOWNTO 0)
    );
END memory;

ARCHITECTURE Behavioral OF memory IS

    -- Declaración de los componentes dentro de la arquitectura
    COMPONENT rom
        PORT (
            address  : IN  std_logic_vector(7 DOWNTO 0);
            data_out : OUT std_logic_vector(7 DOWNTO 0);
            clock    : IN  std_logic
        );
    END COMPONENT;

    COMPONENT ram_96
        PORT (
            address   : IN  std_logic_vector(7 DOWNTO 0);
            data_in   : IN  std_logic_vector(7 DOWNTO 0);
            Write_WE  : IN  std_logic;
            clk       : IN  std_logic;
            data_out  : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT output_ports
        PORT (
            clock       : IN  std_logic;
            reset       : IN  std_logic;
            address     : IN  std_logic_vector(7 DOWNTO 0);
            write       : IN  std_logic;
            data_in     : IN  std_logic_vector(7 DOWNTO 0);
            port_out_00 : OUT std_logic_vector(7 DOWNTO 0);
            port_out_01 : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT input_mux
        PORT (
            address      : IN  std_logic_vector(7 DOWNTO 0);
            rom_data_out : IN  std_logic_vector(7 DOWNTO 0);
            ram_data_out : IN  std_logic_vector(7 DOWNTO 0);
            port_in_00   : IN  std_logic_vector(7 DOWNTO 0);
            port_in_01   : IN  std_logic_vector(7 DOWNTO 0);
            data_out     : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL rom_data_out : std_logic_vector(7 DOWNTO 0);
    SIGNAL ram_data_out : std_logic_vector(7 DOWNTO 0);
    SIGNAL port_out_00  : std_logic_vector(7 DOWNTO 0);
    SIGNAL port_out_01  : std_logic_vector(7 DOWNTO 0);

BEGIN
    -- Instancia del componente ROM
    ROM_inst : rom
        PORT MAP (
            address  => address,
            data_out => rom_data_out,
            clock    => clock
        );

    -- Instancia del componente RAM
    RAM_inst : ram_96
        PORT MAP (
            address   => address,
            data_in   => data_in,
            Write_WE  => write,
            clk       => clock,
            data_out  => ram_data_out
        );

    -- Instancia del componente de puertos de salida
    output_ports_inst : output_ports
        PORT MAP (
            clock       => clock,
            reset       => reset,
            address     => address,
            write       => write,
            data_in     => data_in,
            port_out_00 => port_out_00,
            port_out_01 => port_out_01
        );

    -- Instancia del multiplexor de entrada
    input_mux_inst : input_mux
        PORT MAP (
            address      => address,
            rom_data_out => rom_data_out,
            ram_data_out => ram_data_out,
            port_in_00   => port_out_00,
            port_in_01   => port_out_01,
            data_out     => data_out
        );

END Behavioral;
