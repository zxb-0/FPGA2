module final_top(
		clk            ,
		rst_n          ,
		key            ,
		key_5          ,
		adc_din        ,
		adc_clk        ,
		vga_hys        ,
		vga_vys        ,
		vga_rgb        ,
		key_multiwave	,
		dac_mode		,
		dac_clka		,
		dac_da		,
		dac_wra		,
		dac_sleep	
	);
input	          clk            ;
input	          rst_n          ;
input  [3:0] 	 key            ;
input           key_5          ;
input  [7:0]  	 adc_din        ;
input	 [2:0]	 key_multiwave	 ;

output	       adc_clk        ;
output	       vga_hys        ;
output	       vga_vys        ;
output [15:0] 	 vga_rgb        ;

output					dac_mode	 ;
output					dac_clka	 ;
output [8-1 : 0]		dac_da	 ;
output					dac_wra	 ;
output					dac_sleep ;
	
wire	          clk            ;
wire	          rst_n          ;
wire 	          vga_hys        ;
wire 	          vga_vys        ;
wire   [15:0] 	 vga_rgb        ;	
wire   [3:0]  	 key            ;
wire            key_5          ;
wire	 [7:0]			dac_da		;
wire						dac_sleep	;
wire						dac_wra		;
wire						dac_clka		;
wire						dac_mode		;
wire		[2:0]			key_multiwave;


Oscill_main_top Oscill_main_top(
		.clk            (clk ),      
		.rst_n          (rst_n),                  
		.key            (key),
		.key_5          (key_5 ),
		.adc_din        (adc_din),
		.adc_clk        (adc_clk),
		.vga_hys        (vga_hys),
		.vga_vys        (vga_vys ),
		.vga_rgb        (vga_rgb)
);
multiwave multiwave(
		.clk			(clk),
		.rst_n		(rst_n),
		.key_multiwave			(key_multiwave),
		.dac_mode	(dac_mode),
		.dac_clka	(dac_clka),
		.dac_da		(dac_da),
		.dac_wra		(dac_wra),
		.dac_sleep	(dac_sleep)
		
);
endmodule
