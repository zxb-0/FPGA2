library verilog;
use verilog.vl_types.all;
entity Oscill_ram is
    port(
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(7 downto 0);
        rdaddress       : in     vl_logic_vector(12 downto 0);
        wraddress       : in     vl_logic_vector(12 downto 0);
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(7 downto 0)
    );
end Oscill_ram;
