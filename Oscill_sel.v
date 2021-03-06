module Oscill_sel(
    rst_n          ,  
	 clk_adc        , 
    clk            ,
	 adc_data_in    ,
	 sel_data_in    ,    
    sel            ,
    sel_result    	
);
input          rst_n          ;  
input          clk_adc        ; 
input          clk            ;
input [7:0]    adc_data_in    ;
input [7:0]    sel_data_in    ;    
input          sel            ;		       
output         sel_result     ;
wire           rst_n          ;  
wire           clk_adc        ; 
wire           clk            ;
wire  [7:0]    adc_data_in    ;
wire  [7:0]    sel_data_in    ;    
wire           sel            ;		      
reg            sel_result     ;
wire  [7:0]    q              ;
reg   [7:0]    q_ff0          ;
wire           rdreq          ;
wire           wrreq          ;
wire           rdempty        ;
wire           wrfull         ;

assign wrreq =  !wrfull;   //非满 才写
assign rdreq =  !rdempty;  //非空 才读

//判断FIFO    一进一出，一直循环
Oscill_fifo_sel Oscilloscope_sel_uut (
	.data    (    adc_data_in  ),
	.rdclk   (    clk          ),
	.rdreq   (    rdreq        ),
	.wrclk   (    clk_adc      ),
	.wrreq   (    wrreq        ),
	.q       (    q            ),
	.rdempty (    rdempty      ),
	.wrfull  (    wrfull       )
);
//q打一拍为下一次计算做准备
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        q_ff0 <= 0;
    end
    else begin
	    q_ff0 <= q;//xiaobu
	end
end
//sel==1  上升沿触发
//sel==0  下降沿触发
//sel_data_in 输入的数据
//q_ff0    上一拍的值
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        sel_result <= 0;
   end
	else if(sel==1 && ( q >= sel_data_in )&&( q_ff0 < sel_data_in ) )begin  //ADC输入值大于设定值  就是上升沿  
        sel_result <= 1; 
    end
	else if(sel==0 && ( q <= sel_data_in )&&( q_ff0 > sel_data_in ))begin  //ADC输入值小于设定值  就是下升沿  
        sel_result <= 1; 
    end
	else 
	    sel_result <= 0;
end
endmodule 
