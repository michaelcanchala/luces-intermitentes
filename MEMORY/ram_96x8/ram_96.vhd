library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_96 is
    port (
        address   : in  std_logic_vector(7 downto 0);
        data_in   : in  std_logic_vector(7 downto 0);
        Write_WE  : in  std_logic;
        clk       : in  std_logic;
        data_out  : out std_logic_vector(7 downto 0)
    );
end ram_96;

architecture ram_96_arch of ram_96 is
    type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
    signal RW : rw_type;

    -- Internal Enable Signal
    signal EN : std_logic;
begin
    enable : process (address)
    begin
        if (to_integer(unsigned(address)) >= 128 and to_integer(unsigned(address)) <= 223) then
            EN <= '1';
        else
            EN <= '0';
        end if;
    end process;

    memory : process (clk)
    begin
        if rising_edge(clk) then
            if EN = '1' then
                if Write_WE = '1' then
                    RW(to_integer(unsigned(address))) <= data_in;
                else
                    data_out <= RW(to_integer(unsigned(address)));
                end if;
            end if;
        end if;
    end process;

end architecture;