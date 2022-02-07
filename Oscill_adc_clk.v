module Oscill_adc_clk(
    rst_n          ,  
    clk            , 
    adc_clk_sel    ,
	 clk_adc         
);

input         rst_n         ; 
input         clk           ;
input [4:0]   adc_clk_sel   ;
output        clk_adc       ;

wire         rst_n          ; 
wire         clk            ;
wire [4:0]   adc_clk_sel    ;
reg          clk_adc        ;


reg [16:0]   cnt1           ;
wire         add_cnt1       ;
wire         end_cnt1       ;

wire [16:0]   x             ;
reg  [16:0]   x1            ;
wire [16:0]   y             ;

//
assign  x= 17'b1 << (adc_clk_sel+1);
assign  y= 17'b1 << (adc_clk_sel);


always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        x1 <= 0;
    end
    else begin
        x1 <= x;
    end
end

//计数一个波形的总时间
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
          cnt1 <= 0;
        else if(x1!=x)
		    cnt1 <= 0;
	     else 
          cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = 1;
assign end_cnt1 = add_cnt1 && cnt1== x-1;

//输出占空比为50%的方波
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        clk_adc <= 0;
    end
    else if(cnt1 >=0 && cnt1 < y && x1==x)begin
        clk_adc <=1;
    end
	 else begin
	     clk_adc <=0;
	end
end
/*
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        clk_adc <= 0;
    end
    else begin
        clk_adc <=~clk_adc;
    end
end
*/
endmodule 

