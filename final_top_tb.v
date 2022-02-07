`timescale 1ns / 1ps
module final_top_tb;
`define clk_period 20

	reg			clk			;
	reg			rst_n			;
	wire 	          vga_hys        ;
	wire 	          vga_vys        ;
	wire  [15:0] 	 vga_rgb        ;	
	reg  [3:0]  	 key            ;
	reg  	[2:0]		key_multiwave			;
	wire  [7:0]				dac_da		;
	wire						dac_sleep	;
	wire						dac_wra		;
	wire						dac_clka		;
	wire						dac_mode		;
	wire	[7:0]				adc_din		;

final_top final_top(
		.clk            (clk	),
		.rst_n          (rst_n ),
		.key            (key),
		.key_5          (),
		.adc_din        (adc_din),
		.adc_clk        (adc_clk),
		.vga_hys        (vga_hys),
		.vga_vys        (vga_vys),
		.vga_rgb        (vga_rgb),
		.key_multiwave	 (key_multiwave),
		.dac_mode		 (dac_mode),
		.dac_clka		 (dac_clka),
		.dac_da			 (dac_da),
		.dac_wra			 (dac_wra),
		.dac_sleep		 (dac_sleep)
	);



initial begin
	clk = 0;
	forever#(`clk_period/2)begin
		clk = ~clk			;
	end
end

initial begin 
			#(`clk_period);
			rst_n = 0;
			#(`clk_period*10);
			rst_n = 1;
				key=0;
			#(`clk_period*1000);
				key=1;
			#(`clk_period);
				key=0;
			key_multiwave = 1;
			#(`clk_period*256);
			key_multiwave = 2;
			#(`clk_period*256);
			key_multiwave = 3;
			#(`clk_period*256);
			key_multiwave = 4;
			#(`clk_period*256);

end
assign adc_din = dac_da ;

endmodule