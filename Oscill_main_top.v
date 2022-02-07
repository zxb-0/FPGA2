module Oscill_main_top(
	clk            ,      
	rst_n          ,                  
   key            ,
	key_5          ,
	adc_din        ,
	adc_clk        ,
	vga_hys        ,
	vga_vys        ,
	vga_rgb        
);

//时钟和复位
input	          clk            ;
input	          rst_n          ;
input    [3:0]  key            ;
input           key_5          ;
input    [7:0]  adc_din        ;
output	       adc_clk        ;
output	       vga_hys        ;
output	       vga_vys        ;
output   [15:0] vga_rgb        ;
//复位和系统输入时钟
wire	          clk            ;
wire	          rst_n          ;
//输出时钟
wire            c0_32M         ;
wire            c1_25M         ;
//VGA
wire 	          vga_hys        ;
wire 	          vga_vys        ;
wire     [15:0] vga_rgb        ;	
wire            vga_rdy        ;
//FIFO控制
wire     [7:0]  q              ;
wire            rdempty        ;
wire            wrfull         ;
wire            rd_full        ;
wire     [15:0] rd_usedw       ;
wire            rdreq          ;
wire            wrreq          ;	
//触发模式  触发判断
wire     [7:0]  sel_data_in    ;
wire            sel            ;
wire            sel_result     ;
//给ADC的分频器
wire            clk_adc        ;
wire     [4:0]  adc_clk_sel    ;
//显示模块
wire            show_en        ;
wire    [15:0]  show_addr      ;
wire    [7:0]   show_wide      ;
wire    [1:0]   show_sel       ;	   
wire    [15:0]  ram_waddr      ;
wire    [7:0]   ram_wdata      ;
wire             ram_wren  	 ; 
wire    [7:0]   ram_rdata      ;
wire    [10:0]  vga_x          ;
wire    [10:0]  vga_y          ;        	
wire	  [15:0]  ram_raddr      ;
wire	  [15:0]  vga_data       ;
wire	          vga_en         ;
wire            sel_result_out ;
//按键定义
wire     [3:0]  key            ;
wire            key_5          ;
wire            key1_l2h	    ;
wire            key2_l2h	    ;
wire            key3_l2h	    ;
wire            key4_l2h	    ;
wire            key5_l2h	    ;

wire    [2:0]       i          ;

//给外部ADC时钟   这里直接给了，没有做分频
assign adc_clk = c1_25M ;
//PLL分频  分频32M给ADC  25M给其他模块   
Oscill_PLL_32M uut0(
	.inclk0      ( clk          ),
	.c0          ( c0_32M       ),
	.c1          ( c1_25M       )
);
//主控
Oscill_main uut1(
	.clk         ( c1_25M       ),      
	.rst_n       ( rst_n        ),                  
   .sel_data_in ( sel_data_in  ),    
   .sel         ( sel          ),
   .sel_result  ( sel_result   ),
	.adc_clk_sel ( adc_clk_sel  ),
	.rdreq       ( rdreq        ),
	.wrreq       ( wrreq        ),
	.q           ( q            ),
	.rdempty     ( rdempty      ),
	.wrfull      ( wrfull       ),
	.rd_full     ( rd_full      ),
	.rd_usedw    ( rd_usedw     ),
	.key1_l2h    ( key1_l2h     ),
	.key2_l2h    ( key2_l2h     ),
	.key3_l2h    ( key3_l2h     ),
	.key4_l2h    ( key4_l2h     ),
	.key5_l2h    ( key5_l2h     ),
   .show_en     ( show_en      ),
   .show_addr   ( show_addr    ),
   .show_wide   ( show_wide    ),
	.show_sel    ( show_sel     ),
   .result_out  ( result_out   ),			
   .ram_waddr   ( ram_waddr    ),
   .ram_wdata   ( ram_wdata    ),
   .ram_wren  	 ( ram_wren     ),
	.vga_rdy     ( vga_rdy      ),
	.i           (     i        )
);
//触发选择  这里没有用分频clk_adc，直接用了25M
Oscill_sel uut2(
   .rst_n       ( rst_n        ),  
	.clk_adc     ( c1_25M       ), 
   .clk         ( c1_25M       ),
	.adc_data_in ( adc_din      ),
	.sel_data_in ( sel_data_in  ),    
   .sel         ( sel          ),
   .sel_result  ( sel_result   )	
);
//ADC的时钟输出  这里没有用分频clk_adc，直接用了25M
Oscill_adc_clk uut3(
   .rst_n       ( rst_n        ),  
   .clk         ( c1_25M       ), 
   .adc_clk_sel ( adc_clk_sel  ),
	.clk_adc     ( clk_adc      ) 
);
//FIFO    这里没有用分频clk_adc，直接用了25M
Oscill_fifo uut4(
	.data        ( adc_din    ),
	.rdclk       ( c1_25M      ),
	.rdreq       ( rdreq       ),
	.wrclk       ( c1_25M      ),
	.wrreq       ( wrreq       ),
	.q           ( q           ),
	.rdempty     ( rdempty     ),
	.rdfull      ( rd_full     ),
	.rdusedw     ( rd_usedw    ),
	.wrfull      ( wrfull      )
);	
//RAM
Oscill_ram uut5(
	.clock       ( c1_25M      ),
	.data        ( ram_wdata   ),
	.rdaddress   ( ram_raddr   ),
	.wraddress   ( ram_waddr   ),
	.wren        ( ram_wren    ),
	.q           ( ram_rdata   )
);
//show
Oscill_show uut6(
	.clk         ( c1_25M      ),
	.rst_n       ( rst_n       ),
	.show_en     ( show_en     ),
	.show_addr   ( show_addr   ),
	.show_wide   ( show_wide   ),
	.show_sel    ( show_sel    ),
	.ram_raddr   ( ram_raddr   ),
   .ram_rdata   ( ram_rdata   ),
	.vga_x       ( vga_x       ),
   .vga_y       ( vga_y       ),
	.vga_data    ( vga_data    ),
	.vga_en      ( vga_en      ),
   .sel_data_in ( sel_data_in ),
   .vga_rdy     ( vga_rdy     ),
   .result_out  ( result_out  ),
	. i          (     i       )
);
//VGA输出
Oscill_vga_driver uut7(
	.clk         (  c1_25M      ),
	.rst_n       (  rst_n       ),
	.din_en      (  vga_en      ),
   .din         (  vga_data    ),
	.vga_hys     (  vga_hys     ),
	.vga_vys     (  vga_vys     ),
	.vga_rgb     (  vga_rgb     ),
   .vga_x       (  vga_x       ),
   .vga_y	     (  vga_y	    ),
	.vga_rdy     (  vga_rdy     )
);
//按键
Oscill_key uut8(
	.clk         (   c1_25M     ),
	.rst_n       (   rst_n      ),
	.key_in      (   key        ),
	.key_5       (   key_5      ),
   .key1_l2h    (   key1_l2h   ),
	.key2_l2h    (   key2_l2h   ),
	.key3_l2h    (   key3_l2h   ),
	.key4_l2h    (   key4_l2h   ),
	.key5_l2h    (   key5_l2h   )
);
endmodule 

