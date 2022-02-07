library verilog;
use verilog.vl_types.all;
entity multiwave is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_multiwave   : in     vl_logic_vector(2 downto 0);
        dac_mode        : out    vl_logic;
        dac_clka        : out    vl_logic;
        dac_da          : out    vl_logic_vector(7 downto 0);
        dac_wra         : out    vl_logic;
        dac_sleep       : out    vl_logic
    );
end multiwave;
