module Oscill_key(
	clk         ,
	rst_n       ,
	key_in      ,
	key_5       ,
   key1_l2h    ,
	key2_l2h    ,
	key3_l2h    ,
	key4_l2h    ,
	key5_l2h    	
);
//鏁版嵁杈撳叆鎺ュ彛
input         clk         ;
input         rst_n       ;
input [3:0]   key_in      ;
input         key_5       ;
output        key1_l2h	  ;
output        key2_l2h	  ;
output        key3_l2h	  ;
output        key4_l2h	  ;
output        key5_l2h	  ;

wire         clk          ;
wire         rst_n        ;
wire [3:0]   key_in       ;
wire         key_5        ;
reg          key1_l2h	  ;
reg          key2_l2h	  ;
reg          key3_l2h	  ;
reg          key4_l2h	  ;
reg          key5_l2h	  ;
reg  [4:0]   key_in_old   ;
reg  [4:0]   key_out      ;
reg  [4:0]   key_out_old  ;
						  
reg  [31:0]  cnt0         ;
wire         add_cnt0     ;
wire         end_cnt0     ;


//鎸夐敭鍘绘姈鍔ㄥ欢鏃
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
	else 
	    cnt0 <= 0;
end
assign add_cnt0 =  key_in != key_in_old ; 
assign end_cnt0 = add_cnt0 && cnt0 == 250_000-1;  //鎸夐敭鍘绘姈鍔


//淇濆瓨鎸夐敭涓婁竴娆＄姸鎬侊紝灏辨槸瑙﹀彂涓€娆℃湁鏁
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_in_old <= 0;
	end
	else if(end_cnt0)begin
		key_in_old <= key_in;
	end
end

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key5_l2h <= 0;
	end
	else begin
		key5_l2h <= key_5;
	end
end

//鍒ゆ柇鏄摢涓€兼寜涓
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_out <= 0;
	end
	else if(end_cnt0)begin
	   if( key_in == 4'b1110)
		    key_out <=1;
		else if( key_in == 4'b1101)
		    key_out <=2;
		else if( key_in == 4'b1011)
		    key_out <=3;
		else if( key_in == 4'b0111)
		    key_out <=4;
		else 
		    key_out <=0;
	end
end
//鍒ゆ柇鏄笂鍗囨部
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        key_out_old <= 0;
    end
	else begin
        key_out_old <= key_out ;
    end
end
//杈撳嚭鎸夐敭涓€涓剦鍐
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
      key1_l2h <= 0;
		key2_l2h <= 0;
		key3_l2h <= 0;
		key4_l2h <= 0;
    end
	else if(key_out ==1  && key_out_old ==0)begin
        key1_l2h <= 1 ;
    end
	else if(key_out ==2  && key_out_old ==0)begin
        key2_l2h <= 1 ;
    end
	else if(key_out ==3  && key_out_old ==0)begin
        key3_l2h <= 1 ;
    end
	else if(key_out ==4  && key_out_old ==0)begin
        key4_l2h <= 1 ;
    end
	else begin
	   key1_l2h <= 0;
		key2_l2h <= 0;
		key3_l2h <= 0;
		key4_l2h <= 0;
	end	    
end
endmodule

