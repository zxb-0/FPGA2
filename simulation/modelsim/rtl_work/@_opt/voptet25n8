library verilog;
use verilog.vl_types.all;
entity Oscill_vga_driver is
    generic(
        SHOW_X_B        : integer := 144;
        SHOW_X_E        : integer := 784;
        SHOW_Y_B        : integer := 35;
        SHOW_Y_E        : integer := 515;
        TIME_HYS        : integer := 800;
        TIME_VYS        : integer := 525
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        din_en          : in     vl_logic;
        din             : in     vl_logic_vector(15 downto 0);
        vga_hys         : out    vl_logic;
        vga_vys         : out    vl_logic;
        vga_rgb         : out    vl_logic_vector(15 downto 0);
        vga_x           : out    vl_logic_vector(10 downto 0);
        vga_y           : out    vl_logic_vector(10 downto 0);
        vga_rdy         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SHOW_X_B : constant is 1;
    attribute mti_svvh_generic_type of SHOW_X_E : constant is 1;
    attribute mti_svvh_generic_type of SHOW_Y_B : constant is 1;
    attribute mti_svvh_generic_type of SHOW_Y_E : constant is 1;
    attribute mti_svvh_generic_type of TIME_HYS : constant is 1;
    attribute mti_svvh_generic_type of TIME_VYS : constant is 1;
end Oscill_vga_driver;
