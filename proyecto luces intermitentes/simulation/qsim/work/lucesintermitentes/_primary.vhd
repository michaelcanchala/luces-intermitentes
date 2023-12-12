library verilog;
use verilog.vl_types.all;
entity lucesintermitentes is
    port(
        LI              : out    vl_logic;
        CLK             : in     vl_logic;
        SD              : in     vl_logic;
        SI              : in     vl_logic;
        LD              : out    vl_logic
    );
end lucesintermitentes;
