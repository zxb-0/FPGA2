library verilog;
use verilog.vl_types.all;
entity Oscill_sel is
    port(
        rst_n           : in     vl_logic;
        clk_adc         : in     vl_logic;
        clk             : in     vl_logic;
        adc_data_in     : in     vl_logic_vector(7 downto 0);
        sel_data_in     : in     vl_logic_vector(7 downto 0);
        sel             : in     vl_logic;
        sel_result      : out    vl_logic
    );
end Oscill_sel;
