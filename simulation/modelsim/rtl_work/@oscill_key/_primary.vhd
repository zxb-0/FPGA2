library verilog;
use verilog.vl_types.all;
entity Oscill_key is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_in          : in     vl_logic_vector(3 downto 0);
        key_5           : in     vl_logic;
        key1_l2h        : out    vl_logic;
        key2_l2h        : out    vl_logic;
        key3_l2h        : out    vl_logic;
        key4_l2h        : out    vl_logic;
        key5_l2h        : out    vl_logic
    );
end Oscill_key;
