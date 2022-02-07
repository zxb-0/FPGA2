`timescale 1 ns/1 ns

module Oscill_main_top_tb();

//uut�������ź�
reg	               clk            ;
reg	               rst_n          ;
reg     [4:0]      key            ;
reg     [7:0]      adc_din        ;
wire	           adc_clk        ;
wire	           vga_hys        ;
wire	           vga_vys        ;
wire    [15:0]     vga_rgb        ;
reg     [15:0]     a              ;
//ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
parameter CYCLE    = 20;

//��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
parameter RST_TIME = 3 ;
parameter ADC_CLK_TIME = 20 ;

//�����Ե�ģ������
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

//���ɱ���ʱ��50M
initial begin
	clk = 1;
	forever
	#(CYCLE/2)
	clk=~clk;
end

//������λ�ź�
initial begin
	rst_n = 1;
	#2;
	rst_n = 0;
	#(CYCLE*RST_TIME);
	rst_n = 1;
end

//��������
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


