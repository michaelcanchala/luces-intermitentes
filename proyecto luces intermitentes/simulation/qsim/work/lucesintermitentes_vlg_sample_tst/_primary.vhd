library verilog;
use verilog.vl_types.all;
entity lucesintermitentes_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        SD              : in     vl_logic;
        SI              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end lucesintermitentes_vlg_sample_tst;
