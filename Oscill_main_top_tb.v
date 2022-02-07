`timescale 1 ns/1 ns

module Oscill_main_top_tb();

//uut的输入信号
reg	               clk            ;
reg	               rst_n          ;
reg     [4:0]      key            ;
reg     [7:0]      adc_din        ;
wire	           adc_clk        ;
wire	           vga_hys        ;
wire	           vga_vys        ;
wire    [15:0]     vga_rgb        ;
reg     [15:0]     a              ;
//时钟周期，单位为ns，可在此修改时钟周期。
parameter CYCLE    = 20;

//复位时间，此时表示复位3个时钟周期的时间。
parameter RST_TIME = 3 ;
parameter ADC_CLK_TIME = 20 ;

//待测试的模块例化
Oscill_main_top test1(
	.clk       ( clk        ),      
	.rst_n     ( rst_n      ),                  
    .key       ( key        ),
	.adc_din   ( adc_din    ),
	.adc_clk   ( adc_clk    ),
	.vga_hys   ( vga_hys    ),
	.vga_vys   ( vga_vys    ),
	.vga_rgb   ( vga_rgb    )	
);

//生成本地时钟50M
initial begin
	clk = 1;
	forever
	#(CYCLE/2)
	clk=~clk;
end

//产生复位信号
initial begin
	rst_n = 1;
	#2;
	rst_n = 0;
	#(CYCLE*RST_TIME);
	rst_n = 1;
end

//输入数据
initial begin
    #50;
	key=0;
	 #(CYCLE*1000);
	 key=1;
	 #(CYCLE);
	 key=0;
	 for(a=0;a<1000;a=a+1)begin
		 for (adc_din=0 ; adc_din<256 ;adc_din=adc_din+1)begin
			#(CYCLE*14);
		 end
	end

	
end

        
endmodule


