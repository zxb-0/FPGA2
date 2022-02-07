module Oscill_vga_driver(
	clk         ,
	rst_n       ,
	din_en      ,
   din         ,
	vga_hys     ,
	vga_vys     ,
	vga_rgb     ,
   vga_x       ,
   vga_y	      ,
	vga_rdy    
);

parameter       SHOW_X_B    = 144;    //VGA图像行起点
parameter       SHOW_X_E    = 144+640;//VGA图像行结束
parameter       SHOW_Y_B    = 35;     //VGA图像场起点
parameter       SHOW_Y_E    = 35+480; //VGA图像场结束

// 分辨率 640*480  频率25MHZ
parameter       TIME_HYS    = 800;//行 脉冲数
parameter       TIME_VYS    = 525;//垂直 脉冲数


//数据输入接口
input                   clk             ;
input                   rst_n           ;
input                   din_en          ;
input       [15:0]      din             ;
output                  vga_hys         ;
output                  vga_vys         ;
output      [15:0]      vga_rgb         ;
output      [10:0]      vga_x           ;
output      [10:0]      vga_y           ;
output                  vga_rdy         ;

wire							display_area	 ;
wire                    clk             ;
wire                    rst_n           ;
wire                    din_en          ;
wire       [15:0]       din             ;
reg                     vga_hys         ;
reg                     vga_vys         ;
reg        [15:0]       vga_rgb         ;
reg        [10:0]       vga_x           ;
reg        [10:0]       vga_y           ;
reg                     vga_rdy         ;

reg                     flag_add        ;
reg         [ 10:0]     cnt0            ;
wire                    add_cnt0        ;
wire                    end_cnt0        ;
reg         [ 10:0]     cnt1            ;
wire                    add_cnt1        ;
wire                    end_cnt1        ;


//输入一个din_en  刷新一次VGA画面
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		flag_add <= 0;
	end
	else if(din_en)begin
		flag_add <= 1;
	end
	else if(end_cnt1)begin
	    flag_add <= 0;
	end
end
//画面刷新完   输出一个脉冲
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		vga_rdy <= 0;
	end
	else if(end_cnt1)begin
		vga_rdy <= 1;
	end
	else begin
	    vga_rdy <= 0;
	end
end
//行计数器
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt0 <= 0;
	end
	else if(add_cnt0)begin
		if(end_cnt0)
			cnt0 <= 0;
		else
			cnt0 <= cnt0 + 1;
	end
end
assign add_cnt0 = 1;
assign end_cnt0 = add_cnt0 && cnt0 == TIME_HYS-1;//行同步
//行坐标值
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
		vga_x <= 0;
	end
	else if(cnt0 >= SHOW_X_B && cnt0 < SHOW_X_E )begin
		vga_x <= cnt0 - SHOW_X_B ;
	end
   else begin
	    vga_x <= 0 ;
	end
end
//垂直计数器
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
assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1 == TIME_VYS-1;
//场坐标值
always @( posedge clk or negedge rst_n )begin
	if(!rst_n)begin
		vga_y <= 0;
	end
	else if(cnt1 >= SHOW_Y_B && cnt1 < SHOW_Y_E)begin
		vga_y <= cnt1 - SHOW_Y_B ;
	end
   else begin
	    vga_y <= 0 ;
	end
end

//行信号
always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		vga_hys <= 1'b0;
	end
	else if(add_cnt0 && cnt0 == 96-1)begin
		vga_hys <= 1'b1;
	end
	else if(end_cnt0)begin
		vga_hys <= 1'b0;
	end
end

//场信号
always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		vga_vys <= 1'b0;
	end
	else if(add_cnt1 && cnt1 == 2-1)begin
		vga_vys <= 1'b1;
	end
	else if(end_cnt1)begin
		vga_vys <= 1'b0;
	end
end

//VGA刷新区域
assign display_area = add_cnt0 && (cnt0>=(SHOW_X_B-1) && cnt0<(SHOW_X_E-1)) && (cnt1>=(SHOW_Y_B-1) && cnt1<(SHOW_Y_E-1)); 
always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		vga_rgb <= 16'd0;
	end
	else if(display_area)begin                     //是VGA输出的画面 去掉前沿，后沿等
		vga_rgb <= din;
	end
	else begin
		vga_rgb <= 0;
	end
end

endmodule

