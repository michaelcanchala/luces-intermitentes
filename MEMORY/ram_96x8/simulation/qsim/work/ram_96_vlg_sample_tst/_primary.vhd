library verilog;
use verilog.vl_types.all;
entity ram_96_vlg_sample_tst is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        Write_WE        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end ram_96_vlg_sample_tst;
