library verilog;
use verilog.vl_types.all;
entity Oscill_main_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        key_5           : in     vl_logic;
        adc_din         : in     vl_logic_vector(7 downto 0);
        adc_clk         : out    vl_logic;
        vga_hys         : out    vl_logic;
        vga_vys         : out    vl_logic;
        vga_rgb         : out    vl_logic_vector(15 downto 0)
    );
end Oscill_main_top;
