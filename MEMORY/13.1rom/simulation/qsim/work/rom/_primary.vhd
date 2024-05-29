library verilog;
use verilog.vl_types.all;
entity rom is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0);
        clock           : in     vl_logic
    );
end rom;
