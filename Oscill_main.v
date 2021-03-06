module Oscill_main(
	clk            ,      
	rst_n          ,                  
	//触发选择输入输出
   sel_data_in    ,    
   sel            ,
   sel_result     ,
	//ADC_CLK选择模块
	adc_clk_sel    ,
	//FIFO
	rdreq          ,
	wrreq          ,
	q              ,
	rdempty        ,
	wrfull         ,
	rd_full        ,
	rd_usedw       ,
	//按键输入
	key1_l2h       ,
	key2_l2h       ,
	key3_l2h       ,
	key4_l2h       ,
	key5_l2h       ,
    //输出图像
   show_en        ,
   show_addr      ,
   show_wide      ,
	show_sel       ,
	result_out     ,
	//RAM存储			   
   ram_waddr      ,
   ram_wdata      ,
   ram_wren  	   ,
	vga_rdy        ,
	   i
);
//时钟和复位
input           clk            ;
input           rst_n          ;
input           sel_result     ;
input           rdempty        ;
input           wrfull         ;
input           rd_full        ;	
input           key1_l2h       ;
input           key2_l2h       ;
input           key3_l2h       ;
input           key4_l2h       ;
input           key5_l2h       ;
input           vga_rdy        ;
input   [7:0]   q              ;
input   [15:0]  rd_usedw       ;

output          ram_wren  	    ;
output          sel            ;
output          rdreq          ;
output          wrreq          ;
output          show_en        ;
output          result_out     ;
output  [1:0]   show_sel       ;	
output  [7:0]   sel_data_in    ;
output  [4:0]   adc_clk_sel    ;
output  [7:0]   show_wide      ;
output  [7:0]   ram_wdata      ;
output  [15:0]  show_addr      ;
output  [12:0]  ram_waddr      ;
output  [2:0]        i         ; 

wire            clk            ;
wire            rst_n          ;
wire            sel_result     ;
wire            rdempty        ;
wire            wrfull         ;
wire            rd_full        ;
wire            key1_l2h       ;
wire            key2_l2h       ;
wire            key3_l2h       ;
wire            key4_l2h       ;
wire            key5_l2h       ;	     
wire    [7:0]   q              ;
wire    [15:0]  rd_usedw       ;

reg             rdreq          ;
reg             wrreq          ;
reg             show_en        ;
reg    [1:0]    show_sel       ;	   
reg    [7:0]    sel_data_in    ;
reg    [7:0]    ram_wdata      ;
reg    [12:0]   ram_waddr      ;
reg    [12:0]   show_addr      ;
reg    [2:0]         i         ;

wire				 show2trig_start;
wire            idl2trig_start ; 
wire            trig2ram_start ;
wire            ram2show_start ;
wire            show2idle_start;
wire            sel            ;
wire  [4:0]     adc_clk_sel    ;
wire  [15:0]    test_long_low  ;

reg             result_out     ;
reg             auto_trig      ;
reg             ram_wren  	    ;
reg             sel_result_ff0 ;
reg             sel_result_ff1 ;
reg  [7:0]      state_c        ;
reg  [7:0]      state_n        ;
reg  [12:0]     cnt1           ;
wire            add_cnt1       ;
wire            end_cnt1       ;

reg  [2:0]      cnt2           ;
wire            add_cnt2       ;
wire            end_cnt2       ;

reg             flag_add       ;

parameter   TEST_LONG   =16'd8000;
parameter   IDLE        = 8'b0000_0001;
parameter   TRIG        = 8'b0000_0010;
parameter   RAM         = 8'b0000_0100;
parameter   SHOW        = 8'b0000_1000;


assign  test_long_low = TEST_LONG >> 1; //FIFO的总长的一半，用于存储触发条件以前的点信息
assign  adc_clk_sel = 2;                //取值范围0-31     对32M的ADC时钟做4分频，就是8M采样率
assign  sel =1;                         //取值范围0-1      0就是下降沿  1就是上升沿
assign  show_wide = 0;                  //打点的宽度，暂未用到，设置为0 

//四段式状态机
//第一段：同步时序always模块，格式化描述次态寄存器迁移到现态寄存器(不需更改）
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        state_c <= IDLE;
    end
    else begin
        state_c <= state_n;
    end
end
//第二段：组合逻辑always模块，描述状态转移条件判断
always@(*)begin
    case(state_c)
        IDLE:begin
            if(idl2trig_start)begin
                state_n = TRIG;
            end
            else begin
                state_n = state_c;
            end
        end
        TRIG:begin
            if(trig2ram_start)begin
                state_n = RAM;
            end
            else begin
                state_n = state_c;
            end
        end
		RAM:begin
            if(ram2show_start)begin
                state_n = SHOW;
            end
            else begin
                state_n = state_c;
            end
        end
		SHOW:begin
            if(show2trig_start)begin
                state_n = TRIG;
            end
            else begin
                state_n = state_c;
            end
        end
		SHOW:begin
            if(show2idle_start)begin
                state_n = IDLE;
            end
            else begin
                state_n = state_c;
            end
        end
        default:begin
            state_n = IDLE;
        end
    endcase
end
//第三段：设计转移条件
assign idl2trig_start  = state_c == IDLE  && key1_l2h ;                           //开始检测按键按下 
assign trig2ram_start  = state_c == TRIG  && wrfull  || rd_usedw >= TEST_LONG;    //FIFO写满 或者写到设定大小  
assign ram2show_start  = state_c == RAM   && rdempty || end_cnt1 ;                //FIFO读空 或者读完设定大小
assign show2trig_start = state_c == SHOW  && (key1_l2h ||(auto_trig && vga_rdy ));//按键按下，或者在自动读取模式下刷新一帧画面那就继续捕获信号 
assign show2idle_start = state_c == SHOW  && key2_l2h  ;                          //回到待机界面
/*****************************************/
//触发状态  state_c == TRIG
//自动扫描 选择
//触发阈值设置
//assign  sel_data_in = 50; //取值范围0-255    ADC触发的阈值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        sel_data_in <= 1;
    end
    else if(key3_l2h)begin
        sel_data_in <= sel_data_in +5 ;
    end
	else if(key4_l2h)begin
        sel_data_in <= sel_data_in -5 ;
    end
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt2 <= 1;
    end
    else if(add_cnt2)begin
	     if(end_cnt2)
		      cnt2<=1;
        else 
		      cnt2<=cnt2+1;
    end
end

assign add_cnt2 = key1_l2h ;
assign end_cnt2 = add_cnt2&&cnt2 ==7-1;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        flag_add <= 0;
    end
    else if(end_cnt2)begin   
        flag_add<=~flag_add;
    end
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        i<= 1;
    end
    else if(flag_add)begin   
        i <=cnt2 ;
    end
	 else begin
        i<= 7-cnt2 ;
    end
end

//先让FIFO保存一半的空白数据  
//rd_usedw FIFO有多少个数据
//test_long_low 设定FIFO长度的值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        sel_result_ff0 <= 0;
    end
    else if(state_c == TRIG && (rd_usedw > test_long_low )  )begin
        sel_result_ff0 <= 1 ;
    end
	else if(state_c == SHOW)begin
        sel_result_ff0 <= 0 ;
    end
end
//在FIFO一半空白数据的时候，捕获到一次触发,使能一个辅助信号，辅助信号直到本次状态读完，再清零
//sel_result_ff1  触发捕获模块输出信号
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        sel_result_ff1 <= 0;
    end
    else if(sel_result_ff0 && sel_result)begin   
        sel_result_ff1 <= 1 ;
    end
	else if(state_c == SHOW)begin
        sel_result_ff1 <= 0 ;
    end
end
//捕获到一次信号，输出给图像，可以刷新那些辅助的点了
//result_out  输出辅助点的辅助信号result_out = 1时，输出
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        result_out <= 0;
    end
	else if(ram2show_start)begin
        result_out <= 1;
    end
    else if(show2trig_start)begin
        result_out <= 0;
    end 
	
end
//触发等待状态下，FIFO中的数据不足设定值，只写不读；数据写足了，但没触发条件，一边写一边读；数据写足了，也有触发条件了，就一直写不读，直到写满跳转下一状态。
//如果触发条件有效或者FIFO中的数据不足30000，则只写不读
//否则 边写边读
//写和读都需要判断FIFO非空或者非满
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rdreq <= 0 ;
		wrreq <= 0 ;
    end
	else if(state_c == TRIG) begin    //触发模式下
	    if(sel_result_ff0==0) begin   //FIFO还没有写一半   只写不读
		    rdreq <=0 && !rdempty;
			wrreq <=1 && !wrfull;
		end
		else if(sel_result_ff0==1 && sel_result_ff1 ) begin    //FIFO写了一半数据了，而且有触发条件了，就一直写，写满或者写到指定大小，就跳转状态 
			rdreq <=0 && !rdempty;
			wrreq <=1 && !wrfull;
		end	
		else if(sel_result_ff0 ) begin                        //FIFO写了一半数据了，还没有触发条件，就一直写，一直读
		        if(rd_usedw > test_long_low ) begin          //FIFO数据大于设定值的一半，还没有触发，就读
					rdreq <=1 && !rdempty;
					wrreq <=1 && !wrfull;
				end
				else begin                                   //否则就写
				    rdreq <=0 && !rdempty;
					wrreq <=1 && !wrfull;
				end
		end
	end
	else if(state_c == RAM)begin    //读取FIFO模式下，只读不写  读空或者读够个数跳转下一状态
            rdreq <= 1 && !rdempty;
			wrreq <= 0 ;
    end
	else begin
		rdreq <= 1 && !rdempty ;
		wrreq <= 0 ;
    end
end
//state_c == RAM 状态
//FIFO数据转到RAM状态
//搬运数据的计数器
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end
assign add_cnt1 = state_c == RAM ;  
assign end_cnt1 = add_cnt1 && cnt1== TEST_LONG -1;  //FIFO和RAM都是这个大小
//RAM写的地址和数据
//q是FIFO的输出数据
always @( posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        ram_wren  <=0 ;
	    ram_wdata <=0 ;
		ram_waddr <=0 ;
    end
	else if(state_c == RAM )begin  
        ram_wren  <= 1;
	    ram_wdata <= q*2+8'h5f; //xiaobu
		ram_waddr <= cnt1;
    end
	else begin
	    ram_wren  <=0 ;
	    ram_wdata <=0 ;
		ram_waddr <=0 ;
	end	 
end
//show_addr 为刷新VGA的时候从FIFO里哪个点（位置或地址）取数据
//test_long_low为FIFO的一半位置，也是触发位置。我们要将触发位置显示在屏幕的中间位置，将触发位置的前、后部分信号在屏幕上显示。
//因为屏幕有640个点，所以我们需要从FIFO里的test_long_low- 320这个位置开始取数据（显示在屏幕的左边）
always @( * )begin 
	if(test_long_low > 320)begin
        show_addr = test_long_low- 320;
    end
    else begin
	    show_addr = test_long_low;
	end
end
//在SHOW模式下才能输出画面
//show_sel刷新的模式
//show_en刷新使能
always @( * )begin 
	if(state_c == SHOW)begin
        show_sel = 2;
		show_en  = 1;
    end
    else begin
	    show_sel = 0;
		show_en  = 0;
	end
end
//判断是不是设定了自动触发和自动打点功能
//按键5按下，auto_trig==1为自动触发模式
//按键5松开，auto_trig==0为手动触发模式 
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        auto_trig <= 0;
    end 
	else if(key5_l2h)begin
        auto_trig <= 1;
    end 
    else begin
        auto_trig <= 0;
    end	
end


endmodule 

//Oscii_fifo为了让触发位置在FIFO中间位置，在等待触发状态下，如果FIFO里面的数据个数大于设定值（500）,就输出sel_result_ff0=1，如果sel_result_ff0=1并且在触发条件（sel_result==1）就输出sel_result_ff1==1.
//如果sel_result_ff0=1&&sel_result_ff1==1，就让Oscii_fifo一直写
//触发条件位置设定在100，让其与Oscii_sel模块中的FIFO（缓存ADC的数据，数据一进一出）输出值q作判断，是否是达到触发条件
//让触发位置保存于FIFO中的中间位置，然后取其前面数据的320个和后面数据的320个，刚好640个数，让其刚好显示在640*480的屏幕上。
//eg.中间位置为500,则取数范围为180-820之间，这样取RAM中的数据地址由180到820.show2trig_start
//由于输入的ADC信号（保存在RAM中的数据）最大值为256，故可以将VGA显示区域的高度设为265即场信号个数为256（并由场信号计数器对这256个数进行排列），
//将他与RAM中的数据进行比较，相等则在该处打点（输出一个黄色的RGB信号）。