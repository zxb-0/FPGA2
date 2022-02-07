module Oscill_show(
	clk         ,
	rst_n       ,
	show_en     ,
	show_addr   ,
	show_wide   ,
	show_sel    ,
	ram_raddr   ,
   ram_rdata   ,
	vga_x       ,
   vga_y       ,
	vga_data    ,
	vga_en      ,
   sel_data_in	,
	vga_rdy     ,
   result_out	,
      i        	
);

//鏁版嵁杈撳叆鎺ュ彛
input             clk         ;
input             rst_n       ;
input             show_en     ;
input   [15:0]    show_addr   ; 
input   [7:0]     show_wide   ;   
input   [1:0]     show_sel    ;     
input   [7:0]     ram_rdata   ;
input   [10:0]    vga_x       ;
input   [10:0]    vga_y       ;   
input   [7:0]     sel_data_in ; 
input             vga_rdy     ;  
input             result_out  ; 
input   [2:0]         i       ;

   	
output  [15:0]   ram_raddr    ;
output  [15:0]   vga_data     ;
output	         vga_en      ;

wire    [2:0]       i         ;
wire              clk         ;
wire              rst_n       ;
wire              show_en     ;
wire    [15:0]    show_addr   ; 
wire    [7:0]     show_wide   ; 
wire    [1:0]     show_sel    ;      
wire    [7:0]     ram_rdata   ;
wire    [10:0]    vga_x       ;
wire    [10:0]    vga_y       ;  
wire    [7:0]     sel_data_in ;        	
reg     [15:0]    ram_raddr   ;
reg     [15:0]    vga_data    ;
reg               vga_en      ;
wire              add_flag    ;
reg     [8:0]      cnt0       ;
wire    [8:0]      vga_cnt0   ;
wire              add_cnt0    ;
wire              end_cnt0    ;
wire              result_out  ; 
reg     [7:0]    ram_rdata_ff0;
/*
鍥犱负鏄í鍚戞樉绀闀垮害搴旇鏄樉绀哄櫒鐨刋杞撮暱搴   640
FIFO鐨勪腑闂翠竴涓暟鎹槸瑙﹀彂绔紝鎵€浠ヤ繚瀛樺埌RAM涔熸槸涓棿鍊
閭ｄ箞鍒锋柊鍒癡GA鏄剧ず鍣ㄧ殑鏁版嵁锛岄渶瑕佷粠RAM鐨勪腑闂村紑濮嬭幏鍙
*/
//VGA鍒锋柊寮€濮
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		vga_en <= 0;
	end 
	else begin
        vga_en <= show_en;
    end
end
//闇€瑕佸幓RAM涓鍙栫殑鍦板潃锛屽湪main妯″潡涓煡閬擄紝show_addr锛坮am_raddr锛変负瀵归綈鏄剧ず鍣ㄥ乏杈圭殑绗竴涓偣,
//鑰岄渶瑕佹妸RAM涓暟鎹殑鍦板潃璺熸樉绀哄櫒鐨刋杞翠竴涓€瀵瑰簲灏辫鍦ㄥ叾鍩虹涓婂姞涓妚ga_x锛岄殢鐫€vga_x鐨勫鍔狅紝灏变細鎶奟AM涓殑鏁版嵁缁欓€愭笎鍙栧嚭鏉ャ€
always @( * )begin
	if(add_flag) begin
        ram_raddr = show_addr + vga_x*i;
    end
	else begin
	    ram_raddr =0;
	end 
end
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		ram_rdata_ff0 <= 0;
	end 
	else if(add_flag)begin
        ram_rdata_ff0 <= ram_rdata;
    end
end


wire len_flag;   //妫€娴嬬嚎
wire len_flag2;  //缁胯壊鏍呮牸绾
wire flag_wave;  //
//RAM杈撳嚭鐨勬暟鎹ram_rdata
always @( posedge clk or negedge rst_n)begin
    if(!rst_n)begin
		vga_data <= 0;
	end 
	else if(add_flag)begin
	   if(show_sel==2 && flag_wave)  //RAM涓殑鐐瑰拰璁℃暟鍣ㄥ€肩浉绛
                vga_data = 16'hffe0;  //鍘熻緭鍏ョ偣(榛勮壊)
		else if(ram_rdata > ram_rdata_ff0 && vga_cnt0 >= ram_rdata_ff0 && vga_cnt0 < ram_rdata && result_out) 
			vga_data = 16'hffe0;      //黄色
		else if(ram_rdata < ram_rdata_ff0 && vga_cnt0 >= ram_rdata && vga_cnt0 < ram_rdata_ff0 && result_out ) 
			vga_data = 16'hffe0;      //黄色
		else if(len_flag)             //妫€娴嬬嚎
		    vga_data = 16'hec66;
		else if(len_flag2)            //绿色
		    vga_data = 16'h07e0;
		else 
		    vga_data = 16'h0000;       //RAM涓殑鐐瑰拰璁℃暟鍣ㄥ€间笉鐩哥瓑
    end
	else begin  //涓嶅湪鏈夋晥鍖哄煙
		    vga_data =16'he73c;
	end
end
//鍒锋柊鐣岄潰
//RAM杈撳嚭鐨勬暟鎹ram_rdata
assign flag_wave=(vga_cnt0 == ram_rdata ) ;
assign add_flag  = (vga_y >= 112) && (vga_y < 368);     //鍒锋柊鍖哄煙
assign vga_cnt0  = 368 - vga_y;                         //涓嶳AM涓繘鏉ョ殑鍒锋柊鐐逛綔姣旇緝鐨勫€硷紙鍗砎GA鏄剧ず灞忓箷涓婄殑Y杞村潗鏍囧€硷級
assign len_flag  = (vga_cnt0==sel_data_in) || (vga_cnt0>=1 && vga_cnt0 < 255 && vga_x ==322) ; 
assign len_flag2 = (vga_x[4:0]==1 && vga_y[1]==1) || (vga_y[4:0]==1 && vga_x[1]==1) ;  //缁胯壊鏍呮牸绾
                                                                                       //纭繚vga_x鐨勪綆鍥涗綅vga_x[4:0]==5'b00001鎴愮珛锛屽嵆vga_x鍙栦互姣2闂撮殧鐨勬暟鎹銆3銆5....
                                                                                       //vga_y[1]=1锛屽嵆鍙栨墍鏈夋弧瓒充綆浜屼綅vga_y[1]=1鐨勬暟
endmodule

