library verilog;
use verilog.vl_types.all;
entity ram_96 is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        Write_WE        : in     vl_logic;
        clk             : in     vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end ram_96;
