library verilog;
use verilog.vl_types.all;
entity Oscill_main is
    generic(
        TEST_LONG       : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        IDLE            : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        TRIG            : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        RAM             : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        SHOW            : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sel_data_in     : out    vl_logic_vector(7 downto 0);
        sel             : out    vl_logic;
        sel_result      : in     vl_logic;
        adc_clk_sel     : out    vl_logic_vector(4 downto 0);
        rdreq           : out    vl_logic;
        wrreq           : out    vl_logic;
        q               : in     vl_logic_vector(7 downto 0);
        rdempty         : in     vl_logic;
        wrfull          : in     vl_logic;
        rd_full         : in     vl_logic;
        rd_usedw        : in     vl_logic_vector(15 downto 0);
        key1_l2h        : in     vl_logic;
        key2_l2h        : in     vl_logic;
        key3_l2h        : in     vl_logic;
        key4_l2h        : in     vl_logic;
        key5_l2h        : in     vl_logic;
        show_en         : out    vl_logic;
        show_addr       : out    vl_logic_vector(12 downto 0);
        show_wide       : out    vl_logic_vector(7 downto 0);
        show_sel        : out    vl_logic_vector(1 downto 0);
        result_out      : out    vl_logic;
        ram_waddr       : out    vl_logic_vector(12 downto 0);
        ram_wdata       : out    vl_logic_vector(7 downto 0);
        ram_wren        : out    vl_logic;
        vga_rdy         : in     vl_logic;
        i               : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TEST_LONG : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of TRIG : constant is 1;
    attribute mti_svvh_generic_type of RAM : constant is 1;
    attribute mti_svvh_generic_type of SHOW : constant is 1;
end Oscill_main;
