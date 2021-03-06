module multiwave(
		clk		,
		rst_n		,
		key_multiwave		,
		dac_mode		,
		dac_clka		,
		dac_da		,
		dac_wra		,
		dac_sleep	
		
);
input				clk		;
input				rst_n		;
input	 [2:0]	key_multiwave		;

output					dac_mode		;
output					dac_clka		;
output [8-1 : 0]		dac_da		;
output					dac_wra		;
output					dac_sleep	;



reg  [7:0]		addr_sin		;
reg  [7:0]		addr_juchi	;
reg  [7:0]		addr_rec		;
reg  [7:0]		addr_trig	;
wire [2:0]		key_multiwave			;			
wire [7:0]		sin_q		;
wire [7:0]		juchi_q	;
wire [7:0]		rec_q		;
wire [7:0]		trig_q	;
wire [7:0]		q			;

reg	 [7:0]			dac_da		;
wire						dac_sleep	;
wire						dac_wra		;
wire						dac_clka		;
wire						dac_mode		;
/*例化4个rom*/
my_sin mysin(
	.address			(addr_sin 	),
	.clock			(clk			),
	.q					(sin_q		)
);

my_juchi myjuchi(
	.address			(addr_juchi ),
	.clock			(clk			),
	.q					(juchi_q		)
);

my_rec myrec(
	.address			(addr_rec 	),
	.clock			(clk			),
	.q					(rec_q		)
);

my_trig mytrig(
	.address			(addr_trig 	),
	.clock			(clk			),
	.q					(trig_q		)
);


/*rom地址加一*/
always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		addr_sin <= 8'b0;
	end
	else if(key_multiwave==0)
		addr_sin <= addr_sin + 1;	
		else
		addr_sin <= 0;
	end

	always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		addr_juchi <= 8'b0;
	end
	else if(key_multiwave==1)
				addr_juchi <= addr_juchi + 1;
			else
				addr_juchi <= 0;
	end
	always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		addr_rec <= 8'b0;
	end
	else if(key_multiwave==2)
				addr_rec <= addr_rec + 1;
			else
				addr_rec <= 0;
	end
	always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		addr_trig <= 8'b0;
	end
	else if(key_multiwave==3)
			addr_trig <= addr_trig + 1;
		else
			addr_trig <= 0; 
	end 
	
 //assign	q = sin_q | juchi_q | rec_q | trig_q;

 always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		dac_da <= 0;
	end
	else if(key_multiwave==0)
		dac_da <= sin_q;
			else if(key_multiwave==1)
		dac_da <= juchi_q;
			else if(key_multiwave==2)
		dac_da <= rec_q;
			else if(key_multiwave==3)
		dac_da <= trig_q;
		else
		dac_da <= sin_q;

end

assign dac_sleep = 0			;
assign dac_wra   = dac_clka;
assign dac_mode  = 1			;
assign dac_clka  = ~clk		;
  
endmodule