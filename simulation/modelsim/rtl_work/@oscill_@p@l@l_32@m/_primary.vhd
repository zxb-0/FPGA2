library verilog;
use verilog.vl_types.all;
entity Oscill_PLL_32M is
    port(
        inclk0          : in     vl_logic;
        c0              : out    vl_logic;
        c1              : out    vl_logic
    );
end Oscill_PLL_32M;
