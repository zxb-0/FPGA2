library verilog;
use verilog.vl_types.all;
entity Oscill_PLL_32M_altpll1 is
    port(
        clk             : out    vl_logic_vector(4 downto 0);
        inclk           : in     vl_logic_vector(1 downto 0)
    );
end Oscill_PLL_32M_altpll1;
