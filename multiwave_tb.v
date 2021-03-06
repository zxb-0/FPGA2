/*
`timescale 1ns/1ns

`define clk_period 20

module multiwave_tb;
	reg			clk			;
	reg			rst_n			;
	reg [2:0]	key		;
	wire[7:0]	dac_da	;
	wire			dac_clka	;
	wire			dac_wra	;
	wire			dac_sleep;
	wire			dac_mode	;
	wire [7:0]	q			;
multiwave_top multiwave_top(
		.clk				(clk	),
		.rst_n			(rst_n),
		.key				(key	),
		.q					(q)	,
		.dac_mode		(dac_mode),
		.dac_clka		(dac_clka),
		.dac_da			(dac_da),
		.dac_wra			(dac_wra),
		.dac_sleep		(dac_sleep)
		
);
	
	initial begin
		clk = 0;
		forever #(`clk_period/2)
		begin
			clk = ~clk;
		end
	end
		initial begin 
			#(`clk_period);
			rst_n = 0;
			#(`clk_period*10);
			rst_n = 1;
			key = 1;
			#(`clk_period*256);
			key = 2;
			#(`clk_period*256);
			key = 3;
			#(`clk_period*256);
			key = 4;
			#(`clk_period*256);
			$stop;
	end
endmodule
*/
`timescale 1ns / 1ps
module multiwave_tb;
`define clk_period 20

	reg			clk			;
	reg			rst_n			;
	reg  	[2:0]	key			;
	wire  [7:0]				dac_da		;
	wire						dac_sleep	;
	wire						dac_wra		;
	wire						dac_clka		;
	wire						dac_mode		;

/*multiwave_top  multiwave_top(
		.clk			(clk		),
		.rst_n		(rst_n	),
		.key			(key		),

		.dac_mode	(dac_mode),
		.dac_clka	(dac_clka),
		.dac_da		(dac_da	),
		.dac_wra		(dac_wra	),
		.dac_sleep	(dac_sleep),
		
		.ad_clk		(ad_clk	),
		.ad_in		(ad_in	)		
		
		
);*/

multiwave multiwave(
		.clk				(clk		),
		.rst_n			(rst_n	),
		.key				(key		),
		.dac_mode		(dac_mode),
		.dac_clka		(dac_clka),
		.dac_da			(dac_da	),
		.dac_wra			(dac_wra	),
		.dac_sleep		(dac_sleep)
		
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
			key = 1;
			#(`clk_period*256);
			key = 2;
			#(`clk_period*256);
			key = 3;
			#(`clk_period*256);
			key = 4;
			#(`clk_period*256);
			$stop;
end

endmodule
