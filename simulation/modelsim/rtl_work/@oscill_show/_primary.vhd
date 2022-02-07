library verilog;
use verilog.vl_types.all;
entity Oscill_show is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        show_en         : in     vl_logic;
        show_addr       : in     vl_logic_vector(15 downto 0);
        show_wide       : in     vl_logic_vector(7 downto 0);
        show_sel        : in     vl_logic_vector(1 downto 0);
        ram_raddr       : out    vl_logic_vector(15 downto 0);
        ram_rdata       : in     vl_logic_vector(7 downto 0);
        vga_x           : in     vl_logic_vector(10 downto 0);
        vga_y           : in     vl_logic_vector(10 downto 0);
        vga_data        : out    vl_logic_vector(15 downto 0);
        vga_en          : out    vl_logic;
        sel_data_in     : in     vl_logic_vector(7 downto 0);
        vga_rdy         : in     vl_logic;
        result_out      : in     vl_logic;
        i               : in     vl_logic_vector(2 downto 0)
    );
end Oscill_show;
